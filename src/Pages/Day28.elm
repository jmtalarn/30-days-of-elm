module Pages.Day28 exposing (..)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Events exposing (onInput)
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


type alias Params =
    ()


type alias Model =
    Float


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( 0, Cmd.none )


type Msg
    = Set Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Set value ->
            ( value, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Document Msg
view model =
    { title = "Day1"
    , body =
        [ column
            [ centerX
            , padding 40
            , Font.size 30
            ]
            [ row [] [ html <| h1 [] [ Html.text "Day 28" ] ]
            , row [] [ html <| p [] [ Html.text "Nothing here yet for this day of challenge" ] ]
            ]
        ]
    }
