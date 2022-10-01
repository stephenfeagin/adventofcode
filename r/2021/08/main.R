args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Must provide input file name")
}

read_input <- function(fname) {
  input <- readLines(fname, warn = FALSE)
  input <- strsplit(input, " ")
  input_mat <- matrix("", nrow = length(input), ncol = 10)
  for (i in seq_along(input)) {
    input_mat[i, ] <- input[[i]][1:10]
  }
  
  output_mat <- matrix("", nrow = length(input), ncol = 4)
  for (i in seq_along(input)) {
    output_mat[i, ] <- input[[i]][12:15]
  }

  list(input = input_mat, output = output_mat)
}

part_1 <- function(data_list) {
  unique_segment_counts <- c(2, 3, 4, 7)
  sum(nchar(data_list$output) %in% unique_segment_counts)
}

input <- read_input("2021/08/input.txt")
print(part_1(input))
# print(part_2(input))
