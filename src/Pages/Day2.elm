module Pages.Day2 exposing (Model, Msg, page)

import Element exposing (column, html)
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (..)
import Page exposing (Page)
import Route exposing (Route)
import Shared
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



{-
                 ███    ███     ██████     ██████     ███████    ██
                 ████  ████    ██    ██    ██   ██    ██         ██
   ██████████    ██ ████ ██    ██    ██    ██   ██    █████      ██
                 ██  ██  ██    ██    ██    ██   ██    ██         ██
                 ██      ██     ██████     ██████     ███████    ███████
-}


type alias Model =
    List String


init : ( Model, Cmd Msg )
init =
    ( [ "Alice", "Bob", "Chuck", "Me", "You", "They" ], Cmd.none )


type Msg
    = NoOp



--     = Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> View Msg
view model =
    { title = "Day 2"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column []
                    [ div
                        [ style "display" "flex"
                        , style "flex-direction" "row"
                        , style "flex-wrap" "wrap"
                        , style "align-items" "center"
                        , style "padding" "4rem"
                        , style "font-size" "30px"
                        ]
                        (List.map transformToParagraph model)
                        |> html
                    ]
    }


transformToParagraph : String -> Html msg
transformToParagraph item =
    p
        [ style "font-family" "sans-serif"
        , style "padding" "1rem"
        , style "margin" "1rem"
        , style "border" "1px dotted crimson"
        ]
        [ text item ]
