module Pages.Day12 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Binary exposing (Bits, add, empty)
import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, h3)
import Html.Attributes as HtmlAttributes exposing (type_)
import Html.Events exposing (onInput)
import List exposing (filter, foldl)
import Page
import ParseInt exposing (parseInt)
import Request exposing (Request)
import Shared
import String exposing (fromInt, split)
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { number : String, numberBinary : Bits, nextNumber : String, nextNumberBinary : Bits }


init : ( Model, Cmd Msg )
init =
    ( Model "0" Binary.empty "0" Binary.empty, Cmd.none )


type Msg
    = Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Set value ->
            let
                number =
                    value

                binaryNumber =
                    Binary.fromDecimal <| Result.withDefault 0 <| parseInt value

                binaryNextNumber =
                    nextNumberWithSameAmountOfOnes binaryNumber (add (Binary.fromIntegers [ 1 ]) binaryNumber)

                nextNumber =
                    String.fromInt <| Binary.toDecimal binaryNextNumber
            in
            ( Model number binaryNumber nextNumber binaryNextNumber, Cmd.none )


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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


printBits : Bits -> String
printBits number =
    if number == empty then
        "凸"

    else
        String.concat <| List.map String.fromInt (Binary.toIntegers number)


view : Model -> View Msg
view model =
    { title = "Day 12"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 12" ] ]
                    , row [] [ html <| h3 [] [ Html.text "Next number with same amount of ones in binary representation" ] ]
                    , row [ Font.color Colors.Opaque.crimson, rotate -0.3, scale 1.2, Font.extraBold, moveUp 180, moveRight 200 ] [ Element.text "elm-binary edition" ]
                    , row [ spacing 20 ]
                        [ column
                            [ spacing 10, centerY ]
                            [ Input.text
                                [ htmlAttribute <| type_ "number"
                                , Font.extraLight
                                ]
                                { onChange = Set
                                , text = model.number
                                , placeholder = Just (Input.placeholder [] (Element.text "Write a number here"))
                                , label =
                                    Input.labelAbove []
                                        (Element.text "Write a number here")
                                }
                            ]
                        , column [ spacing 15 ]
                            [ Element.text "Your number in binary representation"
                            , el [ Font.extraLight ]
                                (Element.text <| printBits model.numberBinary)
                            , Element.text
                                "Next number with same amount of ones"
                            , el [ Font.extraLight ] (Element.text <| model.nextNumber)
                            , Element.text "Number above in binary representation"
                            , el [ Font.extraLight ] (Element.text <| printBits model.nextNumberBinary)
                            ]
                        ]
                    ]
    }
