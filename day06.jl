cd("/home/janbohm/Dokumenty/AoC/2022/")

input = read("./input06.csv", String)
input = split(input, "")

# Part I: 
for i in 1:length(input)-3
    if length(unique(input[i:(i+3)])) == 4
        println("Solution of part I: ", i+3)
        break
    end
end


# Part II:
for i in 1:length(input)-13
    if length(unique(input[i:(i+13)])) == 14
        println("Solution of part II: ", i+13)
        break
    end
end
