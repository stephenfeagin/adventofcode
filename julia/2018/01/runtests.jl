using Test

include("day_01.jl")

@testset "Part 1 examples" begin
    @test part_1([1, -2, 3, 1]) == 3
    @test part_1([1, 1, -2]) == 0
    @test part_1([-1, -2, 3]) == 0
end

@testset "Part 2 examples" begin
    @test part_2([1, -2, 3, 1]) == 2
    @test part_2([1, -1]) == 0
    @test part_2([3, 3, 4, -2, -4]) == 10
    @test part_2([-6, 3, 8, 5, -6]) == 5
    @test part_2([7, 7, -2, -7, 4]) == 14
end
