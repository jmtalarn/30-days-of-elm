module Pages.Day6 exposing (Model, Msg, page)

-- import Debug

import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import Element.Font as Font
import Html exposing (input)
import Html.Attributes as HtmlAttributes
import Html.Events exposing (onInput)
import List exposing (foldl)
import Page
import ParseInt exposing (parseIntHex)
import Route exposing (Route)
import Shared
import String exposing (left, right, slice)
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


type Msg
    = ColorInputText String
    | BackgroundColorInputText String


type alias Model =
    { backgroundColor : String, fontColor : String }


init : ( Model, Cmd Msg )
init =
    ( { backgroundColor = "#FF5533", fontColor = "#F0F0F0" }, Cmd.none )


hexToRgb : String -> { red : Int, green : Int, blue : Int, alpha : Float }
hexToRgb color =
    let
        string =
            String.filter (\char -> char /= '#') color

        r =
            Result.withDefault 0 <| parseIntHex <| left 2 string

        g =
            Result.withDefault 0 <| parseIntHex <| slice 2 4 string

        b =
            Result.withDefault 0 <| parseIntHex <| right 2 string

        -- dummy =
        --     Debug.log "rgb" { r = r, g = g, gs = slice 2 4 string, b = b, string = string }
    in
    { red = r, green = g, blue = b, alpha = 1 }


luminance : String -> Float
luminance color =
    let
        rgb =
            hexToRgb color

        rgblist =
            List.map
                (\v ->
                    if v <= 0.03928 then
                        v / 12.92

                    else
                        ((v + 0.055) / 1.055) ^ 2.4
                )
            <|
                List.map (\v -> v / 255) <|
                    List.map toFloat [ rgb.red, rgb.green, rgb.blue ]
    in
    foldl (+) 0 <| List.map2 (*) rgblist [ 0.2126, 0.7152, 0.0722 ]


contrast : String -> String -> Float
contrast color1 color2 =
    let
        brightest =
            max (luminance color1) (luminance color2)

        darkest =
            min (luminance color1) (luminance color2)
    in
    (brightest + 0.05) / (darkest + 0.05)


checkcontrastvalid : String -> String -> Bool -> Basics.Bool
checkcontrastvalid color1 color2 isBig =
    let
        value =
            contrast color1 color2
    in
    if isBig then
        if value >= 3 then
            Basics.True

        else
            Basics.False

    else if value >= 4.5 then
        Basics.True

    else
        Basics.False


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ColorInputText color ->
            ( { model | fontColor = color }, Cmd.none )

        BackgroundColorInputText color ->
            ( { model | backgroundColor = color }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


elementIf : Element msg -> Bool -> Element msg
elementIf el cond =
    if cond then
        el

    else
        text ""


view : Model -> View Msg
view model =
    { title = "Day 6 "
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column [ width fill, height fill, Background.color <| fromRgb255 <| hexToRgb model.backgroundColor ]
                    [ row [ centerX, spacing 10, width fill, Font.size 30, padding 20, Font.extraBold, Font.color <| fromRgb255 <| hexToRgb model.fontColor ] [ Element.text "Day 6  -  Accessible constrast colors" ]
                    , row
                        [ centerX, padding 10, spacing 10, width fill ]
                        [ column [ padding 10, centerX, width (fill |> minimum 300), Font.color <| fromRgb255 <| hexToRgb model.fontColor ] [ Element.text "Pick a background color" ]
                        , column [ padding 10, centerX, width fill ]
                            [ Html.input
                                [ HtmlAttributes.style "height" "2rem"
                                , HtmlAttributes.style "width" "10rem"
                                , HtmlAttributes.style "text-align" "center"
                                , HtmlAttributes.id "pick-color"
                                , HtmlAttributes.type_ "color"
                                , onInput BackgroundColorInputText
                                , HtmlAttributes.value model.backgroundColor
                                ]
                                []
                                |> html
                            ]
                        ]
                    , row
                        [ centerX, padding 10, spacing 10, width fill ]
                        [ column [ padding 10, centerX, width (fill |> minimum 300), Font.color <| fromRgb255 <| hexToRgb model.fontColor ] [ Element.text "Pick a font color" ]
                        , column [ padding 10, centerX, width fill ]
                            [ Html.input
                                [ HtmlAttributes.style "height" "2rem"
                                , HtmlAttributes.style "width" "10rem"
                                , HtmlAttributes.style "text-align" "center"
                                , HtmlAttributes.id "pick-color"
                                , HtmlAttributes.type_ "color"
                                , onInput ColorInputText
                                , HtmlAttributes.value model.fontColor
                                ]
                                []
                                |> html
                            ]
                        ]
                    , row [ width fill ]
                        [ column []
                            [ Element.el [ Font.size 48, Font.color <| rgb255 128 255 170, width (fill |> minimum 50 |> maximum 50) ] <| elementIf (text "✓") <| checkcontrastvalid model.fontColor model.backgroundColor True ]
                        , column [ width fill ]
                            [ Element.el
                                [ height fill, centerX, centerY, Font.size 112, padding 20, Font.extraBold, Font.color <| fromRgb255 <| hexToRgb model.fontColor ]
                                (text "Hello !!")
                            ]
                        ]
                    , row [ width fill ]
                        [ column []
                            [ Element.el [ Font.size 48, Font.color <| rgb255 128 255 170, width (fill |> minimum 50 |> maximum 50) ] <| elementIf (text "✓") <| checkcontrastvalid model.fontColor model.backgroundColor False ]
                        , column [ width fill ]
                            [ paragraph
                                [ padding 10, height fill, Font.color <| fromRgb255 <| hexToRgb model.fontColor ]
                                [ Element.text "Et dolore pariatur laboris dolore sint. Laboris eu eu anim eu proident. Occaecat adipisicing tempor ullamco esse ad sint. Exercitation tempor reprehenderit amet ullamco non non ipsum sit esse Lorem. Nulla sit fugiat ut nisi ea aliquip consequat quis." ]
                            ]
                        ]
                    ]
    }
