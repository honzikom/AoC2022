cd("C:/Users/janbo/Documents/AoC2022")

# read input
rucksacks = readlines("./input03.csv")

# create alphabet
alphabet = collect('a':'z')
ALPHABET = collect('A':'Z')
alphabet = vcat(alphabet,  ALPHABET)
alphabet = string.(alphabet)

# find common letter
commons = []
for sack in rucksacks
    sack = split(sack,"")
    leftComp = first(sack, length(sack) ÷ 2)
    rightComp = last(sack, length(sack) ÷ 2)
    push!(commons, leftComp[reduce(hcat,findfirst(in(rightComp), leftComp))])
end

# sum alphabet-indices of common letters
sumPriorities = 0
for commonLetter in commons
    sumPriorities += findfirst(commonLetter .== alphabet)
end

println("solution of part I: ", sumPriorities)

# take triplet A,B,C, find intersect AB and than intersect ABC
badges = []
for i in 0 : (length(rucksacks) ÷ 3) - 1
    A = split(rucksacks[3*i + 1], "")
    B = split(rucksacks[3*i + 2], "")
    C = split(rucksacks[3*i + 3], "")
    AB = A[reduce(vcat,findall(in(B), A))]
    ABC = AB[reduce(vcat,findfirst(in(C), AB))]
    push!(badges, ABC)
end

# same sum as above
sumBadges = 0
for badge in badges
    sumBadges += findfirst(badge .== alphabet)
end

println("solution of part II: ", sumBadges)
