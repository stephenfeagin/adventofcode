args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Must provide input file name")
}

read_input <- function(fname) {
  input <- readLines(fname, warn = FALSE)
  numbers <- as.integer(strsplit(input, ",")[[1]])
  numbers
}

# When cost is related to absolute distance, median is the best approximation that minimizes cost
part_1 <- function(input) {
  best_position <- median(input)
  sum(abs(input - best_position))
}

# For part 2, cost is more than just the distance between two points
get_fuel_cost <- function(start, stop) {
  cost <- 0
  for (i in seq_len(abs(start - stop))) {
    cost <- cost + i
  }
  cost
}

get_total_fuel_cost <- function(vec, pos) {
  sum(sapply(vec, get_fuel_cost, stop = pos))
}

# When cost is measured by compounding distance, mean is the best approximation that minimizes cost
part_2 <- function(input) {
  mean_position <- mean(input)
  mean_floor <- floor(mean_position)
  mean_ceiling <- ceiling(mean_position)
  
  floor_cost <- get_total_fuel_cost(input, mean_floor)
  ceiling_cost <- get_total_fuel_cost(input, mean_ceiling)
  min(c(floor_cost, ceiling_cost))
}

input <- read_input(args[1])
print(part_1(input))
print(part_2(input))
