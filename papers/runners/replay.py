#!/usr/bin/env python3
"""Replay the exact shifted-runner certificates from the frozen MathLab snapshot."""

import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path
from tempfile import TemporaryDirectory


HERE = Path(__file__).resolve().parent
RUNNER = Path("research/runner")

RULE_INPUTS = """
from pathlib import Path
import sys

sys.path.insert(0, str(Path("research/runner")))
from packing import rules

for removed, groups in rules:
    prescribed = [speed for speeds, _, _ in groups for speed in speeds]
    assert len(removed) == len(set(removed))
    assert len(prescribed) == len(set(prescribed))
    assert all(speed > 0 and speed % 2 == 0 for speed in removed)
    assert all(speed > 0 for speed in prescribed)
    assert set(removed).isdisjoint(prescribed)
print("Three source rule tables have distinct, compatible entries.")
"""

SHARP_EXTENSION = """
import json
from fractions import Fraction as Q
from pathlib import Path
import sys

sys.path.insert(0, str(Path("research/runner")))
from optimal_extension import all_extensions, gaps

seed = json.loads(Path("package1/results/known_slr_57.json").read_text())
d = Q(1359451, 79000000)
speed = 528344
phase = Q(4737613, 31600000)
width = Q(178783, 158000000)
assert len(seed["speeds"]) == len(set(seed["speeds"])) == 57
assert speed not in seed["speeds"]
bound, count, longest, hits = all_extensions(seed, d)
assert (bound, count, longest) == (820800, 11, Q(53, 1264000000))
assert hits == [(speed, phase, width)]
_, strict_count, _, strict_hits = all_extensions(seed, d, strict=True)
assert strict_count == 12 and not strict_hits
for a, b in gaps(seed, d):
    k = round(speed * (a + b) / 2 + phase)
    assert -d <= speed*a + phase - k <= speed*b + phase + width - k <= d
t = Q(38586773, 79000000)
distances = {}
for v, numerator in zip(seed["speeds"], seed["shift_num"]):
    coordinate = v*t + Q(numerator, seed["shift_den"])
    distances[v] = abs(coordinate - round(coordinate))
assert min(distances.values()) == distances[44] == distances[114] == d
coordinate = speed*t + phase
distance = abs(coordinate - round(coordinate))
assert distance == Q(66324111, 158000000) and distance - width > d
print("Verified exact radius, unique speed and all optimal phases.")
"""

BOX_REPLAY = """
import json
from fractions import Fraction as Q
from pathlib import Path
import sys

directory = Path("research/runner")
sys.path.insert(0, str(directory))
from endpoint_solver import solve

data = json.loads((directory / sys.argv[1]).read_text())
speeds = data["speeds"]
phases = data["original_phases"]
result = solve(speeds, [Q(phase) for phase in phases],
               Q(data["phase_halfwidth"]), Q(data["radius"]), int(sys.argv[2]))
result.update(base=data["base"], speeds=speeds, original_phases=phases)
print(json.dumps(result, indent=2))
"""

SAT_REPLAY = """
import json
from fractions import Fraction
from pathlib import Path
import sys

directory = Path("research/runner")
sys.path.insert(0, str(directory))
from direct_rule_search import search

for filename in ("direct_rule_search.log", "direct_rule_frontier.log"):
    for line in (directory / filename).read_text().splitlines():
        stored = json.loads(line)
        result = search(
            stored["K"], tuple(stored["primes"]), stored["phase_denom"],
            [Fraction(value) for value in stored["shifts"]],
            stored["odd_speed_cap"], 60, stored["template"],
        )
        print(json.dumps(result), flush=True)
        if result["state"] != stored["state"]:
            raise RuntimeError(f"Expected {stored['state']}, got {result['state']}")
"""


def run(root, name, args, logs):
    print(name, flush=True)
    env = dict(os.environ, PYTHONDONTWRITEBYTECODE="1", PYTHONOPTIMIZE="0")
    result = subprocess.run(
        [sys.executable, *args],
        cwd=root,
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        check=False,
    )
    if logs:
        (logs / f"{name}.log").write_text(result.stdout)
    else:
        print(result.stdout, end="")
    result.check_returncode()
    return result.stdout


def run_script(root, name, script, logs, *args):
    return run(root, name, [str(RUNNER / script), *args], logs)


def check_json(result, expected, name):
    with expected.open() as stream:
        observed = json.load(stream)
    if observed != result:
        raise RuntimeError(f"{name} differs from the frozen certificate")


def packing(root, source, logs):
    expected = source / RUNNER
    run(root, "rule-inputs", ["-c", RULE_INPUTS], logs)
    recorded = run_script(root, "packing", "packing.py", logs)
    check_json(json.loads(recorded), expected / "packing.json", "disjoint recipes")
    for name in ("overlap_packing", "periodic_packing"):
        run_script(root, name, f"{name}.py", logs)
        data = json.loads((root / RUNNER / f"{name}.json").read_text())
        check_json(data, expected / f"{name}.json", name)
    rows = run_script(root, "local-pivot", "local_pivot.py", logs, "2", "4", "6", "8", "10", "12")
    results = [json.loads(line) for line in rows.splitlines()]
    if len(results) != 6 or any(row["solution"] is not None for row in results):
        raise RuntimeError("Unexpected affine local rule search result")


def frozen(root, source, logs):
    expected = source / RUNNER
    run(root, "original-seed-cover", [
        "package1/verify_shifted.py", "package1/results/known_slr_57.json",
    ], logs)
    run(root, "sharp-extension", ["-c", SHARP_EXTENSION], logs)
    for name in ("single_replacement", "triple_replacement"):
        run_script(root, name, f"{name}.py", logs)
        data = json.loads((root / RUNNER / f"{name}.json").read_text())
        check_json(data, expected / f"{name}.json", name)
    recorded = run_script(root, "one-extra", "frozen_extension.py", logs)
    one = json.loads(recorded)
    if one["solutions"] or one["speed_bound"] != 380 or one["gap_count"] != 207:
        raise RuntimeError("Unexpected one-extra result")
    recorded = run_script(root, "two-extra", "two_runner_obstruction.py", logs)
    check_json(json.loads(recorded), expected / "two_runner_result.json", "two-extra")
    weights = json.loads((expected / "residual_weights.json").read_text())
    if len(weights) != 207 or any(type(weight) is not int or weight < 0 for weight in weights):
        raise RuntimeError("The residual densities must be 207 nonnegative integers")
    for name in ("residual_mass", "weighted_residual"):
        recorded = run_script(root, name, f"{name}.py", logs)
        check_json(json.loads(recorded), expected / f"{name}.json", name)
    recorded = run_script(root, "weighted-prefix", "check_residual_weights.py", logs)
    expected_prefix = {
        "exact_fraction": "20159589/153120431",
        "necessary": 8,
        "verified_intervals": 121,
    }
    if json.loads(recorded) != expected_prefix:
        raise RuntimeError("Unexpected weighted prefix check")
    run_script(root, "two-speed-self-test", "two_speed_search.py", logs, "--self-test")


def phase_boxes(root, source, logs, seconds):
    run_script(root, "standard-box-core", "check_endpoint_boxes.py", logs,
               str(RUNNER / "standard58_core.json"), str(seconds))
    for base in ("standard", "chain"):
        name = f"phase-box-{base}-58"
        certificate = f"{base}58_box.json"
        output = run(root, name, ["-c", BOX_REPLAY, certificate, str(seconds)], logs)
        check_json(json.loads(output), source / RUNNER / certificate, name)
    for n, radius, verdict in (("4", "1/5", "unsat"), ("5", "1/6", "sat")):
        name = f"phase-box-control-{n}"
        filename = f"{name}.json"
        run_script(root, name, "endpoint_solver.py", logs,
                   "--base", "standard", "--n", n, "--eps", "1/2",
                   "--radius", radius, "--seconds", str(seconds), "--out", filename)
        output = (root / filename).read_text()
        data = json.loads(output)
        if logs:
            (logs / filename).write_text(output)
        if data["status"] != verdict:
            raise RuntimeError(f"{name} returned {data['status']}, expected {verdict}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("suite", choices=["packing", "frozen", "boxes", "menus", "exact"],
                        nargs="?", default="exact")
    parser.add_argument("--snapshot", type=Path, default=HERE.parents[1] / "snapshot")
    parser.add_argument("--logs", type=Path)
    parser.add_argument("--z3-seconds", type=int, default=480)
    args = parser.parse_args()
    source = args.snapshot.resolve(strict=True)
    logs = args.logs.resolve() if args.logs else None
    if logs:
        logs.mkdir(parents=True, exist_ok=True)
    with TemporaryDirectory(prefix="mathlab-runners-") as temporary:
        root = Path(temporary)
        shutil.copytree(source / RUNNER, root / RUNNER)
        (root / "package1/results").mkdir(parents=True)
        shutil.copy(source / "package1/verify_shifted.py", root / "package1")
        shutil.copy(source / "package1/results/known_slr_57.json", root / "package1/results")
        if args.suite in ("packing", "exact"):
            packing(root, source, logs)
        if args.suite in ("frozen", "exact"):
            frozen(root, source, logs)
        if args.suite == "boxes":
            phase_boxes(root, source, logs, args.z3_seconds)
        if args.suite == "menus":
            run(root, "finite-menus", ["-c", SAT_REPLAY], logs)


if __name__ == "__main__":
    main()
