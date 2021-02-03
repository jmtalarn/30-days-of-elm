module Day2 exposing (Model, init, main)

import Browser
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (..)



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
    List String


init : Model
init =
    [ "Alice", "Bob", "Chuck", "Me", "You", "They" ]



{-
                 ██    ██    ██████     ██████      █████     ████████    ███████
                 ██    ██    ██   ██    ██   ██    ██   ██       ██       ██
   ██████████    ██    ██    ██████     ██   ██    ███████       ██       █████
                 ██    ██    ██         ██   ██    ██   ██       ██       ██
                  ██████     ██         ██████     ██   ██       ██       ███████
-}


type Msg
    = NoOp



--     = Set String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



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
        , style "flex-direction" "row"
        , style "flex-wrap" "wrap"
        , style "align-items" "center"
        , style "padding" "4rem"
        , style "font-size" "30px"
        ]
        (List.map transformToParagraph model)


transformToParagraph : String -> Html msg
transformToParagraph item =
    p
        [ style "font-family" "sans-serif"
        , style "padding" "1rem"
        , style "margin" "1rem"
        , style "border" "1px dotted crimson"
        ]
        [ text item ]
