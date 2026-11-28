"""Export the final WT proofs and replay their dependencies in an empty Lean kernel."""

import argparse
import json
import os
from pathlib import Path
import re
import subprocess
from tempfile import TemporaryDirectory


LEAN = Path(__file__).resolve().parent
AUDIT = LEAN / "MathLab" / "WT" / "AxiomAudit.lean"
ALLOWED = {"Classical.choice", "propext", "Quot.sound"}


def check_export(path, targets):
    """Read Lean 4.35's line-oriented export, including its interned name table."""
    names = {0: ""}
    axioms = set()
    found = set()
    with path.open("rb") as stream:
        for line in stream:
            if line.startswith(b'{"in":'):
                entry = json.loads(line)
                part = entry["str"] if "str" in entry else entry["num"]
                prefix = names[part["pre"]]
                suffix = part["str"] if "str" in part else str(part["i"])
                names[entry["in"]] = f"{prefix}.{suffix}" if prefix else suffix
            elif line.startswith(b'{"axiom":'):
                axioms.add(names[json.loads(line)["axiom"]["name"]])
            elif line.startswith(b'{"thm":'):
                name = names[json.loads(line)["thm"]["name"]]
                if name in targets:
                    found.add(name)
    if axioms != ALLOWED:
        raise ValueError(f"unexpected axiom set {sorted(axioms)}")
    if found != set(targets):
        raise ValueError(f"missing theorems {sorted(set(targets) - found)}")
    print(f"Found {len(found)} requested theorems. Axioms: {', '.join(sorted(axioms))}.", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--keep-export", type=Path, help="retain the proof graph at this new path")
    args = parser.parse_args()
    targets = re.findall(r"``(MathLab\.WT\.[\w.]+)", AUDIT.read_text())
    if not targets or len(set(targets)) != len(targets):
        raise ValueError("expected distinct named WT theorems in AxiomAudit.lean")
    env = os.environ.copy()
    bundled = LEAN / ".lake" / "toolchain" / "bin"
    if (bundled / "lake").is_file():
        env["PATH"] = os.pathsep.join((str(bundled), env.get("PATH", "")))
    env.setdefault("LEAN_NUM_THREADS", "2")
    run = dict(cwd=LEAN, env=env, check=True)
    subprocess.run(["lake", "build", "MathLab.WT.AxiomAudit"], **run)
    with TemporaryDirectory(prefix="wt-lean-") as directory:
        path = args.keep_export.resolve() if args.keep_export else Path(directory) / "proofs.ndjson"
        with path.open("xb") as output:
            subprocess.run(["lake", "env", "leanexport", "MathLab.WT", "--", *targets],
                           stdout=output, **run)
        check_export(path, targets)
        subprocess.run(["lake", "env", "leanchecker", "--from-export", str(path)], **run)


if __name__ == "__main__":
    main()
