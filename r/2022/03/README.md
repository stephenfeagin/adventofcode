# Advent of Code: 2022 Day 3 in R
2023-09-08

## Day 3: Rucksack Reorganization

> One Elf has the important job of loading all of the rucksacks with
> supplies for the jungle journey. Unfortunately, that Elf didn’t quite
> follow the packing instructions, and so a few items now need to be
> rearranged.
>
> Each rucksack has two large compartments. All items of a given type
> are meant to go into exactly one of the two compartments. The Elf that
> did the packing failed to follow this rule for exactly one item type
> per rucksack.
>
> The Elves have made a list of all of the items currently in each
> rucksack (your puzzle input), but they need your help finding the
> errors. Every item type is identified by a single lowercase or
> uppercase letter (that is, a and A refer to different types of items).
>
> The list of items for each rucksack is given as characters all on a
> single line. A given rucksack always has the same number of items in
> each of its two compartments, so the first half of the characters
> represent items in the first compartment, while the second half of the
> characters represent items in the second compartment.
>
> For example, suppose you have the following list of contents from six
> rucksacks:

    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw

> - The first rucksack contains the items `vJrwpWtwJgWrhcsFMMfFFhFp`,
>   which means its first compartment contains the items `vJrwpWtwJgWr`,
>   while the second compartment contains the items `hcsFMMfFFhFp.` The
>   only item type that appears in both compartments is lowercase `p`.
> - The second rucksack’s compartments contain `jqHRNqRjqzjGDLGL` and
>   `rsFMfFZSrLrFZsSL.` The only item type that appears in both
>   compartments is uppercase `L`.
> - The third rucksack’s compartments contain `PmmdzqPrV` and
>   `vPwwTWBwg`; the only common item type is uppercase `P`.
> - The fourth rucksack’s compartments only share item type `v`.
> - The fifth rucksack’s compartments only share item type `t`.
> - The sixth rucksack’s compartments only share item type `s`.
>
> To help prioritize item rearrangement, every item type can be
> converted to a priority: - Lowercase item types a through z have
> priorities 1 through 26. - Uppercase item types A through Z have
> priorities 27 through 52.
>
> In the above example, the priority of the item type that appears in
> both compartments of each rucksack is `16` (`p`), `38` (`L`), `42`
> (`P`), `22` (`v`), `20` (`t`), and `19` (`s`); the sum of these is
> `157.`

## Part 1

> Find the item type that appears in both compartments of each rucksack.
> What is the sum of the priorities of those item types?

This one is simple to read in:

``` r
read_input <- function(file) {
  readLines(file)
}
```

Unfortunately for me, R is not the friendliest language for string
manipulation, but I think this will be straightforward enough. Whereas a
language like Python is able to treat a multi-character string as a list
and iterate through it with ease, in R each string is an atomic vector
that cannot be subdivided further. So we need to explicitly split the
string before we operate on it.

I’ll first be working with the test data first.

``` r
test_data <- read_input("test_input.txt")
rucksack_list <- strsplit(test_data, "")
```

We now have a list where each element is a vector of individual
characters from each element in `test_data`:

``` r
rucksack_list
```

    [[1]]
     [1] "v" "J" "r" "w" "p" "W" "t" "w" "J" "g" "W" "r" "h" "c" "s" "F" "M" "M" "f"
    [20] "F" "F" "h" "F" "p"

    [[2]]
     [1] "j" "q" "H" "R" "N" "q" "R" "j" "q" "z" "j" "G" "D" "L" "G" "L" "r" "s" "F"
    [20] "M" "f" "F" "Z" "S" "r" "L" "r" "F" "Z" "s" "S" "L"

    [[3]]
     [1] "P" "m" "m" "d" "z" "q" "P" "r" "V" "v" "P" "w" "w" "T" "W" "B" "w" "g"

    [[4]]
     [1] "w" "M" "q" "v" "L" "M" "Z" "H" "h" "H" "M" "v" "w" "L" "H" "j" "b" "v" "c"
    [20] "j" "n" "n" "S" "B" "n" "v" "T" "Q" "F" "n"

    [[5]]
     [1] "t" "t" "g" "J" "t" "R" "G" "J" "Q" "c" "t" "T" "Z" "t" "Z" "T"

    [[6]]
     [1] "C" "r" "Z" "s" "J" "s" "P" "P" "Z" "s" "G" "z" "w" "w" "s" "L" "w" "L" "m"
    [20] "p" "w" "M" "D" "w"

The first thing we need to do is divide each rucksack into its two
halves. To start with, I’m going to pull out the first rucksack and work
only with that so that I can get the puzzle logic down before applying
it to the entire list.

``` r
rucksack <- rucksack_list[[1]]
```

Now the two halves:

``` r
half_1 <- rucksack[1:(length(rucksack) / 2)]
half_2 <- rucksack[(length(rucksack) / 2 + 1):length(rucksack)]
```

Next, I can get the `intersect()` of each element to find the overlap:

``` r
intersect(half_1, half_2)
```

    [1] "p"

Lowercase `p` is correct. Now I just need to code that process up to
apply it to each element in `rucksack_list`.

``` r
shared_items <- character(length(rucksack_list))
for (i in seq_along(rucksack_list)) {
  half_1 <- rucksack_list[[i]][1:(length(rucksack_list[[i]]) / 2)]
  half_2 <- rucksack_list[[i]][
      (length(rucksack_list[[i]]) / 2 + 1):length(rucksack_list[[i]])
    ]
  shared_items[i] <- intersect(half_1, half_2)
}
```

That’s the hardest part. Now just to calculate the priorities. I make a
vector that combines the lower case letters and the uppercase letters,
then I can get the priority value using `which()` to pull out the
position of any given letter.

``` r
get_priority <- function(letter) {
  priorities <- c(letters, LETTERS)
  which(priorities == letter)
}

sum(sapply(shared_items, get_priority))
```

    [1] 157

Which is the correct answer for the example.

Now I’ll rewrite this as clean, clear functions to use for the real
input. I already have `get_priority()` so I don’t need to rewrite that.

``` r
get_shared_item <- function(sack) {
  half_1 <- sack[1:(length(sack) / 2)]
  half_2 <- sack[(length(sack) / 2 + 1):length(sack)]
  intersect(half_1, half_2)
}

part_1 <- function(input_data) {
  rucksack_list <- strsplit(input_data, "")
  shared_items <- sapply(rucksack_list, get_shared_item)
  priorities <- sapply(shared_items, get_priority)
  sum(priorities)
}
```

This could also be written with the native R pipe:

``` r
part_1_pipe <- function(input_data) {
  input_data |> 
    strsplit("") |> 
    sapply(get_shared_item) |> 
    sapply(get_priority) |> 
    sum()
}
```

Now to try it out:

``` r
real_data <- read_input("input.txt")
part_1(real_data)
```

    [1] 7691

``` r
part_1_pipe(real_data)
```

    [1] 7691

That’s the right answer, and both versions of the function agree!

## Part 2

> As you finish identifying the misplaced items, the Elves come to you
> with another issue.
>
> For safety, the Elves are divided into groups of three. Every Elf
> carries a badge that identifies their group. For efficiency, within
> each group of three Elves, the badge is the only item type carried by
> all three Elves. That is, if a group’s badge is item type B, then all
> three Elves will have item type B somewhere in their rucksack, and at
> most two of the Elves will be carrying any other item type.
>
> The problem is that someone forgot to put this year’s updated
> authenticity sticker on the badges. All of the badges need to be
> pulled out of the rucksacks so the new authenticity stickers can be
> attached.
>
> Additionally, nobody wrote down which item type corresponds to each
> group’s badges. The only way to tell which item type is the right one
> is by finding the one item type that is common between all three Elves
> in each group.
>
> Every set of three lines in your list corresponds to a single group,
> but each group can have a different badge item type. So, in the above
> example, the first group’s rucksacks are the first three lines:

    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg

> And the second group’s rucksacks are the next three lines:

    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw

> In the first group, the only item type that appears in all three
> rucksacks is lowercase `r`; this must be their badges. In the second
> group, their badge item type must be `Z`.
>
> Priorities for these items must still be found to organize the sticker
> attachment efforts: here, they are 18 (`r`) for the first group and 52
> (`Z`) for the second group. The sum of these is 70.
>
> Find the item type that corresponds to the badges of each three-Elf
> group. What is the sum of the priorities of those item types?

The biggest challenge here is to group the elves in their teams of
three. After that, it’s mostly a repeat of the previous example.

``` r
get_teams <- function(input_data) {
  elf_teams <- vector("list", length = length(input_data) / 3)
  i <- 1
  while (i <= length(input_data)) {
    elf_teams[[ceiling(i / 3)]] <- input_data[i:(i+2)]
    i <- i + 3
  }
  elf_teams
}
```

Line 2  
Whenever possible, it’s best to construct a list or vector of the
appropriate size and populate it, rather than appending onto the end of
a list or vector. It’s much more memory efficient, and “vector growing”
can actually crash your program if you do it enough times, like in a
very long loop.

Lines 3-4  
Initialize a counter variable and start a `while` loop

Line 5  
I use `[ceiling(i  / 3)]` to find the next appropriate element of
`elf_teams` to populate. For `i` in `1:3`, the value is `1`, for `i` in
`4:6`, the value is `2`, etc. Doing this means I don’t have to nest
loops to iterate over both `elf_teams` and `input_data`.

Line 6  
Increase `i` by 3 each time so we skip forward to the start of the next
team

``` r
get_teams(test_data)
```

    [[1]]
    [1] "vJrwpWtwJgWrhcsFMMfFFhFp"         "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"
    [3] "PmmdzqPrVvPwwTWBwg"              

    [[2]]
    [1] "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn" "ttgJtRGJQctTZtZT"              
    [3] "CrZsJsPPZsGzwwsLwLmpwMDw"      

Next, I create a function to find the badge, which is just a small
rewrite of `get_shared_item()`. I combine that function with
`strsplit()` just to compress things a bit. I do have to nest
`intersect()` because it only operates on two vectors.

``` r
get_badge <- function(team) {
  elves <- strsplit(team, "")
  intersect(
    intersect(elves[[1]], elves[[2]]),
    elves[[3]]
  )
}
```

Now I put it together with `get_priority()` to solve the whole thing.

``` r
part_2 <- function(input_data) {
  teams <- get_teams(input_data)
  badges <- sapply(teams, get_badge)
  priorities <- sapply(badges, get_priority)
  sum(priorities)
}
```

Again rewriting with the pipe, just for illustration:

``` r
part_2_pipe <- function(input_data) {
  input_data |> 
    get_teams() |> 
    sapply(get_badge) |> 
    sapply(get_priority) |> 
    sum()
}
```

Let’s try it on the test data.

``` r
part_2(test_data)
```

    [1] 70

``` r
part_2_pipe(test_data)
```

    [1] 70

That’s right! Now to try on the real data:

``` r
part_2(real_data)
```

    [1] 2508

Beautiful! Another successful AoC puzzle!
