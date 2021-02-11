module Pages.Day11 exposing (..)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, h3)
import Html.Attributes as HtmlAttributes exposing (type_)
import Html.Events exposing (onInput)
import List exposing (filter, foldl)
import ParseInt exposing (parseInt)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import String exposing (fromInt, split)


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , save = save
        , load = load
        }


type alias Params =
    ()


type alias Model =
    { number : Int, numberBinay : Int, nextNumber : Int, nextNumberBinary : Int }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( Model 0 0 0 0, Cmd.none )


type Msg
    = Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Set value ->
            let
                number =
                    Result.withDefault 0 <| parseInt value

                binaryNumber =
                    number2binary <| number

                nextNumber =
                    nextNumberWithSameAmountOfOnes number (number + 1)

                binaryNextNumber =
                    number2binary <| nextNumber
            in
            ( Model number binaryNumber nextNumber binaryNextNumber, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


number2binary : Int -> Int
number2binary number =
    if number == 0 then
        number

    else
        modBy 2 number + 10 * number2binary (number // 2)


countOnes : Int -> Int
countOnes number =
    foldl (+) 0 <| filter (\a -> a == 1) <| List.map (Result.withDefault 0) <| List.map parseInt <| (fromInt number |> split "")


nextNumberWithSameAmountOfOnes : Int -> Int -> Int
nextNumberWithSameAmountOfOnes number nextNumber =
    let
        numberOnes =
            countOnes <| number2binary number

        nextNumberOnes =
            countOnes <| number2binary nextNumber
    in
    if numberOnes == nextNumberOnes then
        nextNumber

    else
        nextNumberWithSameAmountOfOnes number (nextNumber + 1)


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Document Msg
view model =
    { title = "Day 11"
    , body =
        [ column
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
        ]
    }
