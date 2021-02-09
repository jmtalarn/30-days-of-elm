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


basepath : String
basepath =
    "30-days-of-elm"


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Top (Parser.s basepath) --Parser.top
        , Parser.map Day1 (Parser.s basepath </> Parser.s "day1")
        , Parser.map Day10 (Parser.s basepath </> Parser.s "day10")
        , Parser.map Day11 (Parser.s basepath </> Parser.s "day11")
        , Parser.map Day12 (Parser.s basepath </> Parser.s "day12")
        , Parser.map Day13 (Parser.s basepath </> Parser.s "day13")
        , Parser.map Day14 (Parser.s basepath </> Parser.s "day14")
        , Parser.map Day15 (Parser.s basepath </> Parser.s "day15")
        , Parser.map Day16 (Parser.s basepath </> Parser.s "day16")
        , Parser.map Day17 (Parser.s basepath </> Parser.s "day17")
        , Parser.map Day18 (Parser.s basepath </> Parser.s "day18")
        , Parser.map Day19 (Parser.s basepath </> Parser.s "day19")
        , Parser.map Day2 (Parser.s basepath </> Parser.s "day2")
        , Parser.map Day20 (Parser.s basepath </> Parser.s "day20")
        , Parser.map Day21 (Parser.s basepath </> Parser.s "day21")
        , Parser.map Day22 (Parser.s basepath </> Parser.s "day22")
        , Parser.map Day23 (Parser.s basepath </> Parser.s "day23")
        , Parser.map Day24 (Parser.s basepath </> Parser.s "day24")
        , Parser.map Day25 (Parser.s basepath </> Parser.s "day25")
        , Parser.map Day26 (Parser.s basepath </> Parser.s "day26")
        , Parser.map Day27 (Parser.s basepath </> Parser.s "day27")
        , Parser.map Day28 (Parser.s basepath </> Parser.s "day28")
        , Parser.map Day29 (Parser.s basepath </> Parser.s "day29")
        , Parser.map Day3 (Parser.s basepath </> Parser.s "day3")
        , Parser.map Day30 (Parser.s basepath </> Parser.s "day30")
        , Parser.map Day4 (Parser.s basepath </> Parser.s "day4")
        , Parser.map Day5 (Parser.s basepath </> Parser.s "day5")
        , Parser.map Day6 (Parser.s basepath </> Parser.s "day6")
        , Parser.map Day7 (Parser.s basepath </> Parser.s "day7")
        , Parser.map Day8 (Parser.s basepath </> Parser.s "day8")
        , Parser.map Day9 (Parser.s basepath </> Parser.s "day9")
        , Parser.map NotFound (Parser.s basepath </> Parser.s "not-found")
        , Parser.map PageA (Parser.s basepath </> Parser.s "page-a")
        , Parser.map PageB (Parser.s basepath </> Parser.s "page-b")
        ]


toString : Route -> String
toString route =
    let
        segments : List String
        segments =
            case route of
                Top ->
                    [ basepath ]

                Day1 ->
                    [ basepath, "day1" ]

                Day10 ->
                    [ basepath, "day10" ]

                Day11 ->
                    [ basepath, "day11" ]

                Day12 ->
                    [ basepath, "day12" ]

                Day13 ->
                    [ basepath, "day13" ]

                Day14 ->
                    [ basepath, "day14" ]

                Day15 ->
                    [ basepath, "day15" ]

                Day16 ->
                    [ basepath, "day16" ]

                Day17 ->
                    [ basepath, "day17" ]

                Day18 ->
                    [ basepath, "day18" ]

                Day19 ->
                    [ basepath, "day19" ]

                Day2 ->
                    [ basepath, "day2" ]

                Day20 ->
                    [ basepath, "day20" ]

                Day21 ->
                    [ basepath, "day21" ]

                Day22 ->
                    [ basepath, "day22" ]

                Day23 ->
                    [ basepath, "day23" ]

                Day24 ->
                    [ basepath, "day24" ]

                Day25 ->
                    [ basepath, "day25" ]

                Day26 ->
                    [ basepath, "day26" ]

                Day27 ->
                    [ basepath, "day27" ]

                Day28 ->
                    [ basepath, "day28" ]

                Day29 ->
                    [ basepath, "day29" ]

                Day3 ->
                    [ basepath, "day3" ]

                Day30 ->
                    [ basepath, "day30" ]

                Day4 ->
                    [ basepath, "day4" ]

                Day5 ->
                    [ basepath, "day5" ]

                Day6 ->
                    [ basepath, "day6" ]

                Day7 ->
                    [ basepath, "day7" ]

                Day8 ->
                    [ basepath, "day8" ]

                Day9 ->
                    [ basepath, "day9" ]

                NotFound ->
                    [ basepath, "not-found" ]

                PageA ->
                    [ basepath, "page-a" ]

                PageB ->
                    [ basepath, "page-b" ]
    in
    segments
        |> String.join "/"
        |> String.append "/"
