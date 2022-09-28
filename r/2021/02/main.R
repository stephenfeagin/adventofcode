args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
    stop("Must provide input file name")
}

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(readr))

read_input <- function(fname) {
    read_delim(fname, delim = " ", col_names = c("direction", "magnitude"), show_col_types = FALSE)
}

part_1 <- function(df) {
    df <- df %>%
        group_by(direction) %>%
        summarize(total = sum(magnitude))
    horizontal <- df$total[df$direction == "forward"]
    depth <- df$total[df$direction == "down"] - df$total[df$direction == "up"]
    horizontal * depth
}

part_2 <- function(df) {
    aim <- 0
    depth <- 0
    horizontal <- 0

    for (i in seq_len(nrow(df))) {
        if (df$direction[i] == "down") {
            aim <- aim + df$magnitude[i]
        } else if (df$direction[i] == "up") {
            aim <- aim - df$magnitude[i]
        } else if (df$direction[i] == "forward") {
            horizontal <- horizontal + df$magnitude[i]
            depth <- depth + aim * df$magnitude[i]
        }
    }

    horizontal * depth
}

df <- read_input(args[1])
print(part_1(df))
print(part_2(df))
