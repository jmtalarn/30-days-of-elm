module Pages.Day5 exposing (..)

import Array exposing (Array, append, foldr, fromList, get, set, toList)
import Element exposing (html)
import Html exposing (Html, button, div, h1, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (all, member, repeat)
import Platform.Cmd exposing (Cmd)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Task


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


type alias CheckboxRecord =
    ( Int, Int, Bool )


type alias Model =
    Array (Array CheckboxRecord)


init : Shared.Model -> Url params -> ( Model, Cmd Msg )
init _ _ =
    ( Array.map
        (\n ->
            Array.map
                (\m ->
                    ( m
                    , n
                    , if m == 0 && n == 2 || m == 2 && n == 2 || m == 4 && n == 2 then
                        False

                      else
                        True
                    )
                )
                (Array.fromList (List.range 0 4))
        )
        (Array.fromList (List.range 0 4))
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


type Msg
    = Toggle Int Int Bool
    | EasySetup


fromJustBool : Maybe CheckboxRecord -> CheckboxRecord
fromJustBool x =
    case x of
        Just y ->
            y

        Nothing ->
            ( -1, -1, False )


fromJustArrayBool : Maybe (Array CheckboxRecord) -> Array CheckboxRecord
fromJustArrayBool x =
    case x of
        Just y ->
            y

        Nothing ->
            Array.fromList <| repeat 5 ( -1, -1, False )


getXY : Model -> Int -> Int -> CheckboxRecord
getXY model x y =
    fromJustBool <| (get y model |> Maybe.andThen (get x))


setXY : Model -> Int -> Int -> Bool -> Model
setXY model x y value =
    set y (set x ( x, y, value ) (fromJustArrayBool <| get y model)) model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle x y processAround ->
            let
                ( _, _, value ) =
                    getXY model x y
            in
            if processAround then
                let
                    around =
                        List.map (\( a, b ) -> Task.perform (\() -> Toggle a b False) (Task.succeed ())) [ ( x, y - 1 ), ( x, y + 1 ), ( x - 1, y ), ( x + 1, y ) ]
                in
                ( setXY model x y <| not value
                , Cmd.batch around
                )

            else
                ( setXY model x y <| not value
                , Cmd.none
                )

        EasySetup ->
            ( Array.map
                (\n ->
                    Array.map
                        (\m ->
                            ( m
                            , n
                            , if member [ m, n ] [ [ 2, 1 ], [ 2, 2 ], [ 2, 3 ], [ 1, 2 ], [ 2, 2 ], [ 3, 2 ] ] then
                                True

                              else
                                False
                            )
                        )
                        (Array.fromList (List.range 0 4))
                )
                (Array.fromList (List.range 0 4))
            , Cmd.none
            )


flatten : Array (Array a) -> Array a
flatten plane =
    plane |> foldr append (fromList [])


allClean : Model -> Basics.Bool
allClean model =
    all (\( _, _, value ) -> value == False) (Array.toList <| flatten model)


htmlIf : Html msg -> Bool -> Html msg
htmlIf el cond =
    if cond then
        el

    else
        text ""


view : Model -> Document Msg
view model =
    { title = "Day 5"
    , body =
        [ html <|
            div
                [ style "margin" "0 auto"

                --       , style "width" "80%"
                , style "max-width" "800px"
                , style "display" "flex"
                , style "flex-direction" "column"
                , style "align-items" "center"
                ]
                [ h1 [] [ text "Day 5" ]
                , div
                    [ style "display" "inline-grid"
                    , style "grid-template-columns" "repeat(5, 2rem)"
                    , style "grid-template-rows" "repeat(5, 2rem)"
                    , style "gap" "1rem"
                    , style "font-size" "30px"
                    ]
                    (toList
                        (Array.map
                            toCheckbox
                         <|
                            flatten model
                        )
                    )
                , button
                    [ style "margin" "2rem"
                    , style "background-color" "dodgerblue"
                    , style "padding" "1rem"
                    , style "color" "white"
                    , style "font-size" "2rem"
                    , style "border" "none"
                    , style "border-radius" "4px"
                    , onClick EasySetup
                    ]
                    [ text "Easy setup" ]
                , htmlIf
                    (p [ style "font-family" "monospace", style "font-size" "2rem", style "font-weight" "bold", style "color" "tomato", style "white-space" "initial" ]
                        [ text "Good Job 🏆! All are clean now " ]
                    )
                    (allClean
                        model
                    )
                ]
        ]
    }


toCheckbox : CheckboxRecord -> Html Msg
toCheckbox ( x, y, value ) =
    input
        [ type_ "checkbox"
        , style "width" "100%"
        , style "height" "100%"
        , checked value
        , attribute "data-x" <| String.fromInt x
        , attribute "data-y" <| String.fromInt y
        , onClick <| Toggle x y True
        ]
        []
