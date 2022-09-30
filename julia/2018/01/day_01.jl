# 2018 Day 1: Chronal Calibration

function parse_list(fname)
    [parse(Int, line) for line in readlines(fname)]
end

function part_1(data)
    sum(data)
end

function part_2(data)
    frequency_list = [0]
    current_frequency = 0

    while true
        for change in data
            current_frequency += change
            if in(current_frequency, frequency_list)
                return current_frequency
            end
            append!(frequency_list, current_frequency)
        end
    end
end

