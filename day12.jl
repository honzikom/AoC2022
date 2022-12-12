cd("/home/janbohm/Dokumenty/AoC/2022/")
using Missings

map = readlines("./input12.csv")
H = length(map)
W = length(map[1])
map = reduce(vcat, split.(map, ""))
map = permutedims(reshape(map, (W,H)), (2,1))

start = findall(map.== "S")
finish = findall(map.== "E")

letters = collect('a':'z')
for i in 1:26
    map[map .== string(letters[i])] .= string(i)
end

map[start] .= "1"
map[finish] .= "26"
map = parse.(Int, map)

# function for adding another position to steps
function move(map, steps, x0, y0, x1, y1)
    if steps[x1, y1] < 0
        if map[x1, y1] - map[x0, y0] <= 1
            steps[x1,y1] = steps[x0,y0] + 1
        end
    end
    return steps
end

# current distance

function shortestTrail(map, start, finish)
        steps = zeros(size(map)) .- Inf
        steps[start[1], start[2]] = 0
        while reduce(vcat,steps[finish]) < 0
            d = maximum(steps)
            # find neighbours
            currentPos = findall(steps .== d)
            #get Nighbours

            neigh = []
            for p in currentPos
                if p[1] > 1
                    steps = move(map, steps, p[1], p[2], p[1]-1, p[2])
                end
                if p[1] < H
                    steps = move(map, steps, p[1], p[2], p[1]+1, p[2])
                end
                if p[2] > 1
                    steps = move(map, steps, p[1], p[2], p[1], p[2]-1)
                end
                if p[2] < W
                    steps = move(map, steps, p[1], p[2], p[1], p[2]+1)
                end
            end
            if maximum(steps) == d
                return Inf
            end
        end
        return  Int(reduce(vcat, steps[finish]))
end

partI = shortestTrail(map, start[1], finish)
println("Solution of part 1: ", partI)

# part II

startA = findall(map .== 1)
shortest = Inf
for s in 1 : length(startA)
    trailL = shortestTrail(map, [startA[s][1], startA[s][2]], finish)
    if trailL < shortest
        shortest = trailL
    end
end

println("Solution of part II: ", shortest)
