# Exact replay

Run `python3 verify.py` from this directory. Python 3.9 or later and its standard library are sufficient. The checker reconstructs installed speeds and phases from Poliakova's three source rules and the sixteen recipe choices in [recipes.json](recipes.json). For every affected speed $q$ it enumerates each primitive numerator $k\bmod q$ and checks a continuous rational interval cover. It also independently builds all time arcs for the 476-runner example and verifies that their union covers a full period.

The integer part merges the events in one full counting period, checks the largest discrepancy and its witness, and evaluates the 1029 starting values and step increment for the all-size bound. Exact arithmetic gives the two finite guarantees and the limiting coefficient. The proof that these computations apply to every real time and to arbitrarily large seed sizes is in the [manuscript](../compatible-replacements.tex).

[Independent replay output](replay.txt) · [Lean scope and Kanako receipt](lean/README.md)
