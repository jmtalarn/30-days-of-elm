module Pages.Day22 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, h2)
import Html.Events exposing (onInput)
import List exposing (foldl, indexedMap, map)
import Page
import Parser exposing (float, run)
import Request exposing (Request)
import Shared
import String exposing (split, toInt)
import Tuple exposing (first, second)
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


type alias Kata5 =
    ( String, String )


type alias Kata6 =
    ( String, String )


type alias Kata7 =
    { num : Int, sumin : Int, sumax : Int, sumsum : Int }


type alias Kata8 =
    { upspeed : Int, downspeed : Int, desiredheight : Int, days : Int }


type alias Kata9 =
    { hydrogen : Int, carbon : Int, oxygen : Int, water : Int, co2 : Int, methane : Int }


type alias Kata10 =
    ( Int, Int )


type alias Model =
    { kata5 : Kata5, kata6 : Kata6, kata7 : Kata7, kata8 : Kata8, kata9 : Kata9, kata10 : Kata10 }


init : ( Model, Cmd Msg )
init =
    ( Model ( "", " " ) ( "", " " ) (Kata7 0 0 0 0) (Kata8 0 0 0 0) (Kata9 0 0 0 0 0 0) ( 0, 0 ), Cmd.none )


type Msg
    = Kata5SetString String
    | Kata6SetString String
    | Kata7Set String
    | Kata8SetUpSpeed String
    | Kata8SetDownSpeed String
    | Kata8SetDesiredHeight String
    | Kata9SetOxygen String
    | Kata9SetHydrogen String
    | Kata9SetCarbon String
    | Kata10Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { kata5, kata6, kata7, kata8, kata9 } =
            model
    in
    case msg of
        Kata5SetString string ->
            ( { model | kata5 = ( string, "" ) |> solveKata5 }, Cmd.none )

        Kata6SetString string ->
            ( { model | kata6 = ( String.split "" string |> List.filter (\a -> a == "." || a == " " || a == "-") |> String.join "", "" ) |> solveKata6 }, Cmd.none )

        Kata7Set num ->
            ( { model | kata7 = { kata7 | num = Maybe.withDefault 0 (toInt num) } |> solveKata7 }, Cmd.none )

        Kata8SetUpSpeed num ->
            ( { model | kata8 = { kata8 | upspeed = Maybe.withDefault 0 (toInt num) } |> solveKata8 }, Cmd.none )

        Kata8SetDownSpeed num ->
            ( { model | kata8 = { kata8 | downspeed = Maybe.withDefault 0 (toInt num) } |> solveKata8 }, Cmd.none )

        Kata8SetDesiredHeight num ->
            ( { model | kata8 = { kata8 | desiredheight = Maybe.withDefault 0 (toInt num) } |> solveKata8 }, Cmd.none )

        Kata9SetOxygen num ->
            ( { model | kata9 = { kata9 | oxygen = Maybe.withDefault 0 (toInt num) } |> solveKata9 }, Cmd.none )

        Kata9SetHydrogen num ->
            ( { model | kata9 = { kata9 | hydrogen = Maybe.withDefault 0 (toInt num) } |> solveKata9 }, Cmd.none )

        Kata9SetCarbon num ->
            ( { model | kata9 = { kata9 | carbon = Maybe.withDefault 0 (toInt num) } |> solveKata9 }, Cmd.none )

        Kata10Set num ->
            ( { model | kata10 = ( Maybe.withDefault 0 (toInt num), 0 ) |> solveKata10 }, Cmd.none )


solveKata10 : Kata10 -> Kata10
solveKata10 ( number, _ ) =
    ( number, digitalRoot number )


digitalRoot : Int -> Int
digitalRoot number =
    if number >= 10 then
        digitalRoot (String.fromInt number |> String.split "" |> List.map (\a -> Maybe.withDefault 0 (toInt a)) |> foldl (+) 0)

    else
        number


solveKata9 : Kata9 -> Kata9
solveKata9 { oxygen, hydrogen, carbon } =
    let
        { water, co2, methane } =
            { oxygen = oxygen, hydrogen = hydrogen, carbon = carbon, co2 = 0, water = 0, methane = 0 } |> h2oreaction |> co2reaction |> ch4reaction
    in
    { oxygen = oxygen, hydrogen = hydrogen, carbon = carbon, co2 = co2, water = water, methane = methane }


h2oreaction { oxygen, hydrogen, carbon, co2, water, methane } =
    if ((oxygen - 1) >= 0) && ((hydrogen - 2) >= 0) then
        h2oreaction { oxygen = oxygen - 1, hydrogen = hydrogen - 2, carbon = carbon, co2 = co2, water = water + 1, methane = methane }

    else
        { oxygen = oxygen, hydrogen = hydrogen, carbon = carbon, co2 = co2, water = water, methane = methane }


co2reaction { oxygen, hydrogen, carbon, co2, water, methane } =
    if ((carbon - 1) >= 0) && ((oxygen - 2) >= 0) then
        co2reaction { oxygen = oxygen - 2, hydrogen = hydrogen, carbon = carbon - 1, co2 = co2 + 1, water = water, methane = methane }

    else
        { oxygen = oxygen, hydrogen = hydrogen, carbon = carbon, co2 = co2, water = water, methane = methane }


ch4reaction { oxygen, hydrogen, carbon, co2, water, methane } =
    if ((carbon - 1) >= 0) && ((hydrogen - 4) >= 0) then
        ch4reaction { oxygen = oxygen, hydrogen = hydrogen - 4, carbon = carbon - 1, co2 = co2, water = water, methane = methane + 1 }

    else
        { oxygen = oxygen, hydrogen = hydrogen, carbon = carbon, co2 = co2, water = water, methane = methane }


solveKata8 : Kata8 -> Kata8
solveKata8 { upspeed, downspeed, desiredheight, days } =
    Kata8 upspeed downspeed desiredheight (growingPlant upspeed downspeed desiredheight upspeed 1)


growingPlant : Int -> Int -> Int -> Int -> Int -> Int
growingPlant upspeed downspeed desiredheight currentheight days =
    if desiredheight == 0 then
        0

    else if currentheight < desiredheight then
        growingPlant upspeed downspeed desiredheight (currentheight - downspeed + upspeed) (days + 1)

    else
        days


solveKata7 : Kata7 -> Kata7
solveKata7 { num, sumin, sumax, sumsum } =
    let
        xs =
            List.range 1 num

        ys =
            List.range 1 num

        mins =
            cartesian
                (\a b ->
                    if a < b then
                        a

                    else
                        b
                )
                xs
                ys

        maxs =
            cartesian
                (\a b ->
                    if a > b then
                        a

                    else
                        b
                )
                xs
                ys

        sums =
            cartesian
                (+)
                xs
                ys
    in
    Kata7 num (foldl (+) 0 mins) (foldl (+) 0 maxs) (foldl (+) 0 sums)


cartesian : (a -> b -> c) -> List a -> List b -> List c
cartesian func xs ys =
    List.concatMap
        (\x -> List.map (\y -> func x y) ys)
        xs


solveKata6 : Kata6 -> Kata6
solveKata6 ( code, decoded ) =
    let
        letters =
            String.split " " <|
                String.join " / " <|
                    String.split "   "
                        (String.trim code)
    in
    ( code, List.map morseCodes.get letters |> String.join "" )


solveKata5 : Kata5 -> Kata5
solveKata5 ( string, encoded ) =
    let
        stringList =
            String.split "" (String.toLower string)

        list =
            List.map
                (\( a, b ) ->
                    ( a
                    , List.foldl
                        (\c d ->
                            if c == a then
                                d + 1

                            else
                                d
                        )
                        b
                        stringList
                    )
                )
            <|
                List.map (\a -> Tuple.pair a 0) stringList

        dict =
            Dict.fromList list
    in
    ( string
    , List.map
        (\a ->
            if Maybe.withDefault 0 (Dict.get a dict) > 1 then
                ")"

            else
                "("
        )
        stringList
        |> String.join ""
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


parseFloat : String -> Maybe Float
parseFloat string =
    string
        |> Parser.run Parser.float
        |> Result.toMaybe


viewKata5 : Kata5 -> List (Element Msg)
viewKata5 kata5 =
    [ html <| h2 [] [ Html.text "Duplicate Encoder" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """ "(" if that character appears only once in the original string, or ")" if that character appears more than once in the original string (ignore capitalization)""" ]
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata5SetString
        , text = first kata5
        , placeholder = Just (Input.placeholder [] (Element.text "Write the string to encode here"))
        , label =
            Input.labelAbove []
                (Element.text "String to encode")
        }
    , Element.el [ Font.extraBold ] <|
        Element.text
            "Encoded string"
    , Element.el [ Font.extraLight ] <|
        Element.text
            (second
                kata5
            )
    ]


viewKata6 : Kata6 -> List (Element Msg)
viewKata6 kata6 =
    [ html <| h2 [] [ Html.text "Decode Morse Code" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """Decode morse code """ ]
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata6SetString
        , text = first kata6
        , placeholder = Just (Input.placeholder [] (Element.text "Write the Morse code here to decode"))
        , label =
            Input.labelAbove []
                (Element.text "Code to decode")
        }
    , Element.el [ Font.extraBold ] <|
        Element.text
            "Decoded message"
    , Element.el [ Font.extraLight ] <|
        Element.text
            (second
                kata6
            )
    ]


viewKata7 : Kata7 -> List (Element Msg)
viewKata7 kata7 =
    [ html <| h2 [] [ Html.text "Functions of Integers on Cartesian Plane" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """Consider integer coordinates x, y in the Cartesian plan and three functions f, g, h defined by:


f: 1 <= x <= n, 1 <= y <= n --> f(x, y) = min(x, y)
g: 1 <= x <= n, 1 <= y <= n --> g(x, y) = max(x, y)
h: 1 <= x <= n, 1 <= y <= n --> h(x, y) = x + y
where n is a given integer (n >= 1, guaranteed) and x, y are integers.

The task is to calculate the sum of f(x, y), g(x, y) and h(x, y) for all integers x and y such that (1 <= x <= n, 1 <= y <= n).

The function sumin (sum of f) will take n as a parameter and return the sum of min(x, y) in the domain 1 <= x <= n, 1 <= y <= n. The function sumax (sum of g) will take n as a parameter and return the sum of max(x, y) in the same domain. The function sumsum (sum of h) will take n as a parameter and return the sum of x + y in the same domain.
""" ]
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata7Set
        , text = String.fromInt kata7.num
        , placeholder = Just (Input.placeholder [] (Element.text "Write the number here"))
        , label =
            Input.labelAbove []
                (Element.text "Write the number here")
        }
    , row []
        [ Element.el [ Font.extraBold ] <|
            Element.text
                "sumin = "
        , Element.el [ Font.extraLight ] <|
            Element.text
                (String.fromInt
                    kata7.sumin
                )
        ]
    , row []
        [ Element.el [ Font.extraBold ] <|
            Element.text
                "sumax = "
        , Element.el [ Font.extraLight ] <|
            Element.text
                (String.fromInt
                    kata7.sumax
                )
        ]
    , row []
        [ Element.el [ Font.extraBold ] <|
            Element.text
                "sumsum = "
        , Element.el [ Font.extraLight ] <|
            Element.text
                (String.fromInt
                    kata7.sumsum
                )
        ]
    ]


viewKata8 : Kata8 -> List (Element Msg)
viewKata8 kata8 =
    [ html <| h2 [] [ Html.text "Growing Plant" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """Each day a plant is growing by upSpeed meters. Each night that plant's height decreases by downSpeed meters due to the lack of sun heat. Initially, plant is 0 meters tall. We plant the seed at the beginning of a day. We want to know when the height of the plant will reach a certain level.""" ]
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata8SetUpSpeed
        , text = String.fromInt kata8.upspeed
        , placeholder = Just (Input.placeholder [] (Element.text "Set the growing upspeed here"))
        , label =
            Input.labelAbove []
                (Element.text "Upspeed")
        }
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata8SetDownSpeed
        , text = String.fromInt kata8.downspeed
        , placeholder = Just (Input.placeholder [] (Element.text "Set the growing downspeed here"))
        , label =
            Input.labelAbove []
                (Element.text "Downspeed")
        }
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata8SetDesiredHeight
        , text = String.fromInt kata8.desiredheight
        , placeholder = Just (Input.placeholder [] (Element.text "Set the desired height here"))
        , label =
            Input.labelAbove []
                (Element.text "Desired height")
        }
    , Element.el [ Font.extraBold ] <|
        Element.text
            "Days to reach the height"
    , Element.el [ Font.extraLight ] <|
        Element.text
            (String.fromInt
                kata8.days
            )
    ]


viewKata9 : Kata9 -> List (Element Msg)
viewKata9 kata9 =
    [ html <| h2 [] [ Html.text "⚠️Fusion Chamber Shutdown⚠️" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """Given the number of atoms of Carbon [C],Hydrogen[H] and Oxygen[O] in the chamber. Calculate how many molecules of Water [H2O], Carbon Dioxide [CO2] and Methane [CH4] will be produced following the order of reaction affinity below:""" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """1. Hydrogen reacts with Oxygen   = H2O""" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """2. Carbon   reacts with Oxygen   = CO2""" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """3. Carbon   reacts with Hydrogen = CH4""" ]
    , row [ width fill, spacing 20 ]
        [ column [ width (fillPortion 1), spacing 15 ]
            [ Input.text
                [ Font.extraLight ]
                { onChange = Kata9SetCarbon
                , text = String.fromInt kata9.carbon
                , placeholder = Just (Input.placeholder [] (Element.text "Set # of Carbon atoms"))
                , label =
                    Input.labelAbove []
                        (Element.text "Carbon")
                }
            , Input.text
                [ Font.extraLight ]
                { onChange = Kata9SetHydrogen
                , text = String.fromInt kata9.hydrogen
                , placeholder = Just (Input.placeholder [] (Element.text "Set # of Hydrogen atoms"))
                , label =
                    Input.labelAbove []
                        (Element.text "Hydrogen")
                }
            , Input.text
                [ Font.extraLight ]
                { onChange = Kata9SetOxygen
                , text = String.fromInt kata9.oxygen
                , placeholder = Just (Input.placeholder [] (Element.text "Set # of Oxygen atoms"))
                , label =
                    Input.labelAbove []
                        (Element.text "Oxygen")
                }
            ]
        , column [ width (fillPortion 1), spacing 15 ]
            [ Element.el [ Font.extraBold ] <|
                Element.text
                    "Water molecules"
            , Element.el [ Font.extraLight ] <|
                Element.text
                    (String.fromInt
                        kata9.water
                    )
            , Element.el [ Font.extraBold ] <|
                Element.text
                    "CO2 molecules"
            , Element.el [ Font.extraLight ] <|
                Element.text
                    (String.fromInt
                        kata9.co2
                    )
            , Element.el [ Font.extraBold ] <|
                Element.text
                    "Methane molecules"
            , Element.el [ Font.extraLight ] <|
                Element.text
                    (String.fromInt
                        kata9.methane
                    )
            ]
        ]
    ]


viewKata10 : Kata10 -> List (Element Msg)
viewKata10 kata10 =
    [ html <| h2 [] [ Html.text "Sum of Digits / Digital Root" ]
    , Element.paragraph [ Font.extraLight ]
        [ Element.text """Digital root is the recursive sum of all the digits in a number.""" ]
    , Input.text
        [ Font.extraLight ]
        { onChange = Kata10Set
        , text = String.fromInt (first kata10)
        , placeholder = Just (Input.placeholder [] (Element.text "Write the number to calculate the digital root here"))
        , label =
            Input.labelAbove []
                (Element.text "Number to calculate the digital root")
        }
    , Element.el [ Font.extraBold ] <|
        Element.text
            "Digital root"
    , Element.el [ Font.extraLight ] <|
        Element.text <|
            String.fromInt
                (second
                    kata10
                )
    ]


view : Model -> View Msg
view model =
    let
        { kata5, kata6, kata7, kata8, kata9, kata10 } =
            model
    in
    { title = "Day 22"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ paddingXY 40 20
                    , Font.size 30
                    , width fill
                    ]
                    [ html <| h1 [] [ Html.text "Day 22" ]
                    , row [ spacing 100, Font.size 15, width fill ]
                        [ column [ alignTop, spacing 15, width (fillPortion 1) ] (viewKata5 kata5 ++ viewKata7 kata7 ++ viewKata9 kata9)
                        , column [ alignTop, spacing 15, width (fillPortion 1) ] (viewKata6 kata6 ++ viewKata8 kata8 ++ viewKata10 kata10)
                        ]
                    ]
    }


morseCodes : { encode : String -> String, get : String -> String }
morseCodes =
    { encode = \a -> Maybe.withDefault "🐽" (Dict.get a codeMorseEncoding)
    , get = \a -> Maybe.withDefault "🐽" (Dict.get a codeMorseDecode)
    }


codeMorseEncoding =
    Dict.fromList
        [ ( "A", ".-" )
        , ( "B", "-..." )
        , ( "C", "-.-." )
        , ( "D", "-.." )
        , ( "E", "." )
        , ( "F", "..-." )
        , ( "G", "--." )
        , ( "H", "...." )
        , ( "I", ".." )
        , ( "J", ".---" )
        , ( "K", "-.-" )
        , ( "L", ".-.." )
        , ( "M", "--" )
        , ( "N", "-." )
        , ( "O", "---" )
        , ( "P", ".--." )
        , ( "Q", "--.-" )
        , ( "R", ".-." )
        , ( "S", "..." )
        , ( "T", "-" )
        , ( "U", "..-" )
        , ( "V", "...-" )
        , ( "W", ".--" )
        , ( "X", "-..-" )
        , ( "Y", "-.--" )
        , ( "Z", "--.." )
        , -- numbers
          ( "1", ".----" )
        , ( "2", "..---" )
        , ( "3", "...--" )
        , ( "4", "....-" )
        , ( "5", "....." )
        , ( "6", "-...." )
        , ( "7", "--..." )
        , ( "8", "---.." )
        , ( "9", "----." )
        , ( "0", "-----" )
        , -- punctuation
          ( ".", ".-.-.-" )
        , ( ",", "--..--" )
        , ( "?", "..--.." )
        , ( "'", ".----." )
        , ( "!", "-.-.--" )
        , ( "/", "-..-." )
        , ( "(", "-.--." )
        , ( ")", "-.--.-" )
        , ( "&", ".-..." )
        , ( ":", "---..." )
        , ( ";", "-.-.-." )
        , ( "=", "-...-" )
        , ( "+", ".-.-." )
        , ( "-", "-....-" )
        , ( "_", "..--.-" )
        , ( "\"", ".-..-." )
        , ( "$", "...-..-" )
        , ( "@", ".--.-." )
        , ( " ", "/" )
        ]


codeMorseDecode =
    Dict.fromList
        [ ( ".-", "A" )
        , -- letters
          ( "-...", "B" )
        , ( "-.-.", "C" )
        , ( "-..", "D" )
        , ( ".", "E" )
        , ( "..-.", "F" )
        , ( "--.", "G" )
        , ( "....", "H" )
        , ( "..", "I" )
        , ( ".---", "J" )
        , ( "-.-", "K" )
        , ( ".-..", "L" )
        , ( "--", "M" )
        , ( "-.", "N" )
        , ( "---", "O" )
        , ( ".--.", "P" )
        , ( "--.-", "Q" )
        , ( ".-.", "R" )
        , ( "...", "S" )
        , ( "-", "T" )
        , ( "..-", "U" )
        , ( "...-", "V" )
        , ( ".--", "W" )
        , ( "-..-", "X" )
        , ( "-.--", "Y" )
        , ( "--..", "Z" )
        , -- numbers
          ( ".----", "1" )
        , ( "..---", "2" )
        , ( "...--", "3" )
        , ( "....-", "4" )
        , ( ".....", "5" )
        , ( "-....", "6" )
        , ( "--...", "7" )
        , ( "---..", "8" )
        , ( "----.", "9" )
        , ( "-----", "0" )
        , -- punctuation
          ( ".-.-.-", "." )
        , ( "--..--", "," )
        , ( "..--..", "?" )
        , ( ".----.", "'" )
        , ( "-.-.--", "!" )
        , ( "-..-.", "/" )
        , ( "-.--.", "(" )
        , ( "-.--.-", ")" )
        , ( ".-...", "&" )
        , ( "---...", ":" )
        , ( "-.-.-.", ";" )
        , ( "-...-", "=" )
        , ( ".-.-.", "+" )
        , ( "-....-", "-" )
        , ( "..--.-", "_" )
        , ( ".-..-.", "\"" )
        , ( "...-..-", "$" )
        , ( ".--.-.", "@" )
        , ( " ", "" )
        , ( "/", " " )
        ]
