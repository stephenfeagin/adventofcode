package main

import (
	"fmt"
	"io/ioutil"
	"log"
)

func main() {
	input := readInput("input.txt")
	fmt.Printf("Part 1: %d\n", part1(input))
	fmt.Printf("Part 2: %d\n", part2(input))
}

func readInput(fname string) string {
	content, err := ioutil.ReadFile(fname)
	if err != nil {
		log.Fatal(err)
	}
	return string(content)
}

func part1(input string) int {
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

func part2(input string) int {
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
