cd("/home/janbohm/Dokumenty/AoC/2022/")

input = readlines("./input19.csv")
blueprints = []
for line in input
    line = split(line," ")
    line = parse.(Int, line[[7,13,19,22,28,31]])
    bp = [[2,0,0,0],[3,0,0,0],[3,8,0,0],[3,0,12,0]] #ore, clay, obsidian, geode
    bp[1][1] = line[1]
    bp[2][1] = line[2]
    bp[3][1] = line[3]
    bp[3][2] = line[4]
    bp[4][1] = line[5]
    bp[4][3] = line[6]
    push!(blueprints, bp)
end

function factorio(factory, blueprints)
    results = []
    bots = factory[1]
    res = factory[2]
        for i in 1:4
            bp = blueprints[5-i]
            if all(bp .<= res)
                resNew = deepcopy(res)
                resNew .-= bp
                botsNew = deepcopy(bots)
                botsNew[5-i] += 1
                resNew .+= bots
                push!(results, [botsNew, resNew])
            end
        end
    push!(results, [bots, res .+= bots])
    return(results)
end

maxGeodes = []
j = 0
for bp in blueprints
    j += 1
    println(j,"/",length(blueprints))
    factory = [[1,0,0,0],[0,0,0,0]] #robots; resources
    oldFactories = [factory]
    for i in 1:24
        println("---------")
        println("Round ",i,)
        newFactories = []
        for factory in oldFactories
            f = factorio(factory, bp)
            newFactories = vcat(newFactories, f)
        end
        unique!(newFactories)
        oldFactories = deepcopy(newFactories)
        maxGbots = maximum([oldFactories[k][1][4] for k in 1:length(oldFactories)])
        println("Max geodeBots: ", maxGbots)
        keep = [oldFactories[k][1][4] == maxGbots for k in 1:length(oldFactories)]
        oldFactories = oldFactories[keep]
        println("Factories: ", length(oldFactories))
    end

    maxGeo = maximum([oldFactories[i][2][4] for i in 1:length(oldFactories)])
    push!(maxGeodes, maxGeo)
end

println("Geodes: ", maxGeodes)
score = sum([i * maxGeodes[i] for i in 1:length(maxGeodes)])
println("Solution? of part I: ", score)


bp = [[3,0,0,0],[3,0,0,0],[3,16,0,0],[3,0,20,0]]
factory = [[1,0,0,0],[0,0,0,0]] #robots; resources
oldFactories = [factory]
for j in 1:24
    println("---------")
    println("Round ",j,)
    newFactories = []
    for factory in oldFactories
        f = factorio(factory, bp)
        newFactories = vcat(newFactories, f)
    end
    unique!(newFactories)
    oldFactories = deepcopy(newFactories)
    maxGbots = maximum([oldFactories[k][1][4] for k in 1:length(oldFactories)])
    println("Max geodeBots: ", maxGbots)
    keep = [oldFactories[k][1][4] == maxGbots for k in 1:length(oldFactories)]
    oldFactories = oldFactories[keep]
    println("Factories: ", length(oldFactories))
end
maxGeo = maximum([oldFactories[i][2][4] for i in 1:length(oldFactories)])

println("MAX GEODES: ", maxGeo)
