module Pages.Day23 exposing (..)

-- import Html.Attributes exposing (..)

import Animation exposing (scale3d)
import Colors.Alpha
import Colors.Opaque exposing (grey)
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Attributes
import Html.Events exposing (onInput)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Tuple exposing (first, second)


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
    ( Int, ( Char, Int ) )


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( ( 8, ( ' ', -1 ) ), Cmd.none )


type Msg
    = SetSize Float
    | SetFirstMove Char Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( size, ( startingRow, startingCol ) ) =
    case msg of
        SetSize value ->
            ( ( round value, ( ' ', -1 ) ), Cmd.none )

        SetFirstMove row col ->
            let
                dummy =
                    startSolveBoard ( size, ( row, col ) )

                _ =
                    Debug.log ("solvableBoard [" ++ String.fromInt (List.length dummy) ++ "]") dummy
            in
            ( ( size, ( row, col ) ), Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


drawHeader : Int -> List (Element Msg)
drawHeader size =
    [ Input.slider
        [ Element.behindContent
            (Element.el
                [ Element.width Element.fill
                , Element.height (Element.px 2)
                , Element.centerY
                , Background.color Colors.Opaque.grey
                , Border.rounded 2
                ]
                Element.none
            )
        , Element.width <| Element.px 300
        ]
        { onChange = SetSize
        , min = 5
        , max = 26
        , label =
            Input.labelAbove [ Font.size 16 ]
                (Element.text ("Board size " ++ String.fromInt size ++ " x " ++ String.fromInt size))
        , thumb = Input.defaultThumb
        , step = Just 1
        , value = Basics.toFloat size
        }
    ]


letters =
    [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ]


cartesian : (a -> b -> c) -> List a -> List b -> List c
cartesian func xs ys =
    List.concatMap
        (\x -> List.map (\y -> func x y) ys)
        xs


blackOrWhite row col =
    if modBy 2 (col + Char.toCode row) == 0 then
        Colors.Opaque.white

    else
        Colors.Opaque.black


borderColor ( row, col ) ( srow, scol ) =
    if row == srow && col == scol then
        [ Border.color Colors.Opaque.lawngreen
        , Border.width 5
        , Font.color Colors.Opaque.gray
        , Font.shadow { offset = ( 2.0, 2.0 ), blur = 0.0, color = Colors.Opaque.lawngreen }
        ]

    else
        [ Border.color Colors.Opaque.gainsboro
        , Border.width 1
        ]


drawCell ( size, ( startingRow, startingCol ) ) row col =
    let
        sz =
            sizes (toFloat size)
    in
    Element.column
        ([ Font.color Colors.Opaque.gray
         , width <| px (round sz.width)
         , height <| px (round sz.width)
         , Background.color <| blackOrWhite row col
         , pointer
         ]
            ++ borderColor ( row, col ) ( startingRow, startingCol )
            ++ [ mouseOver
                    [ Background.color (Colors.Alpha.lawngreen 0.7)
                    , Font.shadow { offset = ( 1.0, 1.0 ), blur = 2.0, color = Colors.Opaque.black }
                    ]
               , onClick (SetFirstMove row col)
               ]
        )
        [ Element.el [ centerX, centerY ] <| Element.text (String.fromChar row ++ String.fromInt col) ]


drawRow : Model -> List Int -> Char -> Element Msg
drawRow model cols row =
    Element.row [] (List.map (drawCell model <| row) cols)


sizes size =
    { font = 20 - ((size - 5) * 5 / 21)
    , width = 60 - ((size - 5) * 25 / 21)
    }


drawBoard : Model -> Element Msg
drawBoard model =
    let
        size =
            first model

        rows =
            List.take size letters

        cols =
            List.range 1 size

        board =
            cartesian Tuple.pair rows cols

        sz =
            sizes (toFloat size)
    in
    Element.column
        [ Font.family [ Font.monospace ]
        , Font.extraLight
        , Font.size (round sz.font)
        , Font.center
        , Border.color Colors.Opaque.gainsboro
        , Border.width 1
        ]
        (List.map (drawRow model cols) rows)


possibleMoves : List Char -> List Int -> ( Char, Int ) -> List ( Char, Int )
possibleMoves rows cols ( row, col ) =
    let
        dictLetterToInt =
            Dict.fromList <| List.map2 Tuple.pair rows cols

        dictIntToLetter =
            Dict.fromList <| List.map2 Tuple.pair cols rows

        nextMoves i j =
            [ ( i - 2, j - 1 ), ( i - 2, j + 1 ), ( i - 1, j - 2 ), ( i - 1, j + 2 ), ( i + 1, j - 2 ), ( i + 1, j + 2 ), ( i + 2, j - 1 ), ( i + 2, j + 1 ) ]

        availableNextMoves =
            List.filter (\( x, y ) -> not (x <= 0 || y <= 0)) <| nextMoves (Maybe.withDefault -1 <| Dict.get row dictLetterToInt) col
    in
    List.map (\( x, y ) -> ( Maybe.withDefault ' ' <| Dict.get x dictIntToLetter, y )) availableNextMoves


startSolveBoard : Model -> List ( Char, Int )
startSolveBoard model =
    let
        size =
            first model

        rows =
            List.take size letters

        cols =
            List.range 1 size

        board =
            Dict.fromList <| (List.map (\a -> ( a, 0 )) <| cartesian Tuple.pair rows cols)

        sz =
            sizes (toFloat size)

        p0 =
            second model
    in
    knightTour rows cols [ p0 ] p0 size 1


knightTour : List Char -> List Int -> List ( Char, Int ) -> ( Char, Int ) -> Int -> Int -> List ( Char, Int )
knightTour rows cols sol currentPos size stepCount =
    let
        nextMoves =
            List.filter (\a -> not (List.member a sol)) <| possibleMoves rows cols currentPos

        nextPos =
            Maybe.withDefault ( ' ', -1 ) <| List.head <| List.take 1 nextMoves
    in
    if stepCount == (size * size) || List.isEmpty nextMoves then
        let
            dummy =
                Debug.log ("FIIIIN" ++ String.fromInt stepCount ++ "-" ++ String.fromInt (size * size) ++ "-") ( currentPos, size, stepCount )
        in
        sol

    else
        knightTour rows cols (nextPos :: sol) nextPos size (stepCount + 1)



-- knightTour : List Char -> List Int -> List ( Char, Int ) -> ( Char, Int ) -> List ( Char, Int ) -> Int -> Int -> List ( Char, Int )
-- knightTour rows cols sol ( posRow, posCol ) nextMoves size stepCount =
--     let
--         dummy =
--             Debug.log ("WTF- S TE P " ++ String.fromInt stepCount ++ "-" ++ String.fromInt (size * size) ++ "-") ( ( posRow, posCol ), size, stepCount )
--     in
--     if stepCount == (size * size) then
--         let
--             _ =
--                 Debug.log ("""Ja som al cap del carrer """ ++ String.fromInt stepCount ++ "") stepCount
--         in
--         sol
--     else
--         let
--             _ =
--                 Debug.log ("""In a middle step """ ++ String.fromInt stepCount ++ "") stepCount
--         in
--         List.map
--             (\nextPos ->
--                 if List.member nextPos sol then
--                     []
--                 else
--                     knightTour rows cols (nextPos :: sol) nextPos (List.filter (\a -> not <| List.member a sol) <| possibleMoves rows cols nextPos) size (stepCount + 1)
--             )
--             nextMoves
--             |> List.filter (\a -> List.length a == 25)
--             |> List.concat


view : Model -> Document Msg
view model =
    let
        size =
            first model
    in
    { title = "Day 23"
    , body =
        [ column
            [ centerX
            , padding 40
            , spacing 20
            , Font.size 30
            ]
            [ row [ centerX ] (drawHeader size)
            , row [] [ drawBoard model ]
            ]
        ]
    }
