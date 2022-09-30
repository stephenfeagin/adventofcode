using Test

include("day02.jl")

@testset "Test reading input" begin
	@test read_input("test_input_1.txt") == [[5 1 9 5], [7 5 3], [2 4 6 8]]
	@test read_input("test_input_2.txt") == [[5 9 2 8], [9 4 7 3], [3 8 6 5]]
end
