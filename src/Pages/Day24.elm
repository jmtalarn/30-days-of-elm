module Pages.Day24 exposing (..)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, input, p)
import Html.Events exposing (onInput)
import Json.Decode
import Json.Encode
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


type alias Model =
    InputValue String


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( NoIdea, Cmd.none )


type InputValue a
    = Assured a
    | Doubtful Float a
    | NoIdea


inputValueToString : InputValue String -> String
inputValueToString inputValue =
    case inputValue of
        Assured anything ->
            "The input value is assured. It is something on it : " ++ anything ++ "."

        Doubtful num anything ->
            "The input is doubtful with a " ++ String.fromFloat num ++ "% of chances to be trusty. There is something on it : " ++ anything ++ "."

        NoIdea ->
            "The input is completely doubtful, it cannot be trusted at all."


type Msg
    = SetText String
    | SetTrust Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg iv =
    case msg of
        SetText value ->
            case iv of
                Assured _ ->
                    ( Assured value, Cmd.none )

                Doubtful num _ ->
                    ( Doubtful num value, Cmd.none )

                NoIdea ->
                    ( NoIdea, Cmd.none )

        SetTrust value ->
            let
                theText =
                    case iv of
                        Assured t ->
                            t

                        Doubtful _ t ->
                            t

                        NoIdea ->
                            ""
            in
            if value == 0 then
                ( NoIdea, Cmd.none )

            else if value == 100 then
                ( Assured theText, Cmd.none )

            else
                ( Doubtful value theText, Cmd.none )


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
        text =
            case model of
                Assured t ->
                    t

                Doubtful _ t ->
                    t

                NoIdea ->
                    ""

        trustLevel =
            case model of
                Assured _ ->
                    100.0

                Doubtful n _ ->
                    n

                NoIdea ->
                    0
    in
    { title = "Day 24"
    , body =
        [ column
            [ centerX
            , padding 40
            , Font.size 30
            ]
            [ row [ centerX ] [ html <| h1 [] [ Html.text "Day 24" ] ]
            , row [ spacing 60 ]
                [ column [ alignTop, spacing 20, width <| px 400 ]
                    [ Input.text
                        [ Font.extraLight, width fill ]
                        { onChange = SetText
                        , text = text
                        , placeholder = Just (Input.placeholder [] (Element.text "Write something here"))
                        , label =
                            Input.labelAbove []
                                (Element.text "This will send something")
                        }
                    , Input.slider
                        [ Element.behindContent
                            (Element.el
                                [ Element.width fill
                                , Element.height (Element.px 4)
                                , Element.centerY
                                , Background.color grey
                                , Border.rounded 2
                                ]
                                Element.none
                            )
                        ]
                        { onChange = SetTrust
                        , min = 0
                        , max = 100
                        , label =
                            Input.labelAbove []
                                (Element.text "Trustiness of the message")
                        , thumb = Input.defaultThumb
                        , step = Just 0.5
                        , value = trustLevel
                        }
                    ]
                , column [ alignTop, Font.extraLight, width <| px 400 ] [ Element.paragraph [] [ Element.text (inputValueToString model) ] ]
                ]
            ]
        ]
    }
