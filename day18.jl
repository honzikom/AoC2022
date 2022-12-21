cd("/home/janbohm/Dokumenty/AoC/2022/")

input = readlines("./input18.csv")
cubes = []
for line in input
    line = parse.(Int,split(line,","))
    push!(cubes, line)
end

function neighCubes(X)
    off = [[-1,0,0], [1,0,0],
           [0,-1,0], [0,1,0],
           [0,0,-1], [0,0,1]]
    N = []
    for n in off
        push!(N, X .+n)
    end
    return N
end

empty = 0
for cube in cubes
    for c in neighCubes(cube)
        if c ∉ cubes
            empty += 1
        end
    end
end

println("\nSolution of part I: ", empty, "\n")

# part II

# get envelope
function neighCubes3D(X)
    N = []
    for i in -1:1
        for j in -1:1
            for k in -1:1
                if [i,j,k] != [0,0,0]
                    push!(N, X .+[i,j,k])
                end
            end
        end
    end
    return N
end

envelope = []
for cube in cubes
    envelope = vcat(envelope, neighCubes3D(cube))
end
unique!(envelope)
setdiff!(envelope, cubes)

function getChain(envelope)
    chain = [envelope[1]]
    deleteat!(envelope, 1)
    pos = 1
    while pos <= length(chain)
        nc = neighCubes(chain[pos])
        for i in 1:6
            if nc[i] ∈ envelope
                push!(chain, nc[i])
                filter!(x -> x != nc[i], envelope)
            end
        end
        pos += 1
    end
    return chain, envelope
end

connected = []
while length(envelope) > 0
        c, e = getChain(envelope)
        envelope = deepcopy(e)
        push!(connected, c)
end

outIndex = findmax(length.(connected))[2]
out = deepcopy(connected[outIndex])

empty = 0
for cube in cubes
    for c in neighCubes(cube)
        if c ∈ out
            empty += 1
        end
    end
end
