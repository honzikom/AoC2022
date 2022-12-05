cd("/home/janbohm/Dokumenty/AoC/2022/")

crates = readlines("./input05part1.csv")
moves = readlines("./input05part2.csv")

# the hardest part: turn crates into something usable
crates = split.(crates, "")
betterCrates = []

crates = reshape(reduce(hcat,crates), 35, 9)
crates = permutedims(crates, (2,1))

crates = crates[:,2:4:34]
for i in 1:9
    c = crates[:,i]
    c = c[c .!= " "]
    push!(betterCrates, first(c, length(c)-1))
end

# crates are ready, now let's work with moves
for m in moves
    m = parse.(Int,split(m, " ")[[2,4,6]])
    shift = first(betterCrates[m[2]], m[1])
    betterCrates[m[2]] = last(betterCrates[m[2]], length(betterCrates[m[2]])-m[1])
    betterCrates[m[3]] = [reverse(shift); betterCrates[m[3]] ]
end

# I could read it from array, but let's create proper solution
result = ""
for i in 1:9
    result *= betterCrates[i][1]
end

println("Solution of part I: ", result)

# take again betterCrates
betterCrates = []
for i in 1:9
    c = crates[:,i]
    c = c[c .!= " "]
    push!(betterCrates, first(c, length(c)-1))
end

# ha, just delete the reverse!
for m in moves
    m = parse.(Int,split(m, " ")[[2,4,6]])
    shift = first(betterCrates[m[2]], m[1])
    betterCrates[m[2]] = last(betterCrates[m[2]], length(betterCrates[m[2]])-m[1])
    betterCrates[m[3]] = [shift; betterCrates[m[3]] ]
end

result = ""
for i in 1:9
    result *= betterCrates[i][1]
end

println("Solution of part II: ", result)
