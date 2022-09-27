# [Advent of Code 2018](https://adventofcode.com/2018)

My solutions for AoC 2018 are written in Python 3.7, using only the standard
library. I have used black, mypy, and pytest for development purposes, but the
solutions themselves have no external dependencies.

Each directory contains the solutions for that day. Each day folder contains
the following files:

- `README.md`: The original brief from the AoC website and any notes and/or
attribution
- `day_0x.py`: The solutions file for that day
- `input.txt`: The full puzzle input from AoC
- `test_day_0x.py`: File with pytest code for that day's examples
- `test_input*.txt`: Optional test input file(s) for the examples. Not all
days have this file, as the example input may be typed directly into
`test_day_0x.py`.

I have tried to be as consistent as possible across challenge days for 2018.
Every `.py` file for completed solutions has been run through 
[black](https://github.com/ambv/black) and [mypy](https://mypy-lang.org).

To install dev dependencies, first install
[pipenv](https://pipenv.readthedocs.io):

```bash
$ python3 -m pip install pipenv
```

Then install the dependencies in the Pipfile:

```bash
$ pipenv install --dev
```

This will install [pytest](https://pytest.org), black, and mypy.

## Solutions

To run the solutions for a day `x`, navigate to that day's directory and run:

```bash
$ pipenv run python day_0x.py
```

## Tests

To run the example cases day `x`, navigate to that day's directory and run:

```bash
$ pipenv run pytest
```

