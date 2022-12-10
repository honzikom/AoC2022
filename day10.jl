input = readlines("./input10.csv")

X = [1]
cycle = 0
for line in input
    if line == "noop"
        push!(X, last(X))
    else
        line = split(line, " ")
        line[1] == "addx"
        for i in 1:2
            if i == 2
                push!(X, last(X) + parse(Int, line[2]))
            else
                push!(X, last(X))
            end
        end
    end
end


ind =  [20, 60, 100, 140, 180, 220]
println("Solution of part I: ",  sum(X[ind] .* ind))

Y = permutedims(reshape(last(X, length(X)-1), 40, 6), (2, 1))
Z = zeros(size(Y)) .== 1

for y in 1:6
    for x in 1:40
        println(ind)
        Z[y, x] = Y[y, x] in (x-1):(x+1)
    end
end

println("Solution of part II:")
Z