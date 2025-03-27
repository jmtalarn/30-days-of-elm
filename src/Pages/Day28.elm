module Pages.Day28 exposing (Model, Msg, page)

import Colors.Alpha
import Colors.Opaque
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, s)
import List exposing (foldl)
import Maybe
import Page exposing (Page)
import Random exposing (int)
import Route exposing (Route)
import Shared
import Svg exposing (..)
import Svg.Attributes as SvgAttrs exposing (..)
import Time
import Tuple exposing (first, second)
import UI
import View exposing (View)


dt =
    0.03


page : Page Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { config : ( Int, Maybe ( Char, Int ) )
    , solution : List ( Char, Int )
    }


init : ( Model, Cmd Msg )
init =
    ( { config = ( 8, Nothing ), solution = [] }, Cmd.none )


type Msg
    = SetSize Float
    | SetFirstMove (Maybe ( Char, Int ))
    | Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        size =
            first model.config
    in
    case msg of
        SetSize value ->
            let
                roundedValue =
                    round value
            in
            ( { model | config = ( roundedValue, Nothing ), solution = [] }, Cmd.none )

        SetFirstMove maybePosition ->
            ( { model
                | config =
                    ( size
                    , maybePosition
                    )
                , solution =
                    case maybePosition of
                        Just position ->
                            [ position ]

                        Nothing ->
                            []
              }
            , Cmd.none
            )

        Tick t ->
            if (size * size) == List.length model.solution then
                ( model, Cmd.none )

            else
                let
                    m =
                        case model.solution of
                            [] ->
                                model

                            _ ->
                                case bestMove model of
                                    Nothing ->
                                        model

                                    Just best ->
                                        { model | solution = best :: model.solution }

                    _ =
                        Debug.log "length " (List.length model.solution)
                in
                ( m, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every (dt * 1000) Tick


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


lettersDict : Dict.Dict Int Char
lettersDict =
    Dict.fromList <| List.indexedMap (\i letter -> ( i + 1, letter )) letters


cartesian : (a -> b -> c) -> List a -> List b -> List c
cartesian func xs ys =
    List.concatMap
        (\x -> List.map (\y -> func x y) ys)
        xs


blackOrWhite col row =
    if modBy 2 (row + Char.toCode col) == 0 then
        Colors.Opaque.white

    else
        Colors.Opaque.black


borderColumn ( col, row ) ( scol, srow ) =
    if col == scol && row == srow then
        [ Border.color Colors.Opaque.lawngreen
        , Border.width 5
        , Font.color Colors.Opaque.gray
        , Font.shadow { offset = ( 2.0, 2.0 ), blur = 0.0, color = Colors.Opaque.lawngreen }
        ]

    else
        [--     Border.color Colors.Opaque.gainsboro
         -- , Border.width 1
        ]


drawCell ( size, maybeStartPos ) row col =
    let
        sz =
            sizes (toFloat size)

        ( startingCol, startingRow ) =
            case maybeStartPos of
                Just ( c, r ) ->
                    ( c, r )

                Nothing ->
                    ( ' ', -1 )
    in
    Element.column
        ([ Font.color Colors.Opaque.gray
         , Element.width <| px (round sz.width)
         , Element.height <| px (round sz.width)
         , Background.color <| blackOrWhite col row
         , pointer
         ]
            ++ borderColumn ( col, row ) ( startingCol, startingRow )
            ++ [ mouseOver
                    [ Background.color (Colors.Alpha.lawngreen 0.7)
                    , Font.shadow { offset = ( 1.0, 1.0 ), blur = 2.0, color = Colors.Opaque.black }
                    ]
               , onClick (SetFirstMove (Just ( col, row )))
               ]
        )
        [ Element.el [ centerX, centerY ] <| Element.text (String.fromChar col ++ String.fromInt row) ]


drawCol : Model -> List Char -> Int -> Element Msg
drawCol model cols row =
    Element.row [] (List.map (drawCell model.config <| row) cols)


sizes size =
    { font = 20 - ((size - 5) * 5 / 21)
    , width = 60 - ((size - 5) * 25 / 21)
    }


drawBoard : Model -> Element Msg
drawBoard model =
    let
        size =
            first model.config

        cols =
            List.take size letters

        rows =
            List.reverse <| List.range 1 size

        board =
            cartesian Tuple.pair cols rows

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
        (List.map (drawCol model cols) rows)


nextMoves : Int -> List ( Char, Int ) -> ( Char, Int ) -> List ( Char, Int )
nextMoves size solution ( col, row ) =
    let
        cols =
            List.take size letters

        _ =
            Debug.log "letters" letters

        _ =
            Debug.log "cols" cols

        rows =
            List.range 1 size

        _ =
            Debug.log "rows" rows

        maxCol =
            Maybe.withDefault 0 <| Dict.get (Maybe.withDefault ' ' (List.maximum cols)) dictLetterToInt

        maxRow =
            Maybe.withDefault 0 (List.maximum rows)

        dictLetterToInt =
            Dict.fromList <| List.map2 Tuple.pair cols rows

        _ =
            Debug.log "dictLetterToInt" dictLetterToInt

        dictIntToLetter =
            Dict.fromList <| List.map2 Tuple.pair rows cols

        _ =
            Debug.log "dictIntToLetter" dictIntToLetter

        listNextMoves i j =
            [ ( i - 2, j - 1 ), ( i - 2, j + 1 ), ( i - 1, j - 2 ), ( i - 1, j + 2 ), ( i + 1, j - 2 ), ( i + 1, j + 2 ), ( i + 2, j - 1 ), ( i + 2, j + 1 ) ]

        regularNextMoves =
            listNextMoves (Maybe.withDefault -1 <| Dict.get col dictLetterToInt) row

        _ =
            Debug.log "regularNextMoves" regularNextMoves

        solutionInNumbers =
            List.map (\( x0, y0 ) -> ( Dict.get x0 dictLetterToInt |> Maybe.withDefault -1, y0 )) solution

        _ =
            Debug.log "solutionInNumbers" solutionInNumbers

        availableNextMoves =
            List.filter
                (\x -> not (List.member x solutionInNumbers))
                (List.filter (\( x, y ) -> (x > 0 && x <= maxCol) && (y > 0 && y <= maxRow)) <| regularNextMoves)

        _ =
            Debug.log "availableNextMoves" availableNextMoves
    in
    List.map (\( x, y ) -> ( Maybe.withDefault ' ' <| Dict.get x dictIntToLetter, y )) availableNextMoves


bestMove : Model -> Maybe ( Char, Int )
bestMove model =
    let
        size =
            first model.config

        minimumBy : (a -> comparable) -> List a -> Maybe a
        minimumBy f ls =
            let
                minBy : a -> ( a, comparable ) -> ( a, comparable )
                minBy x (( _, fy ) as min) =
                    let
                        fx : comparable
                        fx =
                            f x
                    in
                    if fx < fy then
                        ( x, fx )

                    else
                        min
            in
            case ls of
                [ l_ ] ->
                    Just l_

                l_ :: ls_ ->
                    Just <| first <| foldl minBy ( l_, f l_ ) ls_

                _ ->
                    Nothing
    in
    case List.head model.solution of
        Nothing ->
            Nothing

        Just mph ->
            minimumBy (List.length << nextMoves size model.solution) (nextMoves size model.solution mph)


view : Model -> View Msg
view model =
    let
        size =
            first model.config

        startPosition =
            second model.config

        _ =
            Debug.log "Model" model
    in
    { title = "Day 28"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , Element.padding 40
                    , Element.spacing 20
                    , Font.size 30
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 28" ] ]
                    , row [ centerX ] (drawHeader size)
                    , row []
                        [ column [ inFront <| drawSolution model ]
                            [ drawBoard model
                            ]
                        ]
                    , row [ centerX ] [ Element.text <| "Unvisited cells: " ++ String.fromInt ((size * size) - List.length model.solution) ]
                    ]
    }


drawSolution : Model -> Element Msg
drawSolution model =
    let
        size =
            first model.config

        cols =
            List.take size letters

        rows =
            List.range 1 size

        up =
            toFloat (round (toFloat size * sz.width))

        right =
            0

        sz =
            sizes <| toFloat size

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

        dictLetterToInt =
            Dict.fromList <| List.map2 Tuple.pair cols rows

        toLine =
            \( ay, ax ) ( by, bx ) ->
                Svg.path
                    [ d ("M" ++ String.fromFloat ax ++ " " ++ String.fromFloat ay ++ " " ++ String.fromFloat bx ++ " " ++ String.fromFloat by)
                    , strokeWidth "4"
                    , stroke "red"
                    ]
                    []

        toCircle ( y, x ) =
            circle
                [ cx <| String.fromFloat x
                , cy <| String.fromFloat y
                , r <| String.fromFloat (sz.width / 4)
                , SvgAttrs.fill "#1E90FF"
                ]
                []

        showMove ( c0, r0 ) ( c1, r1 ) =
            g []
                [ toCircle (charInt2xy ( c0, r0 ))
                , toCircle (charInt2xy ( c1, r1 ))
                , toLine (charInt2xy ( c0, r0 )) (charInt2xy ( c1, r1 ))
                ]
    in
    Element.el
        [ onClick (SetFirstMove Nothing)
        ]
        (if List.isEmpty model.solution then
            Element.none

         else
            Element.html <|
                svg
                    [ SvgAttrs.width <| String.fromFloat (sz.width * toFloat size)
                    , SvgAttrs.height <| String.fromFloat (sz.width * toFloat size)
                    , viewBox ("0 0 " ++ String.fromFloat (sz.width * toFloat size) ++ " " ++ String.fromFloat (sz.width * toFloat size))
                    , SvgAttrs.transform "rotate(-90)"
                    ]
                    (case List.tail model.solution of
                        Nothing ->
                            []

                        Just tl ->
                            List.map2 showMove model.solution tl
                    )
        )



-- drawSolution : Model -> Element Msg
-- drawSolution model =
--     let
--         ( size, p0 ) =
--             model.config
--         sz =
--             sizes <| toFloat size
--         up =
--             toFloat (round (toFloat size * sz.width))
--         right =
--             0
--         cols =
--             List.take size letters
--         rows =
--             List.range 1 size
--         dictLetterToInt =
--             Dict.fromList <| List.map2 Tuple.pair cols rows
--         toCircle ( y, x ) =
--             circle
--                 [ cx <| String.fromFloat x
--                 , cy <| String.fromFloat y
--                 , r <| String.fromFloat (sz.width / 4)
--                 , SvgAttrs.fill "#1E90FF"
--                 ]
--                 []
--     in
--     case model.solution of
--         Nothing ->
--             Element.el [] (Element.text "")
--         Just solution ->
--             let
--                 cellCenter x =
--                     x + (sz.width / 2)
--                 offset index =
--                     (index - 1) * sz.width
--                 charInt2xy ( a, i ) =
--                     ( Dict.get a dictLetterToInt
--                         |> Maybe.withDefault 0
--                         |> toFloat
--                         |> offset
--                         |> cellCenter
--                     , i
--                         |> toFloat
--                         |> offset
--                         |> cellCenter
--                     )
--                 circles =
--                     solution
--                         |> List.map charInt2xy
--                         |> List.map toCircle
--                 length =
--                     List.length circles
--                 paths =
--                     let
--                         pointsA =
--                             List.take (length - 1) <| List.map charInt2xy solution
--                         pointsB =
--                             List.drop 1 <| List.map charInt2xy solution
--                     in
--                     List.map2
--                         (\( ay, ax ) ( by, bx ) ->
--                             Svg.path
--                                 [ d ("M" ++ String.fromFloat ax ++ " " ++ String.fromFloat ay ++ " " ++ String.fromFloat bx ++ " " ++ String.fromFloat by)
--                                 , strokeWidth "4"
--                                 , stroke "red"
--                                 ]
--                                 []
--                         )
--                         pointsA
--                         pointsB
--                 _ =
--                     Debug.log "solution" solution
--             in
--             Element.el [ moveUp up, moveRight right, onClick (SetFirstMove Nothing) ] <|
--                 if List.isEmpty circles then
--                     Element.text "No solution found."
--                 else
--                     Element.html <|
--                         svg
--                             [ SvgAttrs.width <| String.fromFloat (sz.width * toFloat size)
--                             , SvgAttrs.height <| String.fromFloat (sz.width * toFloat size)
--                             , viewBox ("0 0 " ++ String.fromFloat (sz.width * toFloat size) ++ " " ++ String.fromFloat (sz.width * toFloat size))
--                             , SvgAttrs.transform "rotate(-90)"
--                             ]
--                             (paths ++ circles)
