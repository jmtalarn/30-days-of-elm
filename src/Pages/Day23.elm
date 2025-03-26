module Pages.Day23 exposing (Model, Msg, page)

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
import Maybe
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
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
    ( Int, ( Char, Int ) )


init : ( Model, Cmd Msg )
init =
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
            ( ( size, ( row, col ) ), Cmd.none )


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
        [--     Border.color Colors.Opaque.gainsboro
         -- , Border.width 1
        ]


drawCell ( size, ( startingRow, startingCol ) ) row col =
    let
        sz =
            sizes (toFloat size)
    in
    Element.column
        ([ Font.color Colors.Opaque.gray
         , Element.width <| px (round sz.width)
         , Element.height <| px (round sz.width)
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
        maxRow =
            Maybe.withDefault 0 <| Dict.get (Maybe.withDefault ' ' (List.maximum rows)) dictLetterToInt

        maxCol =
            Maybe.withDefault 0 (List.maximum cols)

        dictLetterToInt =
            Dict.fromList <| List.map2 Tuple.pair rows cols

        dictIntToLetter =
            Dict.fromList <| List.map2 Tuple.pair cols rows

        nextMoves i j =
            [ ( i - 2, j - 1 ), ( i - 2, j + 1 ), ( i - 1, j - 2 ), ( i - 1, j + 2 ), ( i + 1, j - 2 ), ( i + 1, j + 2 ), ( i + 2, j - 1 ), ( i + 2, j + 1 ) ]

        availableNextMoves =
            List.filter (\( x, y ) -> (x > 0 && x <= maxRow) && (y > 0 && y <= maxCol)) <| nextMoves (Maybe.withDefault -1 <| Dict.get row dictLetterToInt) col
    in
    List.map (\( x, y ) -> ( Maybe.withDefault ' ' <| Dict.get x dictIntToLetter, y )) availableNextMoves


solveBoard : Model -> List ( Char, Int )
solveBoard model =
    let
        size =
            first model

        rows =
            List.take size letters

        cols =
            List.range 1 size

        -- board =
        --     Dict.fromList <| (List.map (\a -> ( a, 0 )) <| cartesian Tuple.pair rows cols)
        -- sz =
        --     sizes (toFloat size)
        p0 =
            second model
    in
    knightTour rows cols [] p0 size 0


knightTour : List Char -> List Int -> List ( Char, Int ) -> ( Char, Int ) -> Int -> Int -> List ( Char, Int )
knightTour rows cols sol currentPos size stepCount =
    let
        nextMoves =
            List.filter (\a -> not (List.member a sol)) <| possibleMoves rows cols currentPos

        nextPos =
            Maybe.withDefault ( ' ', -1 ) <| List.head <| List.take 1 nextMoves
    in
    if stepCount == (size * size) || List.isEmpty nextMoves then
        sol ++ [ currentPos ]

    else
        knightTour rows cols (sol ++ [ currentPos ]) nextPos size (stepCount + 1)


drawSolution : Model -> Element Msg
drawSolution ( size, p0 ) =
    let
        sz =
            sizes <| toFloat size

        up =
            toFloat (round (toFloat size * sz.width))

        right =
            0

        rows =
            List.take size letters

        cols =
            List.range 1 size

        dictLetterToInt =
            Dict.fromList <| List.map2 Tuple.pair rows cols

        toCircle ( y, x ) =
            circle
                [ cx <| String.fromFloat x
                , cy <| String.fromFloat y
                , r <| String.fromFloat (sz.width / 4)
                , SvgAttrs.fill "#1E90FF"
                ]
                []

        ( rowp0, colp0 ) =
            p0
    in
    if rowp0 == ' ' && colp0 == -1 then
        Element.el [] (Element.text "")

    else
        let
            solution =
                solveBoard ( size, p0 )

            cellCenter x =
                x + (sz.width / 2)

            offset index =
                (index - 1) * sz.width

            charInt2xy ( a, i ) =
                ( Dict.get a dictLetterToInt
                    |> Maybe.withDefault 0
                    |> toFloat
                    |> offset
                    |> cellCenter
                , i
                    |> toFloat
                    |> offset
                    |> cellCenter
                )

            circles =
                solution
                    |> List.map charInt2xy
                    |> List.map toCircle

            length =
                List.length circles

            paths =
                let
                    pointsA =
                        List.take (length - 1) <| List.map charInt2xy solution

                    pointsB =
                        List.drop 1 <| List.map charInt2xy solution
                in
                List.map2
                    (\( ay, ax ) ( by, bx ) ->
                        Svg.path
                            [ d ("M" ++ String.fromFloat ax ++ " " ++ String.fromFloat ay ++ " " ++ String.fromFloat bx ++ " " ++ String.fromFloat by)
                            , strokeWidth "4"
                            , stroke "red"
                            ]
                            []
                    )
                    pointsA
                    pointsB
        in
        Element.el [ moveUp up, moveRight right, onClick (SetFirstMove ' ' -1) ]
            (Element.html <|
                svg
                    [ SvgAttrs.width <| String.fromFloat (sz.width * toFloat size)
                    , SvgAttrs.height <| String.fromFloat (sz.width * toFloat size)
                    , viewBox ("0 0 " ++ String.fromFloat (sz.width * toFloat size) ++ " " ++ String.fromFloat (sz.width * toFloat size))
                    ]
                    (paths ++ circles)
            )


view : Model -> View Msg
view model =
    let
        size =
            first model
    in
    { title = "Day 23"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , Element.padding 40
                    , Element.spacing 20
                    , Font.size 30
                    ]
                    [ row [ centerX ] (drawHeader size)
                    , row []
                        [ column []
                            [ drawBoard model
                            , drawSolution model
                            ]
                        ]
                    ]
    }
