using Test

include("day_02.jl")

# "Test Part 1"
@test part_1([
    "abcdef",
    "bababc",
    "abbcde",
    "abcccd",
    "aabcdd",
    "abcdee",
    "ababab"
]) == 12 

# "Test Part 2" 
@test part_2([
    "abcde",
    "fghij",
    "klmno",
    "pqrst",
    "fguij",
    "axcye",
    "wvxyz"
]) == "fgij"
