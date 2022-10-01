args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Must provide input file name")
}

read_input <- function(fname) {
  input <- readLines(fname, warn = FALSE)
  numbers <- as.integer(strsplit(input, ",")[[1]])
  numbers
}

decrement_one_fish <- function(fish) {
  # Don't want to do the modulo if a fish is *supposed to be* 7 or greater
  if (fish < 7L) {
    (fish - 1L) %% 7L
  }
  else {
    fish - 1L
  }
}

decrement <- function(vec) {
  # Get the number of new fish that will be spawned
  new_fish <- sum(vec == 0L)
  # Decrement
  fish <- sapply(vec, decrement_one_fish)
  # Add on new fish at the end
  fish <- c(fish, rep(8L, times = new_fish))
  fish
}

# How many fish are there after 80 days?
part_1 <- function(input) {
  for (i in seq_len(80L)) {
    input <- decrement(input)
  }
  length(input)
}

vec_from_input <- function(input) {
  vec <- numeric(9)
  for (i in 1:9) {
    vec[i] <- sum(input == (i - 1))
  }
  vec
}

decrement_part_2 <- function(vec) {
  # number_of_new_fish represents both the number of new fish that will be spawned
  # and the number of fish that spawned them
  # The first group sets their count at 8, the second at 6
  number_of_new_fish <- vec[1]
  for (i in 1:8) {
    vec[i] <- vec[i+1]
  }
  vec[9] <- number_of_new_fish
  # sum of those fish that got to 7 from decrementing as well as those whose clocks reset
  vec[7] <- vec[7] + number_of_new_fish 
  vec
}

# Can't do part 2 the same way as part 1, it's too computationally intensive.
# Instead, I'm going to borrow the logic behind a solution I saw on Reddit.
# The idea is to keep track of the number of fish at each countdown number,
# rather than each individual fish. When you decrement, move everything over
# one column
part_2 <- function(input) {
  # Do some blunt force data shaping to start out with
  vec <- vec_from_input(input)
  
  for (i in 1:256) {
    vec <- decrement_part_2(vec)
  }
  format(sum(vec), scientific = FALSE)
}

input <- read_input(args[1])
print(part_1(input))
print(part_2(input))
