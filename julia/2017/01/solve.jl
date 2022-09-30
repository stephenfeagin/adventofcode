if length(ARGS) != 1
    error("You must provide an input file as an argument")
end

include("day01.jl")

const INPUT = readline(ARGS[1])
println("Part 1: ", part1(INPUT))
println("Part 2: ", part2(INPUT))
