using Test

include("day01.jl")

@testset "Part 1 examples" begin
    @test part1("1122") == 3
    @test part1("1111") == 4
    @test part1("1234") == 0
    @test part1("91212129") == 9
end

@testset "Part 2 examples" begin
    @test part2("1212") == 6
    @test part2("1221") == 0
    @test part2("123425") == 4
    @test part2("123123") == 12
    @test part2("12131415") == 4
end
