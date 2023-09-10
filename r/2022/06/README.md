# Advent of Code: 2022 Day 6 in R
2023-09-11

## Day 6: Tuning Trouble

> The preparations are finally complete; you and the Elves leave camp on
> foot and begin to make your way toward the star fruit grove.
>
> As you move through the dense undergrowth, one of the Elves gives you
> a handheld device. He says that it has many fancy features, but the
> most important one to set up right now is the communication system.
>
> However, because he’s heard you have significant experience dealing
> with signal-based systems, he convinced the other Elves that it would
> be okay to give you their one malfunctioning device - surely you’ll
> have no problem fixing it.
>
> As if inspired by comedic timing, the device emits a few colorful
> sparks.
>
> To be able to communicate with the Elves, the device needs to lock on
> to their signal. The signal is a series of seemingly-random characters
> that the device receives one at a time.
>
> To fix the communication system, you need to add a subroutine to the
> device that detects a start-of-packet marker in the datastream. In the
> protocol being used by the Elves, the start of a packet is indicated
> by a sequence of four characters that are all different.
>
> The device will send your subroutine a datastream buffer (your puzzle
> input); your subroutine needs to identify the first position where the
> four most recently received characters were all different.
> Specifically, it needs to report the number of characters from the
> beginning of the buffer to the end of the first such four-character
> marker.
>
> For example, suppose you receive the following datastream buffer:
>
> `mjqjpqmgbljsphdztnvjfqwrcgsmlb`
>
> After the first three characters (`mjq`) have been received, there
> haven’t been enough characters received yet to find the marker. The
> first time a marker could occur is after the fourth character is
> received, making the most recent four characters `mjqj.` Because `j`
> is repeated, this isn’t a marker.
>
> The first time a marker appears is after the seventh character
> arrives. Once it does, the last four characters received are `jpqm`,
> which are all different. In this case, your subroutine should report
> the value `7`, because the first start-of-packet marker is complete
> after 7 characters have been processed.
>
> Here are a few more examples:
>
> - `bvwbjplbgvbhsrlpgdmjqwftvncz`: first marker after character 5
> - `nppdvjthqldpwncqszvftbrmjlhg`: first marker after character 6
> - `nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg`: first marker after character 10
> - `zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw`: first marker after character 11
>
> How many characters need to be processed before the first
> start-of-packet marker is detected?

## Part 1

This puzzle is a bit unique in that it give us 5 distinct test cases -
[test_input_1.txt](test_input_1.txt) -
[test_input_2.txt](test_input_2.txt) -
[test_input_3.txt](test_input_3.txt) -
[test_input_4.txt](test_input_4.txt) -
[test_input_5.txt](test_input_5.txt)

In addition to [input.txt](input.txt).

I think this will be fairly straightforward. We read in the data as a
single long character string, then split it into a vector of individual
characters. We iterate through that vector looking ahead at the next
four characters. The first time that `length(unique(vec)) == 4`, we have
found the first start-of-package marker.

``` r
part_1 <- function(file) {
  data <- readLines(file)
  char_vector <- strsplit(data, "")[[1]]
  for (i in seq_along(char_vector)) {
    four_chars <- char_vector[i:(i + 3)]
    if (length(unique(four_chars)) == 4) {
      return(i + 3)
    }
  }
}
```

``` r
part_1("test_input_1.txt") == 7
```

    [1] TRUE

``` r
part_1("test_input_2.txt") == 5
```

    [1] TRUE

``` r
part_1("test_input_3.txt") == 6
```

    [1] TRUE

``` r
part_1("test_input_4.txt") == 10
```

    [1] TRUE

``` r
part_1("test_input_5.txt") == 11
```

    [1] TRUE

The examples look good. Now for the real data:

``` r
part_1("input.txt")
```

    [1] 1582

Success!

## Part 2

Now for part 2.

> Your device’s communication system is correctly detecting packets, but
> still isn’t working. It looks like it also needs to look for messages.
>
> A start-of-message marker is just like a start-of-packet marker,
> except it consists of 14 distinct characters rather than 4.
>
> Here are the first positions of start-of-message markers for all of
> the above examples:
>
> - `mjqjpqmgbljsphdztnvjfqwrcgsmlb`: first marker after character 19
> - `bvwbjplbgvbhsrlpgdmjqwftvncz`: first marker after character 23
> - `nppdvjthqldpwncqszvftbrmjlhg`: first marker after character 23
> - `nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg`: first marker after character 29
> - `zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw`: first marker after character 26
>
> How many characters need to be processed before the first
> start-of-message marker is detected?

This should be the same, just switching out 14 for 4 when checking
`length(unique(four_chars))`.

``` r
part_2 <- function(file) {
  data <- readLines(file)
  char_vector <- strsplit(data, "")[[1]]
  for (i in seq_along(char_vector)) {
    four_chars <- char_vector[i:(i + 13)]
    if (length(unique(four_chars)) == 14) {
      return(i + 13)
    }
  }
}
```

``` r
part_2("test_input_1.txt") == 19
```

    [1] TRUE

``` r
part_2("test_input_2.txt") == 23
```

    [1] TRUE

``` r
part_2("test_input_3.txt") == 23
```

    [1] TRUE

``` r
part_2("test_input_4.txt") == 29
```

    [1] TRUE

``` r
part_2("test_input_5.txt") == 26
```

    [1] TRUE

All good. Now for the real data:

``` r
part_2("input.txt")
```

    [1] 3588

Correct! This was a very easy challenge to do in R. It’s possible that
it would be more difficult in other languages. For example, in Go we
would not have access to a function like `unique()` but would instead
have to manually compare values or create a map with the characters in
the vector to check for uniqueness. Regardless, this was straightforward
to the point of triviality in R.

You can find all of my Advent of Code solutions on
[GitHub](https://github.com/stephenfeagin/adventofcode).
