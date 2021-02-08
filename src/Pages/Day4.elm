module Pages.Day4 exposing (..)

import Element exposing (html)
import Html exposing (Html, div, h1, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Time


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
    { show : Bool, degrees : Int }


init : Shared.Model -> Url params -> ( Model, Cmd msg )
init _ _ =
    ( { show = False, degrees = 0 }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 100 Rotate


type Msg
    = SayHi Bool
    | Rotate Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SayHi value ->
            ( { model | show = value }, Cmd.none )

        Rotate time ->
            ( { model | degrees = modBy 90 <| Time.posixToMillis time }, Cmd.none )


htmlIf : Html msg -> Bool -> Html msg
htmlIf el cond =
    if cond then
        el

    else
        text ""


getRotateStyleValue : Int -> String
getRotateStyleValue rotate =
    "rotate(" ++ String.fromInt rotate ++ "deg)"


view : Model -> Document Msg
view model =
    { title = "Day 4"
    , body =
        [ html <|
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
        ]
    }
