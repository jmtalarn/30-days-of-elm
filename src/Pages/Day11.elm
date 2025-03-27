module Pages.Day11 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, h3)
import Html.Attributes as HtmlAttributes exposing (min, type_)
import Html.Events exposing (onInput)
import List exposing (filter, foldl)
import Page exposing (Page)
import ParseInt exposing (parseInt)
import Route exposing (Route)
import Shared
import String exposing (fromInt, split)
import UI
import View exposing (View)


page : Page Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { number : Int, numberBinay : Int, nextNumber : Int, nextNumberBinary : Int }


init : ( Model, Cmd Msg )
init =
    ( Model 0 0 0 0, Cmd.none )


type Msg
    = Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Set value ->
            let
                number =
                    let
                        parsedInt =
                            Result.withDefault 0 <| parseInt value
                    in
                    if parsedInt >= 0 then
                        parsedInt

                    else
                        0

                binaryNumber =
                    number2binary <| number

                nextNumber =
                    nextNumberWithSameAmountOfOnes number (number + 1)

                binaryNextNumber =
                    number2binary <| nextNumber
            in
            ( Model number binaryNumber nextNumber binaryNextNumber, Cmd.none )


number2binary : Int -> Int
number2binary number =
    let
        _ =
            Debug.log "number2binary" number
    in
    if number == 0 then
        number

    else
        modBy 2 number + 10 * number2binary (number // 2)


countOnes : Int -> Int
countOnes number =
    if number == 0 then
        0

    else
        foldl (+) 0 <| filter (\a -> a == 1) <| List.map (Result.withDefault 0) <| List.map parseInt <| (fromInt number |> split "")


nextNumberWithSameAmountOfOnes : Int -> Int -> Int
nextNumberWithSameAmountOfOnes number nextNumber =
    let
        numberOnes =
            countOnes <| number2binary number

        nextNumberOnes =
            countOnes <| number2binary nextNumber
    in
    if number == 0 then
        0

    else if numberOnes == nextNumberOnes then
        nextNumber

    else
        nextNumberWithSameAmountOfOnes number (nextNumber + 1)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> View Msg
view model =
    { title = "Day 11"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 11" ] ]
                    , row [] [ html <| h3 [] [ Html.text "Next number with same amount of ones in binary representation" ] ]
                    , row [ spacing 20 ]
                        [ column
                            [ spacing 10, centerY ]
                            [ Input.text
                                [ htmlAttribute <| type_ "number"
                                , htmlAttribute <| HtmlAttributes.min "0"
                                , Font.extraLight
                                ]
                                { onChange = Set
                                , text = String.fromInt model.number
                                , placeholder = Just (Input.placeholder [] (Element.text "Write a number here"))
                                , label =
                                    Input.labelAbove []
                                        (Element.text "Write a number here")
                                }
                            ]
                        , column [ spacing 15 ]
                            [ Element.text "Your number in binary representation"
                            , el [ Font.extraLight ]
                                (Element.text <| String.fromInt model.numberBinay)
                            , Element.text
                                "Next number with same amount of ones"
                            , el [ Font.extraLight ] (Element.text <| String.fromInt model.nextNumber)
                            , Element.text "Number above in binary representation"
                            , el [ Font.extraLight ] (Element.text <| String.fromInt model.nextNumberBinary)
                            ]
                        ]
                    ]
    }
