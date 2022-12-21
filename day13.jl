cd("/home/janbohm/Dokumenty/AoC/2022/")

input = readlines("./input13small.csv")


left = eval(Meta.parse(input[22]))
right = eval(Meta.parse(input[23]))

function compare(left, right)
    leftR = left
    while true
        l = length(leftR)
        leftR = reduce(vcat, leftR)
        if l == length(leftR)
            break
        end
    end
    rightR = right
    while true
        r = length(rightR)
        rightR = reduce(vcat, rightR)
        if r == length(rightR)
            break
        end
    end
    L = []
    L = lengthsOfArrays(left, L)
    R = []
    R = lengthsOfArrays(right, R)
end


function lengthsOfArrays(x, L)
    pushfirst!(L,length(x))
    I = eachindex(x)
    for i in I
        if length(x[i]) <= 1
            # do nothing
        else
            L = lengthsOfArrays(x[i],L)
        end
    end
    return L
end

left = input[1]
right = input[2]
function compareStrings(left, right)
    iL = 1
    iR = 1
    lPar = [0,0]
    rPar = [0,0]

    while true
        nR = -Inf
        nL = -Inf
        # read next input in left - a numner nL or another paranthesis
        newLeft = true
        while newLeft
            if string(left[iL]) == "["
                lPar[1] += 1
                newLeft = false
            elseif string(left[iL]) == "]"
                lPar[2] += 1
                newLeft = false
            elseif string(left[iL]) == ","
            else
                nL = left[iL]
                while string(left[iL+1]) != "," && string(left[iL+1]) != "]"
                    nL *= left[iL+1]
                    iL += 1
                end
                nL = parse(Int, nL)
                newLeft = false
            end
            iL += 1
        end
        # read next input in left - a numner nR or another paranthesis
        newRight = true
        while newRight
            if string(right[iR]) == "["
                newRight = false
                rPar[1] += 1
            elseif string(right[iR]) == "]"
                rPar[2] += 1
                newRight = false
            elseif string(right[iR]) == ","
            else
                nR = right[iR]
                while string(right[iR+1]) != "," && string(right[iR+1]) != "]"
                    nR *= right[iR+1]
                    iR += 1
                end
                nR = parse(Int, nR)
                newRight = false
            end
            iR += 1
        end
        # if number of paranthesis don't match, we have a winner
        if rPar[2] > lPar[2]
            println([lPar[2], rPar[2]])
            return "right"
        elseif rPar[2] < lPar[2]
            println([lPar[2], rPar[2]])
            return "left"
        end
        # else compare numbers
        if nR >= 0 && nL >= 0
            if nR > nL
                println([nL, nR])
                return "left"
            elseif nL > nR
                println([nL, nR])
                return "right"
            end
        end
end
end

println("---------")
for i in 1:((length(input)+1) ÷ 3)
    println("---------")
    left = input[3*(i-1)+1]
    right = input[3*(i-1)+2]
    result = compareStrings(left, right)
    println(result)
end
