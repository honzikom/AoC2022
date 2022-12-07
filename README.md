### Advent of Code 2022

## Day01
First steps in the jungle with elves weren't too hard. There was sum mud at the end of the calory list prvided by elves (excess "\n"), but after removing it the solution was straightforawrd, nice and compact.

## Day02
My first thought was to find my play first and then calculate score, but I relaized it is needless, all information I know to calculate score is given. The second part needed more drawing on paper but it was fun. Only problem was that in czech we have different order "rock-scissors-paper" instead of "rock-paper-scissors", which lead to mistakes...

## Day03
Today me and my friend were solving AoC at frinds cottage, where a boardgame weekend was held. The puzzle was quite simple, but I managed to beat my professional programmer, so gimme my programming Master!

## Day04
Yesterady Atom (IDE I used for Julia) broke for me and I wasn't able to repair it. Therefore I switched to Visual Studio Code and need to learn it's features. Fira Mono Code ligatures are working, so everything is fine :) The puzzle intself was really easy, hower the constant need od reducing objects in Julia feels unhandy.

## Day05
The biggest issue was loading data. After some thoughtful thinking I decided to split input into "crates" and "moves" (input part1 and input part2). Moves are straightforward, easy splitting. I decided to setup crates as character matrix and pull columns with letters into vector of vectors. Suprisingly I had mistake in my code that solved Star II before Start I (missing reverse). 
It was fun!

# Day06
I hoped for something more difficult since i had 2 hours of *free* time during meeting. I was afraid of part II what comes, but my code didn't need any changes except for some constants.

#Day07
This puzzle really seemed worse then it actually was. The problem was to come up with good structure for the problem - I decided to create /the/path/to/every/file.smh. This way, i had list of every directory, list of every file and all I had to do was for each directory find what file paths have this directory as substring. The part II was really easy with this structure, but I think for other approaches (like nested dirs) it could be difficult. 
