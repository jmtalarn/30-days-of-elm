module Pages.Day1 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1)
import Html.Events exposing (onInput)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import UI
import View exposing (View)


page : Page Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    Float


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


type Msg
    = Set Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Set value ->
            ( value, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> { title : String, body : List (Html.Html Msg) }
view model =
    { title = "Day 1"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 1" ] ]
                    , row []
                        [ Input.slider
                            [ Element.behindContent
                                (Element.el
                                    [ Element.width Element.fill
                                    , Element.height (Element.px 2)
                                    , Element.centerY
                                    , Background.color grey
                                    , Border.rounded 2
                                    ]
                                    Element.none
                                )
                            ]
                            { onChange = Set
                            , min = 0
                            , max = 100
                            , label =
                                Input.labelAbove []
                                    (Element.text "Slide to change the number")
                            , thumb = Input.defaultThumb
                            , step = Just 1
                            , value = model
                            }
                        ]
                    , row []
                        [ paragraph
                            [ Font.family [ Font.monospace ] ]
                            [ Element.text (String.fromFloat model) ]
                        ]
                    ]
    }
