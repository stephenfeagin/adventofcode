import os
import sys
from pathlib import Path
from typing import List


def read_input(fname: str) -> List[int]:
    with open(fname, "r") as f:
        try:
            lines = [int(i) for i in f.readlines()]
        except ValueError:
            raise Exception("Bad input")
    return lines


def part_1(lines: List[int]) -> int:
    return sum(lines[i+1] > lines[i] for i in range(len(lines)-1))


def part_2(lines: List[int]) -> int:
    return sum(sum(lines[i+1:i+4]) > sum(lines[i:i+3])  for i in range(len(lines)-4))


if __name__ == "__main__":
    print(os.path.dirname(__file__))
    p = Path(__file__)
    print(p.absolute())
    data = read_input(sys.argv[1])
    print(part_1(data))
    print(part_2(data))
