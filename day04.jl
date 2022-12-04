cd("C:/Users/janbo/Documents/AoC2022")

elves = readlines("./input04.csv")

elves = split.(elves, ",")
nIncluded = 0
for elf in elves
    elf = split.(elf, "-")
    elf = parse.(Int, reduce(vcat,reduce(hcat, elf)))
    if (elf[1] <= elf[3] && elf[2] >= elf[4]) || (elf[1] >= elf[3] && elf[2] <= elf[4])
        nIncluded += 1
    end
end

println("Solution of part I: ", nIncluded)

nOverlaps = 0
for elf in elves
    elf = split.(elf, "-")
    elf = parse.(Int, reduce(vcat,reduce(hcat, elf)))
    if !(elf[2] < elf[3] || elf[4] < elf[1])
        nOverlaps += 1
    end
end

println("Solution of part II: ", nOverlaps)
