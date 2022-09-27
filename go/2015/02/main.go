package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	boxes := readInput("input.txt")
	fmt.Printf("Part 1: %d\n", part1(boxes))
	fmt.Printf("Part 2: %d\n", part2(boxes))
}

type box struct {
	l, w, h int
}

func readInput(fname string) []box {
	file, err := os.Open(fname)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var boxes []box

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		content := scanner.Text()
		b := getBox(content)
		boxes = append(boxes, b)
	}
	return boxes
}

func getBox(input string) box {
	dimensions := strings.Split(input, "x")
	l, err := strconv.Atoi(dimensions[0])
	if err != nil {
		log.Fatal(err)
	}
	w, err := strconv.Atoi(dimensions[1])
	if err != nil {
		log.Fatal(err)
	}
	h, err := strconv.Atoi(dimensions[2])
	if err != nil {
		log.Fatal(err)
	}
	b := box{l, w, h}
	return b
}

func measurePaper(b box) int {
	surfaceArea := 2*b.l*b.h + 2*b.l*b.w + 2*b.h*b.w
	sides := []int{b.l * b.w, b.w * b.h, b.h * b.l}
	sort.Ints(sides)
	return surfaceArea + sides[0]
}

func part1(boxes []box) int {
	var paper int
	for _, b := range boxes {
		paper += measurePaper(b)
	}
	return paper
}

func measureRibbon(b box) int {
	sides := []int{b.h, b.l, b.w}
	sort.Ints(sides)
	perimeter := sides[0] + sides[0] + sides[1] + sides[1]
	return perimeter + b.h*b.l*b.w
}

func part2(boxes []box) int {
	var ribbon int
	for _, b := range boxes {
		ribbon += measureRibbon(b)
	}
	return ribbon
}
