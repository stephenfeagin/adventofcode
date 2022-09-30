args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Must provide input file name")
}

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(tibble))

read_input <- function(fname) {
  lines <- readLines(fname, warn = FALSE)
  pattern <- "(\\d+),(\\d+) -> (\\d+),(\\d+)"
  matches <- str_match(lines, pattern)
  colnames(matches) <- c("original", "x1", "y1", "x2", "y2")
  df <- as_tibble(matches)
  df <- df %>% mutate(across(2:5, as.numeric))
  df
}

part_1 <- function(df) {
  straight_lines <- df[(df$x1 == df$x2) | (df$y1 == df$y2), c("x1", "y1", "x2", "y2")]
  extent <- max(straight_lines)
  vals <- matrix(0, nrow = extent + 1, ncol = extent + 1)  # adding one because the grid is zero-based

  for (i in seq_len(nrow(straight_lines))) {
    x_vals <- straight_lines$x1[i]:straight_lines$x2[i]
    y_vals <- straight_lines$y1[i]:straight_lines$y2[i]
    for (x in x_vals) {
      for (y in y_vals) {
        vals[y+1, x+1] <- vals[y+1, x+1] + 1
      }
    }
  }
  
  sum(vals >= 2)
}

part_2 <- function(df) {
  lines <- df[, c("x1", "y1", "x2", "y2")]
  extent <- max(lines)
  vals <- matrix(0, nrow = extent + 1, ncol = extent + 1)  # adding one because the grid is zero-based

  for (i in seq_len(nrow(lines))) {
    x_vals <- lines$x1[i]:lines$x2[i]
    y_vals <- lines$y1[i]:lines$y2[i]
    line_length <- max(length(x_vals), length(y_vals))
    
    # You have to create a list of the unique points so that you're not filling in the entire square of x1:x2,y1:y2
    pairs <- list()
    for (point in seq_len(line_length)) {
      if (is.na(x_vals[point])) {
        x <- x_vals[1]
      } else {
        x <- x_vals[point]
      }
      if (is.na(y_vals[point])) {
        y <- y_vals[1]
      } else {
        y <- y_vals[point]
      }
      pairs[[length(pairs) + 1]] <- c(x, y)
    }
    
    for (pair in pairs) {
      x <- pair[1]
      y <- pair[2]
      vals[y+1, x+1] <- vals[y+1, x+1] + 1
    }
  }
  
  sum(vals >= 2)
}

input <- read_input(args[1])
print(paste("Part 1:", part_1(input)))
print(paste("Part 2:", part_2(input)))
