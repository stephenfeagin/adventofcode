# Advent of Code: 2022 Day 4 in R
2023-09-08

## Day 4: Camp Cleanup

> Space needs to be cleared before the last supplies can be unloaded
> from the ships, and so several Elves have been assigned the job of
> cleaning up sections of the camp. Every section has a unique ID
> number, and each Elf is assigned a range of section IDs.
>
> However, as some of the Elves compare their section assignments with
> each other, they’ve noticed that many of the assignments overlap. To
> try to quickly find overlaps and reduce duplicated effort, the Elves
> pair up and make a big list of the section assignments for each pair
> (your puzzle input).
>
> For example, consider the following list of section assignment pairs:

    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8

> For the first few pairs, this list means:
>
> - Within the first pair of Elves, the first Elf was assigned sections
>   2-4 (sections 2, 3, and 4), while the second Elf was assigned
>   sections 6-8 (sections 6, 7, 8).
> - The Elves in the second pair were each assigned two sections.
> - The Elves in the third pair were each assigned three sections: one
>   got sections 5, 6, and 7, while the other also got 7, plus 8 and 9.
>
> This example list uses single-digit section IDs to make it easier to
> draw; your actual list might contain larger numbers. Visually, these
> pairs of section assignments look like this:

    .234.....  2-4
    .....678.  6-8

    .23......  2-3
    ...45....  4-5

    ....567..  5-7
    ......789  7-9

    .2345678.  2-8
    ..34567..  3-7

    .....6...  6-6
    ...456...  4-6

    .23456...  2-6
    ...45678.  4-8

> Some of the pairs have noticed that one of their assignments fully
> contains the other. For example, 2-8 fully contains 3-7, and 6-6 is
> fully contained by 4-6. In pairs where one assignment fully contains
> the other, one Elf in the pair would be exclusively cleaning sections
> their partner will already be cleaning, so these seem like the most in
> need of reconsideration. In this example, there are 2 such pairs.

## Part 1

> In how many assignment pairs does one range fully contain the other?

I will warn you that this post will show exactly how I’m exploring the
problem and all the intermediate steps – it’s not a polished report on
the end product. The first challenge here is reading in the data in a
way that makes it useful to us. We can first get the lines:

``` r
test_data <- readLines("test_input.txt")
test_data
```

    [1] "2-4,6-8" "2-3,4-5" "5-7,7-9" "2-8,3-7" "6-6,4-6" "2-6,4-8"

Next, we need to split out each line into the two Elves.

``` r
elf_list <- strsplit(test_data, ",")
elf_list
```

    [[1]]
    [1] "2-4" "6-8"

    [[2]]
    [1] "2-3" "4-5"

    [[3]]
    [1] "5-7" "7-9"

    [[4]]
    [1] "2-8" "3-7"

    [[5]]
    [1] "6-6" "4-6"

    [[6]]
    [1] "2-6" "4-8"

We can further get each elf’s range by splitting up the strings again.
Here we have a list where each item in the list is a list of two 2-item
vectors, each representing the start and end of each area for each elf.

``` r
elf_list_ranges <- lapply(elf_list, strsplit, split = "-")
elf_list_ranges
```

    [[1]]
    [[1]][[1]]
    [1] "2" "4"

    [[1]][[2]]
    [1] "6" "8"


    [[2]]
    [[2]][[1]]
    [1] "2" "3"

    [[2]][[2]]
    [1] "4" "5"


    [[3]]
    [[3]][[1]]
    [1] "5" "7"

    [[3]][[2]]
    [1] "7" "9"


    [[4]]
    [[4]][[1]]
    [1] "2" "8"

    [[4]][[2]]
    [1] "3" "7"


    [[5]]
    [[5]][[1]]
    [1] "6" "6"

    [[5]][[2]]
    [1] "4" "6"


    [[6]]
    [[6]][[1]]
    [1] "2" "6"

    [[6]][[2]]
    [1] "4" "8"

At this point I might switch over to manually iterating. I’m going to
pull out just one pair for now to play around with.

``` r
pair <- elf_list_ranges[[1]]
for (range in pair) {
  print(readr::parse_number(range))
}
```

    [1] 2 4
    [1] 6 8

Now I need to convert that into sequences covering those points.

``` r
pair_ranges <- vector("list", 2)
for (i in seq_along(pair)) {
  range_numeric <- readr::parse_number(pair[[i]])
  area_range <- seq(range_numeric[1], range_numeric[2])
  pair_ranges[[i]] <- area_range
}
pair_ranges
```

    [[1]]
    [1] 2 3 4

    [[2]]
    [1] 6 7 8

Ok, that looks promising. Now I just have to check whether either range
completely includes the other.

``` r
all(pair_ranges[[1]] %in% pair_ranges[[2]]) || all(pair_ranges[[2]] %in% pair_ranges[[1]])
```

    [1] FALSE

Not bad. Now I have to put that all together and iterate over the list
of lists.

``` r
get_character_list <- function(input_data) {
  strsplit(input_data, ",") |> 
    lapply(strsplit, split = "-")
}
character_list <- get_character_list(test_data)
character_list
```

    [[1]]
    [[1]][[1]]
    [1] "2" "4"

    [[1]][[2]]
    [1] "6" "8"


    [[2]]
    [[2]][[1]]
    [1] "2" "3"

    [[2]][[2]]
    [1] "4" "5"


    [[3]]
    [[3]][[1]]
    [1] "5" "7"

    [[3]][[2]]
    [1] "7" "9"


    [[4]]
    [[4]][[1]]
    [1] "2" "8"

    [[4]][[2]]
    [1] "3" "7"


    [[5]]
    [[5]][[1]]
    [1] "6" "6"

    [[5]][[2]]
    [1] "4" "6"


    [[6]]
    [[6]][[1]]
    [1] "2" "6"

    [[6]][[2]]
    [1] "4" "8"

``` r
get_area_ranges <- function(character_list) {
  all_pairs <- vector("list", length(character_list))
  for (i in seq_along(character_list)) {
    pair_ranges <- vector("list", 2)
    for (j in 1:2) {
      endpoints <- readr::parse_number(character_list[[i]][[j]])
      area <- seq(from = endpoints[1], to = endpoints[2])
      pair_ranges[[j]] <- area
    }
    all_pairs[[i]] <- pair_ranges
  }
  all_pairs
}
area_ranges <- get_area_ranges(character_list)
```

Line 2  
Initialize an empty list to hold the results

Line 3  
Iterate over the pairs of elves

Line 4  
Initialize a list to contain each pair’s ranges

Line 5  
I know there are only 2 vectors in each list, one for each elf, so I can
hardcode `1:2`

Line 6  
Turn the character strings into numeric values

Lines 7-8  
Generate the sequence and populate the `pair_ranges` list

Line 10  
Populate the `all_pairs` list

``` r
area_ranges
```

    [[1]]
    [[1]][[1]]
    [1] 2 3 4

    [[1]][[2]]
    [1] 6 7 8


    [[2]]
    [[2]][[1]]
    [1] 2 3

    [[2]][[2]]
    [1] 4 5


    [[3]]
    [[3]][[1]]
    [1] 5 6 7

    [[3]][[2]]
    [1] 7 8 9


    [[4]]
    [[4]][[1]]
    [1] 2 3 4 5 6 7 8

    [[4]][[2]]
    [1] 3 4 5 6 7


    [[5]]
    [[5]][[1]]
    [1] 6

    [[5]][[2]]
    [1] 4 5 6


    [[6]]
    [[6]][[1]]
    [1] 2 3 4 5 6

    [[6]][[2]]
    [1] 4 5 6 7 8

``` r
check_overlap <- function(ranges) {
  all(ranges[[1]] %in% ranges[[2]]) || all(ranges[[2]] %in% ranges[[1]])
}
sapply(area_ranges, check_overlap)
```

    [1] FALSE FALSE FALSE  TRUE  TRUE FALSE

Now to put it all together.

``` r
part_1 <- function(input_data) {
  input_data |> 
    get_character_list() |> 
    get_area_ranges() |> 
    sapply(check_overlap) |> 
    sum()
}
part_1(test_data)
```

    [1] 2

That’s the correct answer for the example. Now to try it on the real
thing:

``` r
real_data <- readLines("input.txt")
part_1(real_data)
```

    [1] 494

That’s the right answer! One gold star!

## Part 2

> It seems like there is still quite a bit of duplicate work planned.
> Instead, the Elves would like to know the number of pairs that overlap
> at all.
>
> In the above example, the first two pairs (`2-4,6-8` and `2-3,4-5`)
> don’t overlap, while the remaining four pairs (`5-7,7-9`, `2-8,3-7`,
> `6-6,4-6`, and `2-6,4-8`) do overlap:
>
> - `5-7,7-9` overlaps in a single section, 7.
> - `2-8,3-7` overlaps all of the sections 3 through 7.
> - `6-6,4-6` overlaps in a single section, 6.
> - `2-6,4-8` overlaps in sections 4, 5, and 6.
>
> So, in this example, the number of overlapping assignment pairs is 4.
>
> In how many assignment pairs do the ranges overlap?

This should be easy. All I have to do is change `check_overlap()` to see
if there is `any()` overlap instead of `all()`.

``` r
check_any_overlap <- function(ranges) {
  any(ranges[[1]] %in% ranges[[2]]) || any(ranges[[2]] %in% ranges[[1]])
}
```

Put it together again:

``` r
part_2 <- function(input_data) {
  input_data |> 
    get_character_list() |> 
    get_area_ranges() |> 
    sapply(check_any_overlap) |> 
    sum()
}
part_2(test_data)
```

    [1] 4

Real data:

``` r
part_2(real_data)
```

    [1] 833

And that’s correct!

You can find all of my Advent of Code solutions on
[GitHub](https://github.com/stephenfeagin/adventofcode).
