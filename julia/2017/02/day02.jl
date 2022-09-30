"""
	read_input(fname)

Read an input file for Advent of Code 2017 day 2.

# Examples
```jldoctest
julia> read_input("test_input_1.txt")
3-element Array{Array{Int64,1},1}:
 [5, 1, 9, 5]
 [7, 5, 3]
 [2, 4, 6, 8]
```
"""
function read_input(fname)
	open(fname) do file
		[parse.(Int, split(ln)) for ln in eachline(file)]
	end
end

