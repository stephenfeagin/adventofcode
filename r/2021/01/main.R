args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
    stop("Must provide input file name")
}

read_input <- function(fname) {
    as.numeric(readLines(fname, warn = FALSE))
}

part_1 <- function(dat) {
    total <- 0
    for (i in seq_len(length(dat) - 1)){
        if (dat[i] < dat[i + 1]) {
            total <- total + 1
        }
    }
    total
}

part_2 <- function(dat) {
    total <- 0
    for (i in seq_len(length(dat) - 3)) {
        if (sum(dat[(i + 1) : (i + 3)]) > sum(dat[i : (i + 2)])) {
            total <- total + 1
        }
    }
    total
}

dat <- read_input(args[1])
print(part_1(dat))
print(part_2(dat))
