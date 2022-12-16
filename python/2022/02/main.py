from typing import List

def play_rps(opponent: str, you: str) -> int:
    # I know this could be made more efficient by using a dict as a lookup table
    # but I find this more transparent and easier to understand
    # e.g. strategies["A X"] = 4, strategies["A Y"] = 8, etc.
    score = 0
    if opponent == "A":  # rock
        if you == "X":  # rock, draw
            score = 1 + 3  # rock = 1, draw = 3
        elif you == "Y":  # paper, win
            score = 2 + 6  # paper = 2, win = 6
        elif you == "Z":  # scissors, lose
            score = 3 + 0  # scissors = 3, lose = 0

    elif opponent == "B":  # paper
        if you == "X":  # rock, lose
            score = 1 + 0  # rock = 1, lose = 0
        elif you == "Y":  # paper, draw
            score = 2 + 3  # paper = 2, tie = 3
        elif you == "Z":  # scissors, win
            score = 3 + 6  # scissors = 3, win = 6

    elif opponent == "C":  # scissors
        if you == "X":  # rock, win
            score = 1 + 6  # rock = 1, win = 6
        elif you == "Y":  # paper, lose
            score = 2 + 0  # paper = 2, lose = 0
        elif you == "Z":  # scissors, draw
            score = 3 + 3  # scissors = 3, draw = 3

    return score


def read_input(fname: str) -> List[List[int]]:
    with open(fname, "r") as f:
        lines = f.readlines()
    games = [l.strip().split() for l in lines]
    
    return games

def part_1(games: List[List[int]]) -> int:
    scores = [play_rps(*g) for g in games]
    return sum(scores)

def choose_play(opponent: str, outcome: str) -> int:
    score = 0
    if opponent == "A":  # rock
        if outcome == "X":  # lose, scissors
            score = 3 + 0  # scissors = 3, lose = 0
        elif outcome == "Y":  # draw, rock
            score = 1 + 3  # rock = 1, draw = 3
        elif outcome == "Z":  # win, paper
            score = 2 + 6  # paper = 2, win = 6
            
    elif opponent == "B":  # paper
        if outcome == "X":  # lose, rock
            score = 1 + 0  # rock = 1, lose = 0
        elif outcome == "Y":  # draw, paper
            score = 2 + 3  # paper = 2, draw = 3
        elif outcome == "Z":  # win, scissors
            score = 3 + 6  # scissors = 3, win = 6

    elif opponent == "C":  # scissors
        if outcome == "X":  # lose, paper
            score = 2 + 0  # paper = 2, lose = 0
        elif outcome == "Y":  # draw, scissors
            score = 3 + 3  # scissors = 3, draw = 3
        elif outcome == "Z":  # win, rock
            score = 1 + 6  # rock = 1, win = 6
    
    return score

def part_2(games: List[List[int]]) -> int:
    scores = [choose_play(*g) for g in games]
    return sum(scores)



if __name__ == "__main__":
    fname = "input.txt"
    games = read_input(fname)
    print(part_1(games))
    print(part_2(games))
    