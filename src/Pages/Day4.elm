module Pages.Day4 exposing (Model, Msg, page)

import Element exposing (html)
import Html exposing (Html, div, h1, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
import Page
import Route exposing (Route)
import Shared
import Time
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


type alias Model =
    { show : Bool, degrees : Int }


init : ( Model, Cmd Msg )
init =
    ( { show = False, degrees = 0 }, Cmd.none )


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


view : Model -> View Msg
view model =
    { title = "Day 4"
    , body =
        UI.layout <|
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
    }
