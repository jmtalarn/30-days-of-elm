module Day4 exposing (Model, init, main)

import Browser
import Html exposing (Html, div, h1, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
import Time



{-
                 ███    ███     █████     ██    ███    ██
                 ████  ████    ██   ██    ██    ████   ██
   ██████████    ██ ████ ██    ███████    ██    ██ ██  ██
                 ██  ██  ██    ██   ██    ██    ██  ██ ██
                 ██      ██    ██   ██    ██    ██   ████
-}


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = updateWithCommands
        , subscriptions = subscriptions
        }



{-
                 ███    ███     ██████     ██████     ███████    ██
                 ████  ████    ██    ██    ██   ██    ██         ██
   ██████████    ██ ████ ██    ██    ██    ██   ██    █████      ██
                 ██  ██  ██    ██    ██    ██   ██    ██         ██
                 ██      ██     ██████     ██████     ███████    ███████
-}


type alias Model =
    { show : Bool, degrees : Int }


init : () -> ( Model, Cmd msg )
init _ =
    ( { show = False, degrees = 0 }, Cmd.none )



{-
                 ██    ██    ██████     ██████      █████     ████████    ███████
                 ██    ██    ██   ██    ██   ██    ██   ██       ██       ██
   ██████████    ██    ██    ██████     ██   ██    ███████       ██       █████
                 ██    ██    ██         ██   ██    ██   ██       ██       ██
                  ██████     ██         ██████     ██   ██       ██       ███████
-}


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 100 Rotate


type Msg
    = SayHi Bool
    | Rotate Time.Posix


update : Msg -> Model -> Model
update msg model =
    case msg of
        SayHi value ->
            { model | show = value }

        Rotate time ->
            { model | degrees = modBy 90 <| Time.posixToMillis time }


updateWithCommands : Msg -> Model -> ( Model, Cmd msg )
updateWithCommands msg model =
    ( update msg model, Cmd.none )



{-
                 ██    ██    ██    ███████    ██     ██
                 ██    ██    ██    ██         ██     ██
   ██████████    ██    ██    ██    █████      ██  █  ██
                  ██  ██     ██    ██         ██ ███ ██
                   ████      ██    ███████     ███ ███
-}


htmlIf : Html msg -> Bool -> Html msg
htmlIf el cond =
    if cond then
        el

    else
        text ""


getRotateStyleValue : Int -> String
getRotateStyleValue rotate =
    "rotate(" ++ String.fromInt rotate ++ "deg)"


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "align-items" "center"
        , style "padding" "4rem"
        , style "font-size" "30px"
        ]
        [ h1 [] [ text "Day 4" ]
        , div [ style "display" "flex", style "flex-direction" "row", style "align-items" "center" ]
            [ label [ for "say-hi" ] [ text "Say Hi!" ]
            , input
                [ style "height" "2rem"
                , style "width" "2rem"
                , id "say-hi"
                , type_ "checkbox"
                , onCheck SayHi
                , checked model.show
                ]
                []
            ]
        , htmlIf
            (div [ style "font-family" "monospace", style "font-size" "5rem", style "transform" <| getRotateStyleValue model.degrees ]
                [ text "👋" ]
            )
            model.show
        ]
