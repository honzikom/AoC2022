cd("/home/janbohm/Dokumenty/AoC/2022/")

game = readlines("./input02.csv")
game = split.(game, " ")

## part 1
# points for wins
score = 0
for match in game
    if match in [["A", "Y"], ["B", "Z"], ["C", "X"]]
        score += 6
    elseif match in [["A", "X"], ["B", "Y"], ["C", "Z"]]
        score += 3
    end
end

# points for play
gameM = reduce(hcat, game)
score += 1 * sum(gameM[2,:] .== "X")
score += 2 * sum(gameM[2,:] .== "Y")
score += 3 * sum(gameM[2,:] .== "Z")

println("Solution of part I: ", score)

## part 2
score = 0
for match in game
    if match in [["B", "X"], ["A", "Y"], ["C", "Z"]]
        score += 1
    elseif match in [["C", "X"], ["B", "Y"], ["A", "Z"]]
        score += 2
    else
        score += 3
    end
end

score += 3 * sum(gameM[2,:] .== "Y")
score += 6 * sum(gameM[2,:] .== "Z")

println("Solution of part II: ", score)
