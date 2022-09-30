#! /usr/bin/env julia

include("day_03.jl")

const FNAME = "input.txt"
const RAWFILE = readlines(FNAME)
const SIDE = 1000
const claims = map(x -> parse_input(x), RAWFILE)
const squarecounts = tallysquares(claims, SIDE)

println(part1(squarecounts))
println(part2(claims, squarecounts))
