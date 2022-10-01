package main

import "testing"

func TestPart1(t *testing.T) {
	testCases := []struct {
		input string
		want  int
	}{
		{"(())", 0},
		{"()()", 0},
		{"(((", 3},
		{"(()(()(", 3},
		{"))(((((", 3},
		{"())", -1},
		{"))(", -1},
		{")))", -3},
		{")())())", -3},
	}

	for _, testCase := range testCases {
		t.Run(testCase.input, func(t *testing.T) {
			got := Part1(testCase.input)
			if got != testCase.want {
				t.Fail()
			}
		})
	}
}

func TestPart2(t *testing.T) {
	testCases := []struct {
		input string
		want  int
	}{
		{")", 1},
		{"()())", 5},
	}
	for _, testCase := range testCases {
		t.Run(testCase.input, func(t *testing.T) {
			got := Part2(testCase.input)
			if got != testCase.want {
				t.Fail()
			}
		})
	}
}
