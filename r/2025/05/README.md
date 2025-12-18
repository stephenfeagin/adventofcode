# 2025 Day 5: Cafeteria


[Link to puzzle](https://adventofcode.com/2025/day/5)

I found the logic of this puzzle quite difficult and had a lot of help
figuring out the algorithm from Reddit, particularly [this
implementation in
Go](https://github.com/tmswfrk/2025adventofcode/blob/main/day05/main.go).
The implementation in R is my own.

## Part 1

First read in the raw file, and pull out the ID ranges and the fresh
IDs.

``` r
read_input <- function(fname) {
  lines <- readLines(fname)
  
  # Match for the range regex and extract the digits into a numeric list
  endpoint_matches <- grepl("^\\d+-\\d+$", lines)
  endpoints <- lines[endpoint_matches]
  endpoint_list <- lapply(strsplit(endpoints, "-"), as.numeric)
  
  # Match for the number regex and convert to numeric
  ID_matches <- grepl("^\\d+$", lines)
  IDs <- as.numeric(lines[ID_matches])
  
  list(endpoints = endpoint_list, IDs = IDs)
}
```

We now have a list with all of the endpoints and all of the fresh IDs.
We can iterate through each fresh ID, check if it is in the range of
each set of endpoints, and keep a running total.

``` r
solve_part_1 <- function(fname) {
  parsed_data <- read_input(fname)
  total <- 0
  
  # Iterate over each ID
  for (id in parsed_data$IDs) {
    # Iterate over each pair of endpoints
    for (i in seq_along(parsed_data$endpoints)) {
      # Check if the ID is between those two values, inclusive
      endpoints <- parsed_data$endpoints[[i]]
      if (id >= endpoints[1] && id <= endpoints[2]) {
        # If it is, increment `total` and move on to the next ID
        total <- total + 1
        break
      }
    }
  }
  
  total
}
```

On the test data:

``` r
solve_part_1("test_input.txt")
```

    [1] 3

And on the real data:

``` r
solve_part_1("input.txt")
```

    [1] 664

And that’s correct!

## Part 2

Turns out I need some **dplyr** to do this one cleanly.

``` r
suppressPackageStartupMessages(library(dplyr))
```

We now only need to determine how many IDs can be considered fresh. In
order to do this, I first order the endpoints data by start. Then I
compare the firsttwo rows of the endpoints data at a time and check
whether their ranges overlap. If they do, I create a new row from the
expanded range (i.e. old start to new end). If they do not, that range
is added to a new data frame that contains only the non-overlapping
ranges. I then get the length of each range and sum those lengths.

``` r
solve_part_2 <- function(fname) {
  input <- read_input(fname)
  
  # Convert the `endpoints` list to a matrix, and then into a data frame,
  # sorted by `start`
  endpoints_matrix <- unlist(input$endpoints) |> matrix(ncol = 2, byrow = TRUE)
  endpoints_df <- tibble(
    start = endpoints_matrix[, 1], 
    end = endpoints_matrix[, 2]
  ) |> 
    arrange(start, end)
  
  # Initialize a data frame to store the disjoint ranges
  disjoint_ranges <- tibble(start = NULL, end = NULL)
  
  # Start a while loop that will break when we only have one row in the original
  # data frame left
  while (TRUE) {
    if (nrow(endpoints_df) == 1) {
      # When we only have one row left, add it to `disjoint_ranges` and break
      disjoint_ranges <- bind_rows(disjoint_ranges, endpoints_df)
      break
    }
    
    # Extract the first two rows
    first <- endpoints_df[1, ]
    second <- endpoints_df[2, ]
    endpoints_df <- endpoints_df[c(-1, -2), ]
  
    # If the two ranges do not overlap, add the first row to `disjoint_ranges`
    # and merge the second row back into the original data frame
    if (second$start > first$end) {
      disjoint_ranges <- bind_rows(disjoint_ranges, first)
      endpoints_df <- bind_rows(second, endpoints_df)
    } else {
      # If the two ranges overlap, take the first start and the second end
      # and prepend the original data frame
      expanded_range <- tibble(start = first$start, end = second$end)
      endpoints_df <- bind_rows(expanded_range, endpoints_df)
    }
  }
  
  disjoint_ranges |> mutate(diff = end - start + 1) |> 
    summarize(total = as.character(sum(diff))) |> 
    pull()
}
```

``` r
start <- Sys.time()
solve_part_2("test_input.txt")
```

    [1] "14"

``` r
end <- Sys.time()
end - start
```

    Time difference of 0.012501 secs

That’s correct for the test input. Now the real input:

``` r
start <- Sys.time()
solve_part_2("input.txt")
```

    [1] "339010840722817"

``` r
end <- Sys.time()
end - start
```

    Time difference of 0.03765798 secs

Correct!
