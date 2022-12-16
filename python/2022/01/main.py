from collections import defaultdict
from typing import Dict, List

def read_input(fname: str) -> Dict[int, List[int]]:
    with open(fname, "r") as f:
        lines = f.readlines()
    lines = [l.strip() for l in lines]
    elves = defaultdict(list)
    elf = 0
    for l in lines:
        if l == "":
            elf += 1
            continue
        elves[elf].append(int(l))
    return elves

def part_1(elves: Dict[int, List[int]]) -> int:
    total_cals = [sum(i) for i in elves.values()]
    return max(total_cals)

def part_2(elves: Dict[int, List[int]]) -> int:
    total_cals = [sum(i) for i in elves.values()]
    top_3 = sorted(total_cals)[-3:]
    return sum(top_3)


if __name__ == "__main__":
    fname = "input.txt"
    elves = read_input(fname)
    print(part_1(elves))
    print(part_2(elves))