cd("/home/janbohm/Dokumenty/AoC/2022/")

input = readlines("./input09.csv")

# function for part I (two point rope)
function moveTail(head, tail)
        if (head[1]-tail[1])^2 + (head[2]-tail[2])^2 <= 2
                return tail
        end
        if head[1] == tail[1]
                if head[2] - 2 == tail[2]
                        tail[2] += 1
                        return tail
                elseif head[2] + 2 == tail[2]
                        tail[2] -= 1
                        return tail
                end
        elseif head[2] == tail[2]
                if head[1] - 2 == tail[1]
                        tail[1] += 1
                        return tail
                elseif head[1] + 2 == tail[1]
                        tail[1] -= 1
                        return tail
                end
        else
                if head[1] > tail[1]
                        h = 1
                else
                        h = -1
                end
                if head[2] > tail[2]
                        v = 1
                else
                        v = -1
                end
                tail[1] += h
                tail[2] += v
                return tail
        end
end

# function for movement of long rope (part II)
function moveRope(rope, direction)
        if direction == "L"
                rope[1][1] -= 1
        elseif direction == "R"
                rope[1][1] += 1
        elseif direction == "D"
                rope[1][2] -= 1
        elseif direction == "U"
                rope[1][2] += 1
        end
        for i in 2:10
                rope[i] = moveTail(rope[i-1], rope[i])
        end
        return rope
end

# init values for part I
tailPositions = []
head = [0,0]
tail = [0,0]

# solve part I
for line in input
        line = split(line," ")
        for i in 1:parse(Int, line[2])
                if line[1] == "L"
                        head[1] -= 1
                        tail = moveTail(head, tail)
                elseif line[1] == "R"
                        head[1] += 1
                        tail = moveTail(head, tail)
                elseif line[1] == "D"
                        head[2] -= 1
                        tail = moveTail(head, tail)
                elseif line[1] == "U"
                        head[2] += 1
                        tail = moveTail(head, tail)
                end
                push!(tailPositions, deepcopy(tail))
        end
end

println("Solution of part I: ", length(unique(tailPositions)))

# init values for part II
rope = [[0,0] for i in 1:10]
tailPositions = []

# solve part II
for line in input
        line = split(line, " ")
        for i in 1:parse(Int, line[2])
                rope = moveRope(rope, line[1])
                push!(tailPositions, deepcopy(last(rope)))
        end
end

println("Solution of part II: ", length(unique(tailPositions)))
