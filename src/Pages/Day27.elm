module Pages.Day27 exposing (Model, Msg, page)

import Colors.Opaque exposing (dimgray, grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border exposing (..)
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p, s)
import Html.Events exposing (onInput)
import Page exposing (Page)
import Ports
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
    { draft : String
    , messages : List String
    , status : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { draft = "", messages = [], status = False }, Cmd.none )


type Msg
    = DraftChanged String
    | Send
    | Connect
    | Disconnect
    | Recv String
    | StatusConnected Bool


buttonAttrs : List (Attribute msg)
buttonAttrs =
    [ Element.width fill
    , padding 10
    , spacing 10
    , Background.color Colors.Opaque.dodgerblue
    , Border.rounded 5
    , Font.size 20
    , Font.color Colors.Opaque.white
    , Border.shadow { offset = ( 2, 2 ), size = 1, blur = 5, color = dimgray }
    ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DraftChanged draft ->
            ( { model | draft = draft }
            , Cmd.none
            )

        Connect ->
            ( model, Ports.socketConnect () )

        Disconnect ->
            ( model, Ports.socketDisconnect () )

        Send ->
            ( { model | draft = "" }
            , Ports.socketSendMessage model.draft
            )

        StatusConnected status ->
            ( { model | status = status }, Cmd.none )

        Recv message ->
            ( { model | messages = model.messages ++ [ message ] }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch [ Ports.socketMessageReceiver Recv, Ports.socketStatusReceiver StatusConnected ]


view : Model -> View Msg
view model =
    { title = "Day27"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , height fill
                    , Element.width fill
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 27" ] ]
                    , row [ Element.height fill, Element.width fill ] [ webSocketEchoChat model ]
                    ]
    }


webSocketEchoChat : Model -> Element Msg
webSocketEchoChat model =
    column
        [ centerX
        , padding 40
        , Font.size 20
        , Element.width fill
        , Element.height fill
        , spacing 8
        ]
        [ row
            [ Element.width fill ]
            [ if model.status then
                button buttonAttrs
                    { onPress = Just Disconnect, label = Element.text "Disconnect" }

              else
                button
                    buttonAttrs
                    { onPress = Just Connect, label = Element.text "Connect" }
            ]
        , row [ Element.width fill, height fill ]
            [ column
                [ Element.width fill, height fill, Border.width 1, spacing 8, padding 8 ]
              <|
                List.map (\msg -> Element.text msg) model.messages
            ]
        , row [ Element.width fill, spacing 4 ]
            [ Input.text [ Element.width <| fillPortion 5 ]
                { onChange = DraftChanged
                , placeholder = Just (placeholder [] <| Element.text "Write here your message...")
                , label = labelLeft [] <| Element.text "Message"
                , text = model.draft
                }
            , button ((Element.width <| fillPortion 1) :: buttonAttrs)
                { onPress =
                    if model.status then
                        Just Send

                    else
                        Nothing
                , label = Element.text "Send"
                }
            ]
        ]
