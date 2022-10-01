package main

import "fmt"

// Solve prints out solutions for the puzzle
func Solve(fname string) {
	// freqs := ReadInput(fname)
	// solution1 := Part1(freqs)
	// solution2 := Part2(freqs)

	// fmt.Printf("Part 1: %d\nPart 2: %d\n", solution1, solution2)
}

// Part1 solves:
func Part1() {
	data := []int{3, 4, 3, 1, 2}
	// var fish []int

	for i := 0; i < 256; i++ {
		data = decrementAll(data)
	}

	fmt.Println(len(data))
}

func decrementOne(fish int) int {
	fish--
	if fish < 0 {
		fish = 6
	}
	return fish
}

func decrementAll(fish []int) []int {
	newFish := 0
	for _, i := range fish {
		if i == 0 {
			newFish++
		}
	}
	addedFish := make([]int, newFish)
	for i := 0; i < newFish; i++ {
		addedFish[i] = 8
	}
	for i := range fish {
		fish[i] = decrementOne(fish[i])
	}
	allFish := append(fish, addedFish...)

	return allFish
}

// Part2 solves:
func Part2() {

}

// ReadInput parses the puzzle's input.txt file
func ReadInput(fname string) {

}

// I include main() so that go doesn't yell about a main package having no main() function
func main() {
	Part1()
}
