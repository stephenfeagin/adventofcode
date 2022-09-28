args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
    stop("Must provide input file name")
}

suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(stringr))

read_input <- function(fname) {
    lines <- readLines(fname)
    char_list <- str_split(lines, "")
    binary <- as.data.frame(t(sapply(char_list, as.numeric)))

    binary
}

get_most_common <- function(vec) {
    zeroes <- sum(vec == 0)
    ones <- sum(vec == 1)

    as.numeric(zeroes <= ones)
}

get_least_common <- function(vec) {
    zeroes <- sum(vec == 0)
    ones <- sum(vec == 1)

    as.numeric(ones < zeroes)
}

part_1 <- function(df) {
    most_common <- lapply(df, get_most_common)
    gamma_binary <- str_flatten(most_common)
    gamma_decimal <- strtoi(gamma_binary, base = 2)

    least_common <- lapply(df, get_least_common)
    epsilon_binary <- str_flatten(least_common)
    epsilon_decimal <- strtoi(epsilon_binary, base = 2)

    gamma_decimal * epsilon_decimal
}

part_2 <- function(df) {

    # Oxygen rating
    most_common <- lapply(df, get_most_common)
    matches <- df
    for (i in seq_len(ncol(df))) {
        most_common <- lapply(matches, get_most_common)
        matches <- matches[matches[i] == most_common[[i]], ]
        if (nrow(matches) == 1) {
            break
        }
    }
    oxygen_binary <- str_flatten(matches)
    oxygen_decimal <- strtoi(oxygen_binary, base = 2)

    # CO2 rating
    matches <- df
    for (i in seq_len(ncol(df))) {
        least_common <- lapply(matches, get_least_common)
        matches <- matches[matches[i] == least_common[[i]], ]
        if (nrow(matches) == 1) {
            break
        }
    }
    co2_binary <- str_flatten(matches)
    co2_decimal <- strtoi(co2_binary, base = 2)

    oxygen_decimal * co2_decimal
}


df <- read_input(args[1])
print(part_1(df))
print(part_2(df))