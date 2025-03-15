module Pages.Day15 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Alpha
import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (Html, h1, span)
import Html.Attributes as HtmlAttributes
import Html.Events exposing (onInput)
import Json.Decode exposing (Error)
import JsonTree exposing (KeyPath, Node, TaggedValue(..), parseString)
import Page
import Request exposing (Request)
import Result
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type Parsed
    = Node Node
    | Error String


type alias Model =
    ( String, Result Error Node, JsonTree.State )


init : ( Model, Cmd Msg )
init =
    ( ( "", Result.Ok (JsonTree.Node TNull ""), JsonTree.defaultState ), Cmd.none )


type Msg
    = SetText String
    | ParseText
    | SetTreeViewState JsonTree.State


jsonTreeConfig =
    { onSelect = Nothing, toMsg = SetTreeViewState, colors = JsonTree.defaultColors }


jsonParseAsTree : String -> Result Error Node
jsonParseAsTree treetext =
    parseString treetext


treeToView : Result error Node -> JsonTree.State -> Html Msg
treeToView parsed state =
    case parsed of
        Ok node ->
            JsonTree.view node jsonTreeConfig state

        Err error ->
            Html.text "Failed to parse JSON"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( text, parsed, treeState ) =
    case msg of
        SetText value ->
            ( ( value, parsed, treeState ), Cmd.none )

        ParseText ->
            ( ( text, jsonParseAsTree text, treeState ), Cmd.none )

        SetTreeViewState newTreeState ->
            ( ( text, parsed, newTreeState ), Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> View Msg
view model =
    let
        ( text, parsed, treeState ) =
            model
    in
    { title = "Day 15"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 20
                    , height fill
                    , width fill
                    ]
                    [ row [ centerX ] [ html <| h1 [] [ Html.text "Day 15" ] ]
                    , row [ width fill, height fill, spacing 50 ]
                        [ column [ width fill, height fill, spacing 15 ]
                            [ Input.multiline [ height (fill |> minimum 500), width fill, Font.extraLight ]
                                { onChange = SetText
                                , text = text
                                , placeholder = Just (Input.placeholder [] (Element.text "Just write here your text"))
                                , label =
                                    Input.labelAbove []
                                        (Element.text "Raw json text")
                                , spellcheck = False
                                }
                            , Input.button
                                [ width fill
                                , padding 20
                                , Background.color Colors.Opaque.lightsteelblue
                                , Border.shadow
                                    { blur = 5
                                    , color = Colors.Alpha.black 0.2
                                    , offset = ( 2, 2 )
                                    , size = 0
                                    }
                                , Border.rounded 5
                                , Font.center
                                , Font.color Colors.Opaque.blanchedalmond
                                , mouseOver
                                    [ Border.shadow
                                        { blur = 2
                                        , color = Colors.Alpha.black 0
                                        , offset = ( 2, 2 )
                                        , size = 0
                                        }
                                    ]
                                ]
                                { onPress = Just ParseText, label = Element.text "Press to parse 🔀" }
                            ]
                        , column [ width fill, alignTop, paddingXY 0 25, Font.extraLight ]
                            [ Element.html (treeToView parsed treeState) ]
                        ]
                    ]
    }
