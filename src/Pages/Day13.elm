module Pages.Day13 exposing (Model, Msg, page)

-- import Pages.Day12 exposing (nextNumberWithSameAmountOfOnes)

import Binary exposing (Bits, add, empty)
import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Events exposing (onInput)
import LineChart exposing (..)
import LineChart.Area as Area
import LineChart.Axis as Axis
import LineChart.Axis.Intersection as Intersection
import LineChart.Colors as LCColors
import LineChart.Container as Container
import LineChart.Dots as Dots
import LineChart.Events as Events
import LineChart.Grid as Grid
import LineChart.Interpolation as Interpolation
import LineChart.Junk as Junk
import LineChart.Legends as Legends
import LineChart.Line as Line
import List exposing (filter, foldl, indexedMap)
import Page
import Route exposing (Route)
import Shared
import Svg exposing (Svg)
import Tuple exposing (first, second)
import UI
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    ( List ( Float, Float ), List ( Float, Float ) )


nextNumberWithSameAmountOfOnes : Bits -> Bits -> Bits
nextNumberWithSameAmountOfOnes number nextNumber =
    let
        numberOnes =
            foldl (+) 0 <| Binary.toIntegers number

        nextNumberOnes =
            foldl (+) 0 <| Binary.toIntegers nextNumber
    in
    if numberOnes == nextNumberOnes then
        nextNumber

    else
        nextNumberWithSameAmountOfOnes number (Binary.add (Binary.fromIntegers [ 1 ]) nextNumber)


getNextNumber : Int -> Int
getNextNumber number =
    Binary.toDecimal <| nextNumberWithSameAmountOfOnes (Binary.fromDecimal number) (Binary.fromDecimal (number + 1))


init : ( Model, Cmd Msg )
init =
    let
        range =
            List.range 1 100

        nextRange =
            List.map getNextNumber range

        floatsRange =
            List.map toFloat range

        floatsNextRange =
            List.map toFloat nextRange
    in
    ( ( List.map (\( a, b ) -> ( toFloat a, b )) <| indexedMap Tuple.pair floatsRange
      , List.map (\( a, b ) -> ( toFloat a, b )) <| indexedMap Tuple.pair floatsNextRange
      )
    , Cmd.none
    )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> View Msg
view model =
    { title = "Day 13"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 13 - Visualize pair of values of Day 12" ] ]

                    -- , row [] [ Element.paragraph [] (List.map (\( a, b ) -> Element.text <| "[" ++ String.fromFloat a ++ "," ++ String.fromFloat b ++ "]") model) ]
                    , row [ Font.size 15, width fill ] [ html <| chart model ]
                    ]
    }


chart : Model -> Svg msg
chart model =
    viewCustom
        { x = Axis.full 1200 "Number" first
        , y = Axis.full 600 "Close" second
        , container = Container.default "line-chart-1"
        , interpolation = Interpolation.default
        , intersection = Intersection.default
        , legends = Legends.default
        , events = Events.default
        , junk = Junk.default
        , grid = Grid.dots 1 LCColors.gray
        , area = Area.default
        , line = Line.default
        , dots = Dots.default
        }
        [ LineChart.line LCColors.purple Dots.circle "Number" (first model)
        , LineChart.line LCColors.blueLight Dots.diamond "Close" (second model)
        ]
