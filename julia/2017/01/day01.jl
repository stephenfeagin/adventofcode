"""
    part1(input)

The captcha requires you to review a sequence of digits (your puzzle input) and
find the sum of all digits that match the next digit in the list. The list is
circular, so the digit after the last digit is the first digit in the list.

Because the input must be a sequence of digits, I don't have to worry about the
indexing complications that arise from multi-byte unicode points

# Examples
```julia-repl
julia> part1("1122")
3

julia> part1("1111")
4

julia> part1("1234")
0

julia> part1("91212129")
9
```
"""
function part1(input)
    result = 0

    for ind in 1:lastindex(input)
        next_ind = ind % lastindex(input) + 1
        if input[ind] == input[next_ind]
            result += parse(Int, input[ind])
        end
    end

    return result
end

"""
    part2(input)


Now, instead of considering the next digit, it wants you to consider the digit
halfway around the circular list. That is, if your list contains 10 items, only
include a digit in your sum if the digit 10/2 = 5 steps forward matches it.
Fortunately, your list has an even number of elements.

We work out half the distance around the circular list (which is assumed to
have even length). If the current index + half is greater than the length of
the string, then take index + half mod length(input).

# Examples
```julia-repl
julia> part2("1212")
4

julia> part2("1221")
0

julia> part2("123425")
4

julia> part2("123123")
12

julia> part2("12131415")
4
```
"""
function part2(input)
    result = 0
    input_len = length(input)
    half = div(input_len, 2)

    for ind in 1:lastindex(input)
        if ind + half > input_len
            next_ind = (ind + half) % input_len
        else
            next_ind = ind + half
        end
        if input[ind] == input[next_ind]
            result += parse(Int, input[ind])
        end
    end
    result
end
