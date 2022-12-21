cd("/home/janbohm/Dokumenty/AoC/2022/")

using FreqTables

input = readlines("./input15small.csv")
input = readlines("./input15.csv")

inputM = fill(0, (length(input),  4))
for i in 1:length(input)
    line = split(input[i], " ")
    inputM[i,1] = parse(Int,last(first(line[3], length(line[3])-1), length(line[3])-3))
    inputM[i,2] = parse(Int,last(first(line[4], length(line[4])-1), length(line[4])-3))
    inputM[i,3] = parse(Int,last(first(line[9], length(line[9])-1), length(line[9])-3))
    inputM[i,4] = parse(Int,last(line[10], length(line[10])-2))
end

function l1(X, Y)
    return abs(X[1]-Y[1]) + abs(X[2]-Y[2])
end

rangeX = floor.(3 .* collect(extrema(inputM, dims= 1)[3]))


count = 0
yT = 2000000
for x in rangeX[1]:rangeX[2]
    X = [x,yT]
    for row in eachrow(inputM)
        if l1(X, [row[1], row[2]]) <= l1([row[1], row[2]], [row[3], row[4]])
                count += 1
                break
        end
    end
end


count -= sum(inputM[:,2] .== yT) + sum(unique(inputM[:,3:4], dims = 1)[:,2] .== yT)

println("Solution of part I: ", count)

# Ta-Da; lol

# Part II

function l1circle(C, d, maxx = 4000000)
    circ = []
    X = [C[1]-d, C[2]]
    for i in 1:(4*d)
        if X[1] < C[1] && X[2]>=C[2]
            X[1] += 1
            X[2] += 1
        elseif X[1] >= C[1] && X[2] > C[2]
            X[1] += 1
            X[2] -= 1
        elseif X[1] > C[1] && X[2] <= C[2]
            X[1] -=1
            X[2] -= 1
        elseif X[1] <= C[1] && X[2] < C[2]
            X[1] -= 1
            X[2] += 1
        end
        if X[1] >= 0 && X[2] >= 0 && X[1] <= maxx && X[2] <= maxx
            push!(circ, deepcopy(X))
        end
    end
    return circ
end

function isItMissingBeacon(X, inputM)
    for row in eachrow(inputM)
        dB = l1([row[1], row[2]],[row[3], row[4]])
        dX = l1([row[1], row[2]],[X[1], X[2]])
        if dX <= dB
            return false
        end
    end
    println("Point ", X, "is hidden beacon!\n")
    return true
end


for row in eachrow(inputM)
    d = l1([row[1], row[2]],[row[3], row[4]])
    d += 1 # get to outside border
    b = l1circle([row[1], row[2]], d)
    # for each in b test if it could be the beacon!
    for X in b
        if isItMissingBeacon(X, inputM)
            break
        end
    end
end
