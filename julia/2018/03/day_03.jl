# 2018 Day 3: No Matter How You Slice It


struct Claim
    id::Int
    left::Int
    top::Int
    width::Int
    height::Int
end

function parse_input(item)
    item_parsed = [parse(Int, m.match) for m in eachmatch(r"\d+", item)]
    Claim(item_parsed...)
end


function tallysquares(claims::Array{Claim}, side::Int)
    results = zeros(Int, side, side)

    for item in claims
        results[(1 + item.top):(item.top + item.height),
                (1 + item.left):(item.left + item.width)] .+= 1
    end

    results
end

function part1(squares::Array{Int, 2})
   length(filter(x -> x > 1, squares))
end

function part2(claims::Array{Claim}, squares::Array{Int, 2})
    for item in claims
        subset = squares[(1 + item.top):(item.top + item.height),
                         (1 + item.left):(item.left + item.width)]
        if all(subset .== 1)
            return item.id
        end
    end
end

