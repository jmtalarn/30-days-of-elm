module Day1 exposing (Model, init, main)

import Browser
import Html exposing (Html, div, h1, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



{-
                 ███    ███     █████     ██    ███    ██
                 ████  ████    ██   ██    ██    ████   ██
   ██████████    ██ ████ ██    ███████    ██    ██ ██  ██
                 ██  ██  ██    ██   ██    ██    ██  ██ ██
                 ██      ██    ██   ██    ██    ██   ████
-}


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



{-
                 ███    ███     ██████     ██████     ███████    ██
                 ████  ████    ██    ██    ██   ██    ██         ██
   ██████████    ██ ████ ██    ██    ██    ██   ██    █████      ██
                 ██  ██  ██    ██    ██    ██   ██    ██         ██
                 ██      ██     ██████     ██████     ███████    ███████
-}


type alias Model =
    Int


init : Model
init =
    0



{-
                 ██    ██    ██████     ██████      █████     ████████    ███████
                 ██    ██    ██   ██    ██   ██    ██   ██       ██       ██
   ██████████    ██    ██    ██████     ██   ██    ███████       ██       █████
                 ██    ██    ██         ██   ██    ██   ██       ██       ██
                  ██████     ██         ██████     ██   ██       ██       ███████
-}


type Msg
    = Set String


update : Msg -> Model -> Model
update msg _ =
    case msg of
        Set value ->
            Maybe.withDefault 0 (String.toInt value)



{-
                 ██    ██    ██    ███████    ██     ██
                 ██    ██    ██    ██         ██     ██
   ██████████    ██    ██    ██    █████      ██  █  ██
                  ██  ██     ██    ██         ██ ███ ██
                   ████      ██    ███████     ███ ███
-}


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "align-items" "center"
        , style "padding" "4rem"
        , style "font-size" "30px"
        ]
        [ h1 [] [ text "Day 1" ]
        , input
            [ type_ "range"
            , onInput Set
            , value (String.fromInt model)
            ]
            []
        , p
            [ style "font-family" "monospace" ]
            [ text (String.fromInt model) ]
        ]
