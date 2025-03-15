module Pages.Day29 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Events exposing (onInput)
import Json.Decode as Decode
import Page
import Pages.Home_ exposing (view)
import Request exposing (Request)
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


type alias Model =
    { list : List String
    , text : String
    }


init : ( Model, Cmd Msg )
init =
    ( { list = [], text = "" }, Cmd.none )


type Msg
    = AddItem String
    | RemoveItem String
    | DraftItem String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddItem value ->
            ( { model | list = model.list ++ [ value ], text = "" }, Cmd.none )

        RemoveItem value ->
            ( { model | list = List.filter (\x -> x /= value) model.list }, Cmd.none )

        DraftItem value ->
            ( { model | text = value }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


listConstructor : Model -> Element Msg
listConstructor model =
    let
        onEnter : msg -> Element.Attribute msg
        onEnter msg =
            Element.htmlAttribute
                (Html.Events.on "keyup"
                    (Decode.field "key" Decode.string
                        |> Decode.andThen
                            (\key ->
                                if key == "Enter" then
                                    Decode.succeed msg

                                else
                                    Decode.fail "Not the enter key"
                            )
                    )
                )
    in
    column []
        (row [ width fill ]
            [ Input.text
                [ onEnter <| AddItem model.text ]
                { placeholder = Just (Input.placeholder [] (Element.text "Add Item"))
                , onChange = DraftItem
                , label = Input.labelHidden "New Item"
                , text = model.text
                }
            , Element.text "↵"
            ]
            :: List.map
                (\x ->
                    row
                        [ width fill ]
                        [ Element.text x
                        , button []
                            { onPress = Just <| RemoveItem x
                            , label = Element.text "🚮"
                            }
                        ]
                )
                model.list
        )


view : Model -> View Msg
view model =
    { title = "Day29"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    , width fill
                    ]
                    [ row [ centerX ] [ html <| h1 [] [ Html.text "Day 29" ] ]
                    , row [ width fill, spacing 16 ]
                        [ column [ width <| fillPortion 3 ] [ listConstructor model ]
                        , column [ width <| fillPortion 3 ] [ Element.text "Col2" ]
                        , column [ width <| fillPortion 3 ] [ Element.text "Col3" ]
                        ]
                    ]
    }
