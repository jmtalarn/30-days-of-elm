module Components.Top exposing (header)

import Colors.Opaque
import Components.HomeIcon as HomeIcon
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Border.widthEach { bottom = 2, left = 1, right = 2, top = 1 }
    , Border.color <| rgba 0 0 0 0.4
    , padding 6
    , width <| px 40
    , height <| px 40
    , Font.center
    , Border.rounded 100
    , mouseOver [ Background.color <| rgba 1 1 1 0.2 ]
    , focused [ Border.color <| rgba 0 0 0 0, Background.color <| rgba 1 1 1 0.2 ]

    --, alignRight
    , Font.size 10
    ]


dayLinks : List (Element msg)
dayLinks =
    [ link buttonAttrs { url = "/", label = HomeIcon.icon }
    , link buttonAttrs { url = "./day1", label = paragraph [] [ text "Day 1" ] }
    , link buttonAttrs { url = "./day2", label = paragraph [] [ text "Day 2" ] }
    , link buttonAttrs { url = "./day3", label = paragraph [] [ text "Day 3" ] }
    , link buttonAttrs { url = "./day4", label = paragraph [] [ text "Day 4" ] }
    , link buttonAttrs { url = "./day5", label = paragraph [] [ text "Day 5" ] }
    , link buttonAttrs { url = "./day6", label = paragraph [] [ text "Day 6" ] }
    , link buttonAttrs { url = "./day7", label = paragraph [] [ text "Day 7" ] }
    , link buttonAttrs { url = "./day8", label = paragraph [] [ text "Day 8" ] }
    , link buttonAttrs { url = "./day9", label = paragraph [] [ text "Day 9" ] }
    , link buttonAttrs { url = "./day10", label = paragraph [] [ text "Day 10" ] }
    , link buttonAttrs { url = "./day11", label = paragraph [] [ text "Day 11" ] }
    , link buttonAttrs { url = "./day12", label = paragraph [] [ text "Day 12" ] }
    , link buttonAttrs { url = "./day13", label = paragraph [] [ text "Day 13" ] }
    , link buttonAttrs { url = "./day14", label = paragraph [] [ text "Day 14" ] }
    , link buttonAttrs { url = "./day15", label = paragraph [] [ text "Day 15" ] }
    , link buttonAttrs { url = "./day16", label = paragraph [] [ text "Day 16" ] }
    , link buttonAttrs { url = "./day17", label = paragraph [] [ text "Day 17" ] }
    , link buttonAttrs { url = "./day18", label = paragraph [] [ text "Day 18" ] }
    , link buttonAttrs { url = "./day19", label = paragraph [] [ text "Day 19" ] }
    , link buttonAttrs { url = "./day20", label = paragraph [] [ text "Day 20" ] }
    , link buttonAttrs { url = "./day21", label = paragraph [] [ text "Day 21" ] }
    , link buttonAttrs { url = "./day22", label = paragraph [] [ text "Day 22" ] }
    , link buttonAttrs { url = "./day23", label = paragraph [] [ text "Day 23" ] }
    , link buttonAttrs { url = "./day24", label = paragraph [] [ text "Day 24" ] }
    , link buttonAttrs { url = "./day25", label = paragraph [] [ text "Day 25" ] }
    , link buttonAttrs { url = "./day26", label = paragraph [] [ text "Day 26" ] }
    , link buttonAttrs { url = "./day27", label = paragraph [] [ text "Day 27" ] }
    , link buttonAttrs { url = "./day28", label = paragraph [] [ text "Day 28" ] }
    , link buttonAttrs { url = "./day29", label = paragraph [] [ text "Day 29" ] }
    , link buttonAttrs { url = "./day30", label = paragraph [] [ text "Day 30" ] }
    ]


linkAttrs : List (Attr decorative msg)
linkAttrs =
    [ Font.color <| rgb 1 1 1 ]


header : Element msg
header =
    column
        [ width fill
        , padding 20

        --, Background.color <| rgb255 38 104 69
        , Background.color <| Colors.Opaque.steelblue --<| rgb255 141 166 211
        ]
        [ wrappedRow
            [ Font.color <| rgba 0 0 0 0.9
            , width fill
            , spacing 20
            ]
            [ el [ width <| px 100, height <| px 100 ] <| image [ width fill ] { description = "Logo", src = "./icons/512.png" }
            , column [ width fill, spacing 10 ]
                [ el [ Font.size 32, width fill ] <| link [] { label = text "30 days of elm", url = "/" }
                , paragraph [ Font.size 16 ]
                    [ text "Built with "
                    , link linkAttrs { label = text "elm-land", url = "https://www.elm.land/" }
                    , text " and  based on "
                    , link linkAttrs { label = text "Kristian Pedersen challenge", url = "https://dev.to/kristianpedersen/30-days-of-elm-intro-2lo2" }
                    , text "."
                    ]
                ]
            ]
        , wrappedRow [ spacing 5, paddingXY 0 10, width fill ]
            dayLinks
        ]
