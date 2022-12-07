cd("/home/janbohm/Dokumenty/AoC/2022/")

input = readlines("./input07.csv")

paths = []
sizes = []

function cdUp(path)
    path = split(path, "/")
    path = first(path, length(path)-1)
    newPath = "/"
    for i in 2:length(path)
        newPath *= path[i]
        if i < length(path)
            newPath *= "/"
        end
    end
    return newPath
end

directories = []
files = []
fileSizes = []
path = ""
inDir = false
for line in input
    line = split(line, " ")
    if line[2] == "cd"
        # move in directories and save result in directories
        indir = false
        if line[3] == "/"
            path = "/"
        elseif line[3] == ".."
            path = cdUp(path)
        else
            if path == "/"
                path *= line[3]
            else
                path *= "/" * line[3]
            end
        end
        push!(directories, path)
    end
    if line[2] == "ls"
        # start ls
        inDir = true
    end
    if line[2] != "ls" && line[2] != "cd" && inDir
        #I care only about files
        if line[1] != "dir"
            if path == "/"
                    push!(files, path * line[2])
                else
                    push!(files, path * "/" * line[2])
                end
            push!(fileSizes,  parse(Int,line[1]))
        end
    end
end

unique!(directories)
dirSize = zeros(length(directories))

dirSizes = []
for d in directories
    ind = contains.(files, d)
    push!(dirSizes, sum(fileSizes[ind]))
end

println("Solution of part I: ", sum(dirSizes[dirSizes .<=100000]))

println("Solution of part II: ",
        minimum(dirSizes[dirSizes .>= 30000000-(70000000-dirSizes[1])]))
