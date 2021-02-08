module Spa.Generated.Route exposing
    ( Route(..)
    , fromUrl
    , toString
    )

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type Route
    = Top
    | Day1
    | Day10
    | Day11
    | Day12
    | Day13
    | Day14
    | Day15
    | Day16
    | Day17
    | Day18
    | Day19
    | Day2
    | Day20
    | Day21
    | Day22
    | Day23
    | Day24
    | Day25
    | Day26
    | Day27
    | Day28
    | Day29
    | Day3
    | Day30
    | Day4
    | Day5
    | Day6
    | Day7
    | Day8
    | Day9
    | NotFound
    | PageA
    | PageB


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse routes


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Day1 (Parser.s "day1")
        , Parser.map Day10 (Parser.s "day10")
        , Parser.map Day11 (Parser.s "day11")
        , Parser.map Day12 (Parser.s "day12")
        , Parser.map Day13 (Parser.s "day13")
        , Parser.map Day14 (Parser.s "day14")
        , Parser.map Day15 (Parser.s "day15")
        , Parser.map Day16 (Parser.s "day16")
        , Parser.map Day17 (Parser.s "day17")
        , Parser.map Day18 (Parser.s "day18")
        , Parser.map Day19 (Parser.s "day19")
        , Parser.map Day2 (Parser.s "day2")
        , Parser.map Day20 (Parser.s "day20")
        , Parser.map Day21 (Parser.s "day21")
        , Parser.map Day22 (Parser.s "day22")
        , Parser.map Day23 (Parser.s "day23")
        , Parser.map Day24 (Parser.s "day24")
        , Parser.map Day25 (Parser.s "day25")
        , Parser.map Day26 (Parser.s "day26")
        , Parser.map Day27 (Parser.s "day27")
        , Parser.map Day28 (Parser.s "day28")
        , Parser.map Day29 (Parser.s "day29")
        , Parser.map Day3 (Parser.s "day3")
        , Parser.map Day30 (Parser.s "day30")
        , Parser.map Day4 (Parser.s "day4")
        , Parser.map Day5 (Parser.s "day5")
        , Parser.map Day6 (Parser.s "day6")
        , Parser.map Day7 (Parser.s "day7")
        , Parser.map Day8 (Parser.s "day8")
        , Parser.map Day9 (Parser.s "day9")
        , Parser.map NotFound (Parser.s "not-found")
        , Parser.map PageA (Parser.s "page-a")
        , Parser.map PageB (Parser.s "page-b")
        ]


toString : Route -> String
toString route =
    let
        segments : List String
        segments =
            case route of
                Top ->
                    []
                
                Day1 ->
                    [ "day1" ]
                
                Day10 ->
                    [ "day10" ]
                
                Day11 ->
                    [ "day11" ]
                
                Day12 ->
                    [ "day12" ]
                
                Day13 ->
                    [ "day13" ]
                
                Day14 ->
                    [ "day14" ]
                
                Day15 ->
                    [ "day15" ]
                
                Day16 ->
                    [ "day16" ]
                
                Day17 ->
                    [ "day17" ]
                
                Day18 ->
                    [ "day18" ]
                
                Day19 ->
                    [ "day19" ]
                
                Day2 ->
                    [ "day2" ]
                
                Day20 ->
                    [ "day20" ]
                
                Day21 ->
                    [ "day21" ]
                
                Day22 ->
                    [ "day22" ]
                
                Day23 ->
                    [ "day23" ]
                
                Day24 ->
                    [ "day24" ]
                
                Day25 ->
                    [ "day25" ]
                
                Day26 ->
                    [ "day26" ]
                
                Day27 ->
                    [ "day27" ]
                
                Day28 ->
                    [ "day28" ]
                
                Day29 ->
                    [ "day29" ]
                
                Day3 ->
                    [ "day3" ]
                
                Day30 ->
                    [ "day30" ]
                
                Day4 ->
                    [ "day4" ]
                
                Day5 ->
                    [ "day5" ]
                
                Day6 ->
                    [ "day6" ]
                
                Day7 ->
                    [ "day7" ]
                
                Day8 ->
                    [ "day8" ]
                
                Day9 ->
                    [ "day9" ]
                
                NotFound ->
                    [ "not-found" ]
                
                PageA ->
                    [ "page-a" ]
                
                PageB ->
                    [ "page-b" ]
    in
    segments
        |> String.join "/"
        |> String.append "/"