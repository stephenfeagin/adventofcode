# Day 1: Calorie Counting

Santa’s reindeer typically eat regular reindeer food, but they need a
lot of magical energy to deliver presents on Christmas. For that, their
favorite snack is a special type of star fruit that only grows deep in
the jungle. The Elves have brought you on their annual expedition to the
grove where the fruit grows.

To supply enough magical energy, the expedition needs to retrieve a
minimum of fifty stars by December 25th. Although the Elves assure you
that the grove has plenty of fruit, you decide to grab any fruit you see
along the way, just in case.

Collect stars by solving puzzles. Two puzzles will be made available on
each day in the Advent calendar; the second puzzle is unlocked when you
complete the first. Each puzzle grants one star. Good luck!

The jungle must be too overgrown and difficult to navigate in vehicles
or access from the air; the Elves’ expedition traditionally goes on
foot. As your boats approach land, the Elves begin taking inventory of
their supplies. One important consideration is food - in particular, the
number of Calories each Elf is carrying (your puzzle input).

The Elves take turns writing down the number of Calories contained by
the various meals, snacks, rations, etc. that they’ve brought with them,
one item per line. Each Elf separates their own inventory from the
previous Elf’s inventory (if any) by a blank line.

For example, suppose the Elves finish writing their items’ Calories and
end up with the following list:

    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000

This list represents the Calories of the food carried by five Elves: -
The first Elf is carrying food with`1000`, `2000`, and `3000` Calories,
a total of `6000` Calories. - The second Elf is carrying one food item
with `4000` Calories. - The third Elf is carrying food with `5000` and
`6000` Calories, a total of `11000` Calories. - The fourth Elf is
carrying food with `7000`, `8000`, and `9000` Calories, a total of
`24000` Calories. - The fifth Elf is carrying one food item with `10000`
Calories.

## Part 1

In case the Elves get hungry and need extra snacks, they need to know
which Elf to ask: they’d like to know how many Calories are being
carried by the Elf carrying the most Calories. In the example above,
this is `24000` (carried by the fourth Elf).

Find the Elf carrying the most calories. How many total Calories is that
Elf carrying?

### Read Input

``` r
read_input <- function(file) {
  as.numeric(readLines(file))
}
```

### Parse Input

I want to go through the list and add up the amounts until I get to an
NA, then keep track of what the highest total is.

``` r
part_1 <- function(input_data) {
  highest_total <- 0
  running_total <- 0
  for (i in input_data) {
    if (is.na(i)) {
      if (running_total > highest_total) {
        highest_total <- running_total
      }
      running_total <- 0
      next
    }
    running_total <- running_total + i
  }
  # Because the is.na() doesn't capture the last elf, we have to do that check manually
  if (running_total > highest_total) {
    highest_total <- running_total
  }
  highest_total
}
```

Lines 2-3  
Initialize some variables

Line 4  
Start a loop

### Test Data

``` r
test_input <- read_input("test_input.txt")
part_1(test_input)
```

    [1] 24000

### Real Data

``` r
real_input <- read_input("input.txt")
part_1(real_input)
```

    [1] 71924

## Part 2

By the time you calculate the answer to the Elves’ question, they’ve
already realized that the Elf carrying the most Calories of food might
eventually run out of snacks.

To avoid this unacceptable situation, the Elves would instead like to
know the total Calories carried by the top three Elves carrying the most
Calories. That way, even if one of those Elves runs out of snacks, they
still have two backups.

In the example above, the top three Elves are the fourth Elf (with
`24000` Calories), then the third Elf (with `11000` Calories), then the
fifth Elf (with `10000` Calories). The sum of the Calories carried by
these three elves is `45000.`

Find the top three Elves carrying the most Calories. How many Calories
are those Elves carrying in total?

### Parse Input

We can use the same input data as before and we don’t need to mess with
the function to read it in. What I will do now, instead of keeping track
of the single highest total, I will just populate a vector with all of
the totals, sort it, and then take the three highest values. I can
figure out the size of vector that I need by getting the number of `NA`s
and adding one – there is an `NA` between every Elf, but none after the
last one, so that has to be added on.

``` r
part_2 <- function(input_data) {
  elf_totals <- numeric(sum(is.na(input_data)) + 1)
  
  current_elf <- 1
  running_total <- 0
  for (i in seq_along(input_data)) {
    if (i == length(input_data)) {
      running_total <- running_total + input_data[i]
      elf_totals[current_elf] <- running_total
    }
    if (is.na(input_data[i])) {
      elf_totals[current_elf] <- running_total
      running_total <- 0
      current_elf <- current_elf + 1
      next
    }
    running_total <- running_total + input_data[i]
  }
  sum(sort(elf_totals, decreasing = TRUE)[1:3])
}
part_2(test_input)
```

    [1] 45000

### Test Data

``` r
part_2(test_input)
```

    [1] 45000

### Real Data

``` r
part_2(real_input)
```

    [1] 210406
