module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , urls
    , view
    )

import Browser.Navigation exposing (Key)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route
import Url exposing (Url)



-- INIT


type alias Flags =
    ()


type alias Model =
    { url : Url
    , key : Key
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model url key
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


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


linkAttrs : List (Attr decorative msg)
linkAttrs =
    [ Font.color <| rgb 1 1 1 ]


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> Document msg
view { page, toMsg } model =
    { title = page.title
    , body =
        [ column
            [ spacing 30
            , width fill

            --, Background.color <| rgb255 116 222 165
            , Background.color <| rgba255 255 255 255 0.9
            ]
            [ column
                [ padding 20
                , width fill

                --, Background.color <| rgb255 38 104 69
                , Background.color <| rgb255 141 166 211
                ]
                [ wrappedRow
                    [ Font.color <| rgba 0 0 0 0.9
                    , width fill
                    , spacing 20
                    ]
                    [ el [ width <| px 100, height <| px 100 ] <| image [ width fill ] { description = "Logo", src = "/icons/512.png" }
                    , column [ width fill, spacing 10 ]
                        [ el [ Font.size 32, width fill ] <| text "elm-spa-example"
                        , paragraph [ Font.size 16 ]
                            [ text "Built with "
                            , link linkAttrs { label = text "elm-spa", url = "https://www.elm-spa.dev/" }
                            , text " and "
                            , link linkAttrs { label = text "elm-starter", url = "https://github.com/lucamug/elm-starter" }
                            , text "."
                            ]
                        ]
                    ]
                , wrappedRow [ spacing 5, paddingXY 0 10, width fill ]
                    navlinks
                ]
            , column
                [ height fill
                , width fill
                , spacing 15
                , paddingEach { top = 0, right = 30, bottom = 300, left = 30 }
                ]
                page.body
            ]
        ]
    }


navlinks : List (Element msg)
navlinks =
    [ link buttonAttrs { url = Route.toString Route.Top, label = paragraph [] [ text "Top" ] }
    , link buttonAttrs { url = Route.toString Route.PageA, label = paragraph [] [ text "Page A" ] }
    , link buttonAttrs { url = Route.toString Route.PageB, label = paragraph [] [ text "Page B" ] }
    ]
        ++ dayLinks


dayLinks : List (Element msg)
dayLinks =
    [ link buttonAttrs { url = Route.toString Route.Day1, label = paragraph [] [ text "Day 1" ] }
    , link buttonAttrs { url = Route.toString Route.Day2, label = paragraph [] [ text "Day 2" ] }
    , link buttonAttrs { url = Route.toString Route.Day3, label = paragraph [] [ text "Day 3" ] }
    , link buttonAttrs { url = Route.toString Route.Day4, label = paragraph [] [ text "Day 4" ] }
    , link buttonAttrs { url = Route.toString Route.Day5, label = paragraph [] [ text "Day 5" ] }
    , link buttonAttrs { url = Route.toString Route.Day6, label = paragraph [] [ text "Day 6" ] }
    , link buttonAttrs { url = Route.toString Route.Day7, label = paragraph [] [ text "Day 7" ] }
    , link buttonAttrs { url = Route.toString Route.Day8, label = paragraph [] [ text "Day 8" ] }
    , link buttonAttrs { url = Route.toString Route.Day9, label = paragraph [] [ text "Day 9" ] }
    , link buttonAttrs { url = Route.toString Route.Day10, label = paragraph [] [ text "Day 10" ] }
    , link buttonAttrs { url = Route.toString Route.Day11, label = paragraph [] [ text "Day 11" ] }
    , link buttonAttrs { url = Route.toString Route.Day12, label = paragraph [] [ text "Day 12" ] }
    , link buttonAttrs { url = Route.toString Route.Day13, label = paragraph [] [ text "Day 13" ] }
    , link buttonAttrs { url = Route.toString Route.Day14, label = paragraph [] [ text "Day 14" ] }
    , link buttonAttrs { url = Route.toString Route.Day15, label = paragraph [] [ text "Day 15" ] }
    , link buttonAttrs { url = Route.toString Route.Day16, label = paragraph [] [ text "Day 16" ] }
    , link buttonAttrs { url = Route.toString Route.Day17, label = paragraph [] [ text "Day 17" ] }
    , link buttonAttrs { url = Route.toString Route.Day18, label = paragraph [] [ text "Day 18" ] }
    , link buttonAttrs { url = Route.toString Route.Day19, label = paragraph [] [ text "Day 19" ] }
    , link buttonAttrs { url = Route.toString Route.Day20, label = paragraph [] [ text "Day 20" ] }
    , link buttonAttrs { url = Route.toString Route.Day21, label = paragraph [] [ text "Day 21" ] }
    , link buttonAttrs { url = Route.toString Route.Day22, label = paragraph [] [ text "Day 22" ] }
    , link buttonAttrs { url = Route.toString Route.Day23, label = paragraph [] [ text "Day 23" ] }
    , link buttonAttrs { url = Route.toString Route.Day24, label = paragraph [] [ text "Day 24" ] }
    , link buttonAttrs { url = Route.toString Route.Day25, label = paragraph [] [ text "Day 25" ] }
    , link buttonAttrs { url = Route.toString Route.Day26, label = paragraph [] [ text "Day 26" ] }
    , link buttonAttrs { url = Route.toString Route.Day27, label = paragraph [] [ text "Day 27" ] }
    , link buttonAttrs { url = Route.toString Route.Day28, label = paragraph [] [ text "Day 28" ] }
    , link buttonAttrs { url = Route.toString Route.Day29, label = paragraph [] [ text "Day 29" ] }
    , link buttonAttrs { url = Route.toString Route.Day30, label = paragraph [] [ text "Day 30" ] }
    ]


urls : List String
urls =
    [ "/", "/day1", "/day2", "/day3", "/day4", "/day5", "/day6", "/day7", "/day8", "/day9", "/day10", "/day11", "/day12", "/day13", "/day14", "/day15", "/day16", "/day17", "/day18", "/day19", "/day20", "/day21", "/day22", "/day23", "/day24", "/day25", "/day26", "/day27", "/day28", "/day29", "/day30" ]
