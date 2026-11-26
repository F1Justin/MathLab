#!/usr/bin/env python3
"""Replay the partition certificates from frozen source without changing it."""
from argparse import ArgumentParser
import json
from math import comb
from pathlib import Path
import shutil
import subprocess
import sys
from tempfile import TemporaryDirectory


HERE = Path(__file__).resolve().parent
CHECKS = {
    "saddle": ("saddle_certificate", (), "saddle_certificate"),
    "finite": ("bracket_interlacing", ("4", "2004", "--max-lag", "4"), "finite_2004_window"),
    "outer": ("effective_outer", (), "effective_outer"),
    "inner": ("effective_inner", (), "effective_inner"),
}


def load(path):
    return json.loads(path.read_text(encoding="utf-8"))


def compare(name, output, expected):
    actual_certificate = {k: v for k, v in output.items() if k != "elapsed_seconds"}
    frozen_certificate = {k: v for k, v in expected.items() if k != "elapsed_seconds"}
    if actual_certificate != frozen_certificate:
        raise RuntimeError(f"{name}: regenerated record differs from the frozen certificate")


def replay(name, source, temporary):
    script, args, frozen_stem = CHECKS[name]
    working_script = temporary / (script + ".py")
    shutil.copyfile(source / working_script.name, working_script)
    result = subprocess.run(
        [sys.executable, str(working_script), *args],
        cwd=temporary,
        check=True,
        text=True,
        stdout=subprocess.PIPE,
    )
    if name in {"saddle", "finite"}:
        output = json.loads(result.stdout)
    else:
        output = load(working_script.with_suffix(".json"))
    compare(name, output, load(source / (frozen_stem + ".json")))
    return output


def verify_factorial_lift():
    rows = [[1]]
    for n in range(1, 12):
        row = [0] * (n // 4 + 1)
        for block_size in range(1, n + 1):
            choices = comb(n - 1, block_size - 1)
            for k, count in enumerate(rows[n - block_size]):
                row[k + (block_size >= 4)] += choices * count
        rows.append(row)
    discriminants = [b * b - 8 * a * c for a, b, c in rows[8:12]]
    expected = [977225, 20387812, 188097001, -16572783743]
    if rows[11] != [312676, 318671, 47223] or discriminants != expected:
        raise RuntimeError("factorial-lift witness does not match the manuscript")
    return {"row_11": rows[11], "factorial_lift_discriminants_8_through_11": discriminants}


def main():
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("--snapshot", type=Path, default=HERE.parents[1] / "snapshot")
    parser.add_argument("--out", type=Path, required=True, help="Directory for new result records.")
    parser.add_argument("--only", choices=(*CHECKS, "factorial-lift"),
                        help="Replay one certificate instead of the full suite.")
    args = parser.parse_args()
    source = args.snapshot.resolve() / "research" / "partitions"
    out = args.out.resolve()
    if out.is_relative_to(args.snapshot.resolve()):
        parser.error("choose an output directory outside the frozen snapshot")
    out.mkdir(parents=True, exist_ok=True)
    names = [args.only] if args.only else [*CHECKS, "factorial-lift"]
    with TemporaryDirectory(prefix="mathlab-partitions-") as directory:
        for name in names:
            output = (verify_factorial_lift() if name == "factorial-lift"
                      else replay(name, source, Path(directory)))
            (out / (name + ".json")).write_text(json.dumps(output, indent=2) + "\n",
                                                encoding="utf-8")
            print(f"{name}: verified", flush=True)


if __name__ == "__main__":
    main()
