cd("/home/janbohm/Dokumenty/AoC/2022/")

input = readlines("./input08.csv")

forest = permutedims(reshape(reduce(vcat,split.(input, "")),99,99), (2,1))
forest = parse.(Int, forest)

function isVisible(x,y, forest)
    # is on edge?
    if x == 1 || x == 99 || y == 1 || y == 99
        return true
    end
    left = forest[1:(x-1),y]
    right = forest[(x+1):99, y]
    above = forest[x, (y+1):99]
    bellow = forest[x, 1:(y-1)]
    visible = all(forest[x,y] .> right) ||
              all(forest[x,y] .> left) ||
              all(forest[x,y] .> above) ||
              all(forest[x,y] .> bellow)
    return visible
end


visibleTrees = 0
for x in 1:99
    for y in 1:99
        visibleTrees += isVisible(x,y,forest)
    end
end

println("Solution of part I: ", visibleTrees)

function scoreTree(x,y,forest = forest)
    visibleTreesL = 0
    visibleTreesR = 0
    visibleTreesA = 0
    visibleTreesB = 0

    if x>1
        xx = x
        while xx > 1
            xx -= 1
            if forest[xx,y] < forest[x,y]
                visibleTreesL += 1
            else
                visibleTreesL += 1
                break
            end
        end
    end
    if x<99
        xx = x
        while xx < 99
            xx += 1
            if forest[xx,y] < forest[x,y]
                visibleTreesR += 1
            else
                visibleTreesR += 1
                break
            end
        end
    end
    if y>1
        yy = y
        while yy > 1
            yy -= 1
            if forest[x,yy] < forest[x,y]
                visibleTreesA += 1
            else
                visibleTreesA += 1
                break
            end
        end
    end
    if y<99
        yy = y
        while yy < 99
            yy += 1
            if forest[x,yy] < forest[x,y]
                visibleTreesB += 1
            else
                visibleTreesB += 1
                break
            end
        end
    end
    return visibleTreesL * visibleTreesR * visibleTreesA * visibleTreesB
end

bestScore = -Inf
for x in 1:99
    for y in 1:99
        s = scoreTree(x, y, forest)
        if s > bestScore
            bestScore = s
        end
    end
end

println("Solution of part II: ", bestScore)
