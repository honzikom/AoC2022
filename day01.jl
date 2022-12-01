cd("/home/janbohm/Dokumenty/AoC/2022/")

kCal = read("./input01.csv", String)
kCal = split(kCal, "\n\n")
kCal = first(kCal, length(kCal)-1)

elves = []

for food in kCal
    push!(elves,sum(parse.(Int,split(food, "\n"))))
end

println("Solution of part 1: ", maximum(elves))

println("Solution of part 2: ", sum(sort(elves, rev = true)[1:3]))
