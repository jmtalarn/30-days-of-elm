module Day7 exposing (Model, init, main)

-- https://stackoverflow.com/a/41366859/4635829
--import Element.Input as Input

import Browser
import Colors.Opaque exposing (cyan, dimgray, fuchsia)
import Debug
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import List exposing (concat)



{-
                 ███    ███     █████     ██    ███    ██
                 ████  ████    ██   ██    ██    ████   ██
   ██████████    ██ ████ ██    ███████    ██    ██ ██  ██
                 ██  ██  ██    ██   ██    ██    ██  ██ ██
                 ██      ██    ██   ██    ██    ██   ████
-}


main : Program () Model Msg
main =
    Browser.element
        { subscriptions = subscriptions
        , update = update
        , view = view
        , init = init
        }


type Msg
    = NoOp



{-
                 ███    ███     ██████     ██████     ███████    ██
                 ████  ████    ██    ██    ██   ██    ██         ██
   ██████████    ██ ████ ██    ██    ██    ██   ██    █████      ██
                 ██  ██  ██    ██    ██    ██   ██    ██         ██
                 ██      ██     ██████     ██████     ███████    ███████
-}


type alias Model =
    { box1 : String, box2 : String, box3 : String }


init : a -> ( Model, Cmd msg )
init _ =
    ( { box1 = "Day 7", box2 = "Piling and centering boxes", box3 = "Proident et nisi ut duis id do qui sunt cillum consequat duis aliqua sit eiusmod. Culpa amet veniam eiusmod duis in mollit ex minim. Ullamco irure aute aliqua labore. Est laborum amet exercitation magna consequat enim quis." }, Cmd.none )



{-
                 ██    ██    ██████     ██████      █████     ████████    ███████
                 ██    ██    ██   ██    ██   ██    ██   ██       ██       ██
   ██████████    ██    ██    ██████     ██   ██    ███████       ██       █████
                 ██    ██    ██         ██   ██    ██   ██       ██       ██
                  ██████     ██         ██████     ██   ██       ██       ███████
-}


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )



{-
                 ███████    ██    ██    ██████     ███████     ██████    ██████     ██    ██████     ████████    ██     ██████     ███    ██    ███████
                 ██         ██    ██    ██   ██    ██         ██         ██   ██    ██    ██   ██       ██       ██    ██    ██    ████   ██    ██
   ██████████    ███████    ██    ██    ██████     ███████    ██         ██████     ██    ██████        ██       ██    ██    ██    ██ ██  ██    ███████
                      ██    ██    ██    ██   ██         ██    ██         ██   ██    ██    ██            ██       ██    ██    ██    ██  ██ ██         ██
                 ███████     ██████     ██████     ███████     ██████    ██   ██    ██    ██            ██       ██     ██████     ██   ████    ███████
-}


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



{-
                 ██    ██    ██    ███████    ██     ██
                 ██    ██    ██    ██         ██     ██
   ██████████    ██    ██    ██    █████      ██  █  ██
                  ██  ██     ██    ██         ██ ███ ██
                   ████      ██    ███████     ███ ███
-}


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
    [ centerX, padding 10, width shrink ]


view : Model -> Html Msg
view model =
    layout [] <|
        column [ centerX, centerY, spacing 100 ]
            [ row rowAttributes [ Element.el titleAttributes (Element.text model.box1) ]
            , row rowAttributes [ Element.el commonAttributes (Element.text model.box2) ]
            , row rowAttributes [ Element.paragraph paragraphAttributes [ Element.text model.box3 ] ]
            ]
