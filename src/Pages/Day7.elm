module Pages.Day7 exposing (Model, Msg, page)

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


type Msg
    = NoOp


type alias Model =
    { box1 : String, box2 : String, box3 : String }


init : ( Model, Cmd Msg )
init =
    ( { box1 = "Day 7", box2 = "Piling and centering boxes", box3 = "Proident et nisi ut duis id do qui sunt cillum consequat duis aliqua sit eiusmod. Culpa amet veniam eiusmod duis in mollit ex minim. Ullamco irure aute aliqua labore. Est laborum amet exercitation magna consequat enim quis." }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
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
    [ centerX, padding 10, width shrink ]


view : Model -> View Msg
view model =
    { title = "Day 7"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column [ centerX, centerY, spacing 100 ]
                    [ row rowAttributes [ Element.el titleAttributes (Element.text model.box1) ]
                    , row rowAttributes [ Element.el commonAttributes (Element.text model.box2) ]
                    , row rowAttributes [ Element.paragraph paragraphAttributes [ Element.text model.box3 ] ]
                    ]
    }
