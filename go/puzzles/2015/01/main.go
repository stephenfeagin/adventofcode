package main

import (
	"fmt"
	"io/ioutil"
	"log"
)

func Solve(fname string) {
	input := ReadInput(fname)
	solution1 := Part1(input)
	solution2 := Part2(input)
	fmt.Printf("Part 1: %d\nPart 2: %d\n", solution1, solution2)
}

func ReadInput(fname string) string {
	content, err := ioutil.ReadFile(fname)
	if err != nil {
		log.Fatal(err)
	}
	return string(content)
}

func Part1(input string) int {
	floor := 0
	for _, letter := range input {
		if letter == '(' {
			floor++
		} else if letter == ')' {
			floor--
		}
	}
	return floor
}

func Part2(input string) int {
	floor := 0
	for i, letter := range input {
		if letter == '(' {
			floor++
		} else if letter == ')' {
			floor--
		}
		if floor == -1 {
			return i + 1
		}
	}
	return 0
}

func main() {
}
