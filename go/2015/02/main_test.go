package main

import "testing"

func TestGetBox(t *testing.T) {
	testCases := []struct {
		input string
		want  box
	}{
		{"2x3x4", box{2, 3, 4}},
		{"1x1x10", box{1, 1, 10}},
	}

	for _, testCase := range testCases {
		t.Run(testCase.input, func(*testing.T) {
			got := getBox(testCase.input)
			if got != testCase.want {
				t.Fail()
			}
		})
	}
}

func TestMeasurePaper(t *testing.T) {
	testCases := []struct {
		name  string
		input box
		want  int
	}{
		{"2x3x4", box{2, 3, 4}, 58},
		{"1x1x10", box{1, 1, 10}, 43},
	}

	for _, testCase := range testCases {
		t.Run(testCase.name, func(t *testing.T) {
			got := measurePaper(testCase.input)
			if got != testCase.want {
				t.Fail()
			}
		})
	}
}

func TestMeasureRibbon(t *testing.T) {
	testCases := []struct {
		name  string
		input box
		want  int
	}{
		{"2x3x4", box{2, 3, 4}, 34},
		{"1x1x10", box{1, 1, 10}, 14},
	}

	for _, testCase := range testCases {
		t.Run(testCase.name, func(t *testing.T) {
			got := measureRibbon(testCase.input)
			if got != testCase.want {
				t.Fail()
			}
		})
	}
}
