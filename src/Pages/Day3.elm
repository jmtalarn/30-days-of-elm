module Pages.Day3 exposing (Model, Msg, page)

import Browser
import Element exposing (html)
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (concat, repeat)
import Page
import Random
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


headsOrTails : Random.Generator Bool
headsOrTails =
    Random.weighted ( 50, True ) [ ( 50, False ) ]


randomArray10x10 : Random.Generator (List (List Bool))
randomArray10x10 =
    Random.list 10 (Random.list 10 headsOrTails)


type alias Model =
    List (List Bool)


init : ( Model, Cmd Msg )
init =
    ( repeat 10 <| repeat 10 <| True
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = Randomize
    | AssignNewModel Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Randomize ->
            ( model, Random.generate AssignNewModel randomArray10x10 )

        AssignNewModel newModel ->
            ( newModel, Cmd.none )


view : Model -> View Msg
view model =
    { title = "Day 3"
    , body =
        UI.layout <|
            div
                [ style "margin" "0 auto"
                , style "width" "80%"
                , style "max-width" "800px"
                , style "display" "flex"
                , style "flex-direction" "column"
                , style "align-items" "center"
                ]
                [ div
                    [ style "display" "inline-grid"
                    , style "grid-template-columns" "repeat(10, 2rem)"
                    , style "grid-template-rows" "repeat(10, 2rem)"
                    , style "gap" "1rem"
                    , style "font-size" "30px"
                    ]
                    (List.map
                        toCheckbox
                     <|
                        concat model
                    )
                , button
                    [ style "margin" "2rem"
                    , style "background-color" "dodgerblue"
                    , style "padding" "1rem"
                    , style "color" "white"
                    , style "font-size" "2rem"
                    , style "border" "none"
                    , style "border-radius" "4px"
                    , onClick Randomize
                    ]
                    [ text "Randomize it" ]
                ]
    }


toCheckbox : Bool -> Html msg
toCheckbox value =
    input
        [ type_ "checkbox"
        , style "width" "100%"
        , style "height" "100%"
        , checked value
        ]
        []
