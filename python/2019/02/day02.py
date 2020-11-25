"""
Day 2: 1202 Program Alarm
"""
from typing import List, Optional


def read_input(fname):
    with open(fname, "r") as f:
        str_list = f.read().split(",")
        int_list = [int(i) for i in str_list]
    return int_list


def parse_intcode(intcode: List[int]) -> List[int]:
    for i in range(0, len(intcode), 4):
        opcode = intcode[i]
        if opcode == 99:
            break
        try:
            read_positions = intcode[i + 1 : i + 3]
            write_position = intcode[i + 3]
        except IndexError:
            print("Invalid Intcode.")
            raise
        if opcode == 1:
            intcode[write_position] = (
                intcode[read_positions[0]] + intcode[read_positions[1]]
            )
        elif opcode == 2:
            intcode[write_position] = (
                intcode[read_positions[0]] * intcode[read_positions[1]]
            )
        else:
            raise ValueError("Invalid Intcode: opcode must be 1, 2, or 99")
    return intcode


def part_1(intcode: List[int], noun: int=12, verb: int=2) -> int:
    intcode[1], intcode[2] = noun, verb
    intcode = parse_intcode(intcode)
    return intcode[0]


def part_2(intcode: List[int], result: int=19690720)-> Optional[int]:
    for noun in range(100):
        for verb in range(100):
            print(f"noun={noun}, verb={verb}")
            try:
                opcode = part_1(intcode.copy(), noun, verb)
                print("opcode =", opcode)
            except ValueError:
                continue
            if opcode == result:
                return str(100 * noun) + str(verb).rjust(2, "0")
    


if __name__ == "__main__":
    data = read_input("input.txt")
    print("Part 1:", part_1(data))
    print("Part 2:", part_2(data))
