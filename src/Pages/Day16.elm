module Pages.Day16 exposing (..)

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
import Json.Decode as Decode exposing (Decoder, Error, oneOf, string)
import Json.Decode.Pipeline exposing (required)
import Result
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


type Parsed
    = User String String String
    | Book String String String
    | Nothing



-- type alias User =
--     { id : String, name : String, email : String }
-- type alias Book =
--     { ean : String, title : String, author : String }


userDecoder : Decoder Parsed
userDecoder =
    Decode.succeed User |> required "id" string |> required "name" string |> required "email" string


bookDecoder : Decoder Parsed
bookDecoder =
    Decode.succeed Book |> required "ean" string |> required "title" string |> required "author" string


textDecoder : Decoder Parsed
textDecoder =
    oneOf
        [ userDecoder
        , bookDecoder
        ]


type alias Model =
    ( String, Parsed )


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( ( "", Nothing ), Cmd.none )


type Msg
    = SetText String
    | ParseText


printParsed : Parsed -> String
printParsed parsed =
    case parsed of
        Book ean title author ->
            "This is a Book, with ean " ++ ean ++ " titled " ++ title ++ " writen by " ++ author

        User id name email ->
            "This is a User with an id " ++ id ++ " called " ++ name ++ " and you can email him/her to " ++ email

        Nothing ->
            "This is NOTHING I can decode, parse and show."


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( text, parsed ) =
    case msg of
        SetText value ->
            ( ( value, parsed ), Cmd.none )

        ParseText ->
            ( ( text, parseText text ), Cmd.none )


parseText : String -> Parsed
parseText text =
    case Decode.decodeString textDecoder text of
        Ok result ->
            result

        Err _ ->
            Nothing


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
    let
        ( text, parsed ) =
            model
    in
    { title = "Day 16"
    , body =
        [ column
            [ centerX
            , padding 40
            , Font.size 20
            , height fill
            , width fill
            ]
            [ row [ centerX ] [ html <| h1 [] [ Html.text "Day 16" ] ]
            , row [ width fill, height fill, spacing 50 ]
                [ column [ width fill, height fill, spacing 16 ]
                    [ Input.multiline [ height (fill |> minimum 500), width fill, Font.extraLight ]
                        { onChange = SetText
                        , text = text
                        , placeholder =
                            Just
                                (Input.placeholder
                                    []
                                    (Element.text """There are just two valid Json structures to parse: 
                     
                                       A User which has this shape {"id": String, "name": String, "email": String } or a Book which has the following shape { "ean": String, "title": String, "author": String }
                                        """)
                                )
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
                , column [ width fill, height fill, alignTop, paddingXY 0 25, Font.extraLight ]
                    [ Element.paragraph
                        [ height (fillPortion 6) ]
                        [ Element.text <| printParsed <| parsed ]
                    , Element.paragraph
                        [ Font.bold, height (fillPortion 1) ]
                        [ Element.text "Psst! There is a hint here to copy and paste..." ]
                    , Element.paragraph
                        [ Font.family [ Font.monospace ], Font.extraLight, height (fillPortion 1) ]
                        [ Element.text """The following for a user {"id": String, "name": String, "email": String } and this for a book { "ean": String, "title": String, "author": String } """ ]
                    ]
                ]
            ]
        ]
    }
