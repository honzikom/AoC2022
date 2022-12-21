cd("/home/janbohm/Dokumenty/AoC/2022/")

#input = readlines("./input14.csv")
input = readlines("./input14small.csv")

# searc for size
caveDim = split.(input, " -> ")
caveDim = reduce(vcat, caveDim)
caveDim = split.(caveDim, ",")
caveDim = reshape(reduce(vcat, caveDim), (2,length(caveDim)))
caveDim = parse.(Int, caveDim)
#println(extrema(caveDim, dims = 2))
# 0-1000 on x should suffice
# 0-173 on y should be enough

#caves = fill("", 1000*173)
#caves = reshape(caves, (1000,173))

caves = fill("", 1000*9)
caves = reshape(caves, (1000,9))

# let's build caves
for line in input
    line = split(line, " -> ")
    x = parse.(Int,split(line[1], ","))
    for i in 2:length(line)
        y = parse.(Int,split(line[i], ","))
        X = sort([x[1], y[1]])
        Y = sort([x[2], y[2]])
        caves[X[1]:X[2],Y[1]:Y[2]] .= "#"
        x = deepcopy(y)
    end
end
caves[500,1] = "+"

function dropSingleGrainOfSand(caves)
    falling = true
    sand = [500,1]
    while falling
        if sand[2] == size(caves)[2]
            return "piskej konec"
        end
        if caves[sand[1], sand[2]+1] == ""
            sand[2] += 1
        elseif caves[sand[1]-1, sand[2]+1] == ""
            sand[1] -= 1
            sand[2] += 1
        elseif caves[sand[1]+1, sand[2]+1] == ""
            sand[1] += 1
            sand[2] += 1
        else
            falling = false
            caves[sand[1], sand[2]] = "o"
        end
    end
    return caves
end

grains = 0
while true
    caves = dropSingleGrainOfSand(caves)
    if caves == "piskej konec"
        println("Solution of part I: ", grains)
        break
    else
        grains += 1
    end
end

# Part II
input = readlines("./input14.csv")
caves = fill("", 1000*176)
caves = reshape(caves, (1000,176))

# let's build caves
for line in input
    line = split(line, " -> ")
    x = parse.(Int,split(line[1], ","))
    for i in 2:length(line)
        y = parse.(Int,split(line[i], ","))
        X = sort([x[1], y[1]])
        Y = sort([x[2], y[2]])
        caves[X[1]+1:X[2]+1,Y[1]+1:Y[2]+1] .= "#"
        x = deepcopy(y)
    end
end
caves[501,1] = "+"
caves[1:1000, size(caves)[2]] .= "#"

function dropSingleGrainOfSand2(caves)
    falling = true
    sand = [501,1]
    while falling
        if caves[sand[1], sand[2]+1] == ""
            sand[2] += 1
        elseif caves[sand[1]-1, sand[2]+1] == ""
            sand[1] -= 1
            sand[2] += 1
        elseif caves[sand[1]+1, sand[2]+1] == ""
            sand[1] += 1
            sand[2] += 1
        else
            falling = false
            caves[sand[1], sand[2]] = "o"
        end
    end
    return caves
end

grains = 0
while true
    caves = dropSingleGrainOfSand2(caves)
    if caves[501,1] == "o"
        println("Solution of part II: ", grains + 1 )
        break
    else
        grains += 1
    end
end
