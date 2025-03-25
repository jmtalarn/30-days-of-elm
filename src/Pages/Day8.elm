module Pages.Day8 exposing (Model, Msg, page)

import Browser
import Colors.Opaque exposing (cyan, dimgray, fuchsia)
import Dict exposing (fromList, get)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import List exposing (concat)
import Maybe
import Page
import Request exposing (Request)
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared req =
    Page.element
        { init = init shared req.query
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type Msg
    = Set String String


type alias Params =
    { name : String, age : String, location : String }


type alias Model =
    List ( String, String )


init : Shared.Model -> Dict.Dict String String -> ( Model, Cmd msg )
init _ query =
    let
        name =
            Maybe.withDefault "" <| Dict.get "name" query

        age =
            Maybe.withDefault "" <| Dict.get "age" query

        location =
            Maybe.withDefault "" <| Dict.get "location" query
    in
    ( [ ( "name", name ), ( "age", age ), ( "location", location ) ], Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        dict =
            Dict.fromList model
    in
    case msg of
        Set field value ->
            ( Dict.toList <| Dict.insert field value dict, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


commonAttributes : List (Attribute msg)
commonAttributes =
    [ Background.gradient { angle = 60, steps = [ cyan, fuchsia ] }
    , padding 20
    , Border.rounded 10
    , Border.shadow { offset = ( 5, 5 ), size = 10, blur = 25, color = dimgray }
    ]


paragraphAttributes : List (Attribute msg)
paragraphAttributes =
    concat [ commonAttributes, [ Font.justify, Font.hairline, width (fill |> maximum 500) ] ]


titleAttributes : List (Attribute msg)
titleAttributes =
    concat [ commonAttributes, [ Font.extraBold, Font.size 62 ] ]


rowAttributes : List (Attribute msg)
rowAttributes =
    [ centerX, padding 10, width fill ]


buildUrl : Model -> String
buildUrl model =
    let
        dict =
            Dict.fromList model
    in
    String.concat [ "?name=", Maybe.withDefault "" <| get "name" dict, "&age=", Maybe.withDefault "" <| get "age" dict, "&location=", Maybe.withDefault "" <| get "location" dict ]


form : Model -> List (Element Msg)
form model =
    let
        dict =
            Dict.fromList model

        name =
            Maybe.withDefault "" <| get "name" dict

        age =
            Maybe.withDefault "" <| get "age" dict

        location =
            Maybe.withDefault "" <| get "location" dict
    in
    [ column [ spacing 15, width fill ]
        [ row [ width fill ]
            [ Input.text
                []
                { onChange = Set "name"
                , text = name
                , placeholder = Just (Input.placeholder [] (Element.text "Write the name here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Write the name here")
                }
            ]
        , row [ width fill ]
            [ Input.text
                []
                { onChange = Set "age"
                , text = age
                , placeholder = Just (Input.placeholder [] (Element.text "Write the age here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Write the age here")
                }
            ]
        , row [ width fill ]
            [ Input.text
                []
                { onChange = Set "location"
                , text = location
                , placeholder = Just (Input.placeholder [] (Element.text "Write the location here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Write the location here")
                }
            ]
        ]
    ]


view : Model -> View Msg
view model =
    let
        dict =
            Dict.fromList model

        name =
            Maybe.withDefault "" <| get "name" dict

        age =
            Maybe.withDefault "" <| get "age" dict

        location =
            Maybe.withDefault "" <| get "location" dict
    in
    { title = "Day 8"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column [ centerX, centerY, width fill, padding 50, spacing 50, width (fill |> maximum 1200) ]
                    [ row
                        (rowAttributes ++ commonAttributes)
                        [ Element.paragraph
                            []
                            [ text "Hello! Greetings from ", text location, text ". My name is ", text name, text " and I'm ", text age, text " years old." ]
                        ]
                    , row
                        rowAttributes
                        [ column [ width <| fillPortion 2 ] <| form model
                        , column [ width <| fillPortion 3, padding 20, alignTop ]
                            [ paragraph [ htmlAttribute <| Html.Attributes.style "word-break" "break-all" ]
                                [ Element.text "Click the following link in order to reload page and use the query parameters in the model"
                                , Element.link
                                    [ Font.color Colors.Opaque.cornflowerblue
                                    , Border.color Colors.Opaque.cornflowerblue
                                    , Border.dashed
                                    , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                                    , mouseOver [ Border.glow Colors.Opaque.cornflowerblue 2 ]
                                    ]
                                    { url = buildUrl model
                                    , label = text <| buildUrl model
                                    }
                                ]
                            ]
                        ]
                    ]
    }
