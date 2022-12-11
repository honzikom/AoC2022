input = read("input11.csv", String)
input = split(input, "\r\n\r")

monkeys = []
for m in input
    m = split(m, "\r\n")
    items = []
    mis = split(m[2], " ")
    for mi in mis
        mi = split(mi, ",")[1]
        if tryparse(Int, mi) != nothing 
            push!(items, parse(Int, mi))
        end
    end
    mop = split(m[3], " ")
    if mop[8] == "old" 
        op = ["^", 2]
    else
        op = [mop[7], parse(Int, mop[8])]
    end
    divTest = parse(Int, last(split(m[4], " ")))
    testT = 1 + parse(Int, last(split(m[5], " "))) #Julia indexing 
    testF = 1 + parse(Int, last(split(m[6], " ")))
    test = [divTest, testT, testF]
    push!(monkeys,[items, op, test])
end

function solveMonkey(m, monkeys)
    monkey = monkeys[m]
    score = length(monkey[1])
    for item in monkey[1]
        if monkey[2][1] == "^"
            item *= item 
        elseif monkey[2][1] == "*"
            item *= monkey[2][2]
        else
            item += monkey[2][2]
        end
        item ÷= 3
        newM = (item % monkey[3][1]) == 0 ? monkey[3][2] : monkey[3][3]
        push!(monkeys[newM][1], item)
    end
    monkeys[m][1] = []
    return monkeys, score
end

LCM = 1
for i in 1:length(monkeys)
    LCM *= monkeys[i][3][1]
end

function solveMonkey2(m, monkeys, LCM)
    monkey = monkeys[m]
    score = length(monkey[1])
    for item in monkey[1]
        if monkey[2][1] == "^"
            item *= item 
        elseif monkey[2][1] == "*"
            item *= monkey[2][2]
        else
            item += monkey[2][2]
        end
        item = item % LCM
        newM = (item % monkey[3][1]) == 0 ? monkey[3][2] : monkey[3][3]
        push!(monkeys[newM][1], item)
    end
    monkeys[m][1] = []
    return monkeys, score
end

scores = zeros(length(monkeys))
for r in 1:10000
    for i in 1:length(monkeys)
        M = solveMonkey2(i, monkeys, LCM)
        monkeys = M[1]
        scores[i] += M[2]
    end
end
println(scores)


monkeyBusiness = sort(scores, rev = true)
monkeyBusiness = monkeyBusiness[1]*monkeyBusiness[2]
println("Solution of part I: ", Int(monkeyBusiness))