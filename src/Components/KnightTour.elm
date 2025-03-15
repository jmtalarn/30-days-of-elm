module Components.KnightTour exposing (Board, Position, reverseBoard, solveAndFormat, solveKnightsTour)

--https://github.com/dc25/knightsTourElm/blob/master/Main.elm

import Char exposing (fromCode)
import Dict exposing (Dict)
import Maybe exposing (withDefault)


type alias Position =
    ( Int, Int )


type alias Board =
    Dict Position Int


knightMoves : List Position
knightMoves =
    [ ( 2, 1 )
    , ( 1, 2 )
    , ( -1, 2 )
    , ( -2, 1 )
    , ( -2, -1 )
    , ( -1, -2 )
    , ( 1, -2 )
    , ( 2, -1 )
    ]


isSafe : Int -> Position -> Board -> Bool
isSafe boardSize ( x, y ) board =
    x
        >= 0
        && x
        < boardSize
        && y
        >= 0
        && y
        < boardSize
        && not (Dict.member ( x, y ) board)


solveKnightsTour : Int -> Position -> Maybe Board
solveKnightsTour boardSize startPos =
    let
        initialBoard =
            Dict.singleton startPos 0

        solution =
            solveKnightsTourHelper boardSize startPos 1 initialBoard

        _ =
            Debug.log "KnightTourSolution" solution
    in
    solution


solveKnightsTourHelper : Int -> Position -> Int -> Board -> Maybe Board
solveKnightsTourHelper boardSize ( x, y ) moveCount board =
    let
        _ =
            Debug.log "KnightTourSolutionHelper" ( x, y, moveCount )
    in
    if moveCount == boardSize * boardSize then
        Just board

    else
        List.foldl
            (\( dx, dy ) acc ->
                case acc of
                    Just solution ->
                        Just solution

                    Nothing ->
                        let
                            nextPos =
                                ( x + dx, y + dy )
                        in
                        if isSafe boardSize nextPos board then
                            solveKnightsTourHelper boardSize nextPos (moveCount + 1) (Dict.insert nextPos moveCount board)

                        else
                            Nothing
            )
            Nothing
            knightMoves



-- Convert the solution board into a printable grid representation


formatBoard : Int -> Maybe Board -> String
formatBoard boardSize maybeBoard =
    case maybeBoard of
        Nothing ->
            "No solution found."

        Just board ->
            let
                getCellValue : Int -> Int -> String
                getCellValue x y =
                    Dict.get ( x, y ) board
                        |> withDefault -1
                        |> String.fromInt
                        |> String.padLeft 3 ' '

                formatRow : Int -> String
                formatRow y =
                    List.range 0 (boardSize - 1)
                        |> List.map (\x -> getCellValue x y)
                        |> String.join " "

                rows =
                    List.range 0 (boardSize - 1)
                        |> List.map formatRow
                        |> String.join "\n"
            in
            rows



-- Example Usage:


solveAndFormat : Int -> Position -> String
solveAndFormat size startPos =
    solveKnightsTour size startPos
        |> formatBoard size


reverseBoard : Board -> List ( Char, Int )
reverseBoard board =
    board
        |> Dict.toList
        |> List.sortBy Tuple.second
        |> List.map (\( ( x, y ), _ ) -> ( fromCode (x + 65), y + 1 ))
