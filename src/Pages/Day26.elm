module Pages.Day26 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Events exposing (onInput)
import Page
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


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


type Msg
    = ClickNumber Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        ClickNumber value ->
            let
                _ =
                    Debug.log "The number clicked is " value
            in
            ( value, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> View Msg
view model =
    { title = "Day1"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 20
                    , spacing 20
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 26" ] ]
                    , row [] [ paragraph [ spacing 15 ] [ Element.text "Check the logs, there is something there with a range of number from 1 to 20." ] ]
                    , row [] [ paragraph [ spacing 15 ] [ Element.text "Click on the numbers below to see the debug log" ] ]
                    , wrappedRow [ spacing 16 ] debugDemo
                    , row [ spacing 8 ] [ Element.text "This if from Debug.toString", Element.text (numbersRange |> Debug.toString) ]
                    ]
    }


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Border.widthEach { bottom = 2, left = 1, right = 2, top = 1 }
    , Border.color <| rgba 0 0 0 0.4
    , padding 6
    , width <| px 64
    , height <| px 64
    , Font.center
    , Border.rounded 100
    , mouseOver [ Background.color <| rgba 1 1 1 0.2 ]
    , focused [ Border.color <| rgba 0 0 0 0, Background.color <| rgba 1 1 1 0.2 ]
    , Font.size 32
    ]


numbersRange : List Int
numbersRange =
    List.range 1 20


debugDemo : List (Element Msg)
debugDemo =
    numbersRange
        |> List.map
            (\n ->
                let
                    _ =
                        Debug.log "The number is " n
                in
                button buttonAttrs
                    { onPress = Just <| ClickNumber n
                    , label = Element.text <| String.fromInt n
                    }
            )
