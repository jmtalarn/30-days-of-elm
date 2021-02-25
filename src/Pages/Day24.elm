module Pages.Day24 exposing (..)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input exposing (..)
import Html exposing (h1, h3)
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
            "The input value is assured. You can be sure this message is true : " ++ anything ++ "."

        Doubtful num anything ->
            "The input is doubtful with a " ++ String.fromFloat num ++ "% of chances to be trusty. This is the message : " ++ anything ++ "."

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
            , spacing 40
            ]
            [ row [ centerX ] [ html <| h1 [] [ Html.text "Day 24" ] ]
            , row [ spacing 60, centerX ]
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
            , row [ width <| fillPortion 2 ] [ html <| h3 [] [ Html.text "Fix this `List`" ] ]
            , row [ spacing 20 ]
                [ textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Border.width 1, Border.color Colors.Opaque.crimson, Border.dashed ]
                    [ Element.paragraph []
                        [ Element.text <| """fixThis : List a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis = [ "hello", "world" ]""" ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                , textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Font.color Colors.Opaque.gray ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : List a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis = [ ]""" ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis ++ ["hello" ,"world" ] """ ]
                    ]
                ]
            , row [ width <| fillPortion 2 ] [ html <| h3 [] [ Html.text "Fix this `Maybe`" ] ]
            , row [ spacing 20 ]
                [ textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Border.width 1, Border.color Colors.Opaque.crimson, Border.dashed ]
                    [ Element.paragraph []
                        [ Element.text <| """fixThis : Maybe a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis = Just "hello" """ ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                , textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Font.color Colors.Opaque.gray ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Maybe a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis = Nothing """ ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| (Maybe.withDefault "" fixThis) ++ "Hello" """ ]
                    ]
                ]
            , row [ width <| fillPortion 2 ] [ html <| h3 [] [ Html.text "Fix this `Html`" ] ]
            , row [ spacing 20 ]
                [ textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Border.width 1, Border.color Colors.Opaque.crimson, Border.dashed ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis =""" ]
                    , Element.paragraph [] [ Element.text <| """    div [ onClick "hello" ] []""" ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                , textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Font.color Colors.Opaque.gray ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis =""" ]
                    , Element.paragraph [] [ Element.text <| """    div [] []""" ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                ]
            , row [ width <| fillPortion 2 ] [ html <| h3 [] [ Html.text "Fix this `Result 1`" ] ]
            , row [ spacing 20 ]
                [ textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Border.width 1, Border.color Colors.Opaque.crimson, Border.dashed ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Result String a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis =""" ]
                    , Element.paragraph [] [ Element.text <| """    Ok "hello" """ ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                , textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Font.color Colors.Opaque.gray ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Result String a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis =""" ]
                    , Element.paragraph [] [ Element.text <| """    Err "hello" """ ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                ]
            , row [ width <| fillPortion 2 ] [ html <| h3 [] [ Html.text "Fix this `Result 2`" ] ]
            , row [ spacing 20 ]
                [ textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Border.width 1, Border.color Colors.Opaque.crimson, Border.dashed ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Result a String""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis =""" ]
                    , Element.paragraph [] [ Element.text <| """    Err "error" """ ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                , textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Font.color Colors.Opaque.gray ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : Result a String""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis =""" ]
                    , Element.paragraph [] [ Element.text <| """    Ok "hello" """ ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                ]
            , row [ width <| fillPortion 2 ] [ html <| h3 [] [ Html.text "Fix this `Function`" ] ]
            , row [ spacing 20 ]
                [ textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Border.width 1, Border.color Colors.Opaque.crimson, Border.dashed ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : a -> a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis arg =""" ]
                    , Element.paragraph [] [ Element.text <| """    String.toUpper arg""" ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                , textColumn [ alignTop, spacing 10, padding 5, width <| px 600, Font.family [ Font.monospace ], Font.size 20, Font.color Colors.Opaque.gray ]
                    [ Element.paragraph [] [ Element.text <| """fixThis : a -> a""" ]
                    , Element.paragraph [] [ Element.text <| """fixThis arg = arg""" ]
                    , Element.paragraph [] [ Element.text <| """ """ ]
                    , Element.paragraph [] [ Element.text <| """main : Html a""" ]
                    , Element.paragraph [] [ Element.text <| """main =""" ]
                    , Element.paragraph [] [ Element.text <| """    Html.text <| Debug.toString <| fixThis """ ]
                    ]
                ]
            ]
        ]
    }
