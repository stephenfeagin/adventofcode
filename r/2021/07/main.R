args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Must provide input file name")
}

read_input <- function(fname) {
  input <- readLines(fname, warn = FALSE)
  numbers <- as.integer(strsplit(input, ",")[[1]])
  numbers
}

part_1 <- function(input) {
  
}

part_2 <- function(input) {
  
}

# input <- read_input(args[1])