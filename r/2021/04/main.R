args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("Must provide input file name")
}

library(stringr)

read_input <- function(fname) {
  # Read lines as character vector
  lines <- readLines(fname, warn = FALSE)
  
  # The first line is the list of drawn numbers
  draws <- str_split(lines[1], ",")
  draws <- as.numeric(draws[[1]])
  
  # Create an empty list to hold the boards
  boards <- list()
  i <- 3  # start at line 3 because 1 is draws and 2 is ""
  while (i < length(lines)) {
    if (lines[i] == "") {  # skip empty lines
      i <- i + 1
      next
    }
    scrubbed_lines <- numeric()  # empty vector to hold the parsed board line
    # i:i+4 gives us five lines to process every time we go through the outer while loop
    for (j in i:(i+4)) {
      # The lines are space delimited. This removes any extraneous spaces between the numbers, which
      # would introduce NAs by coercion (that is the str_squish part)
      # Then split on the spaces and convert to numeric
      l <- as.numeric(str_split(str_squish(lines[j]), " ")[[1]])
      # Concatenate into the results vector
      scrubbed_lines <- c(scrubbed_lines, l)
    }
    # Convert the vector of scrubbed lines into a 5x5 matrix, being sure to populate it by row
    scrubbed_lines <- matrix(scrubbed_lines, ncol = 5, nrow = 5, byrow = TRUE)
    # Add the new board into the list
    boards[[length(boards) + 1]] <- scrubbed_lines
    # Increment by 5 to get to the start of the next board
    i <- i + 5
  }
  
  list(draws = draws, boards = boards)
}

# For a given drawn number and board, return a new board with the number marked as -1 if present in the board
# -1 is used for ease of checking rowSums for completed rows or columns
# Note that this solution is not robust to inputs that include negative numbers in the draws and boards
draw_number <- function(draw, board) {
  if (!(draw %in% board)) {
    return(board)
  }
  board[board == draw] <- -1
  return(board)
}

# This function does the heavy lifting for part 1
play_bingo_1 <- function(input) {
  for (i in input$draws) {  # Iterate first through the drawn numbers
    for (j in seq_along(input$boards)) {  # For a given drawn number, for each board, run draw_number to mark it
      input$boards[[j]] <- draw_number(i, input$boards[[j]])
      
      # The marginal sums will be -5 if and only if all 5 numbers in a column or row have been marked -1
      # Again, this solution is not robust to inputs that include negative numbers
      if (any(colSums(input$boards[[j]]) == -5)  || any(rowSums(input$boards[[j]]) == -5)) {
        return(list(draw = i, board = input$boards[[j]]))  # return to break out of both loops
      }
    }
  }
}

part_1 <- function(input) {
  result <- play_bingo_1(input)
  sum(result$board[result$board != -1]) * result$draw
}

# Playing bingo for part 2
play_bingo_2 <- function(input) {
  # Create a logical vector to keep track of whether a given board has won
  # Because we need to remove boards from play after they have been won, but we don't want to affect
  # the underlying list of boards that we're iterating over, we instead create a vector that will
  # keep track of it and let us check against it
  boards_won <- logical(length(input$boards))
  for (i in input$draws) {
    for (j in seq_along(input$boards)) {
      if (!boards_won[j]) {  # If this particular board hasn't been won yet
        input$boards[[j]] <- draw_number(i, input$boards[[j]])  # draw number
        if (any(colSums(input$boards[[j]]) == -5)  || any(rowSums(input$boards[[j]]) == -5)) {  # If this boards has won
          boards_won[j] <- TRUE  # Mark it in the vector to keep track
          if (all(boards_won)) {  # If all boards are won, it means that the current boards was the last one to win
            return(list(draw = i, board = input$boards[[j]]))
          }
        }
      }
    }
  }
}

part_2 <- function(input) {
  result <- play_bingo_2(input)
  sum(result$board[result$board != -1]) * result$draw
}

input <- read_input(args[1])
print(paste("Part 1:", part_1(input)))
print(paste("Part 2:", part_2(input)))
