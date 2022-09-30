#! /usr/bin/env julia

include("day_01.jl")

const INPUT = parse_list("input.txt")

println("Part 1: ", part_1(INPUT))
println("Part 2: ", part_2(INPUT))

