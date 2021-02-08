module Pages.Day2 exposing (..)

import Element exposing (column, html)
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (..)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)


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



{-
                 ███    ███     ██████     ██████     ███████    ██
                 ████  ████    ██    ██    ██   ██    ██         ██
   ██████████    ██ ████ ██    ██    ██    ██   ██    █████      ██
                 ██  ██  ██    ██    ██    ██   ██    ██         ██
                 ██      ██     ██████     ██████     ███████    ███████
-}


type alias Params =
    ()


type alias Model =
    List String


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init _ _ =
    ( [ "Alice", "Bob", "Chuck", "Me", "You", "They" ], Cmd.none )


type Msg
    = NoOp



--     = Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load _ model =
    ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Day 2"
    , body =
        [ column []
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
