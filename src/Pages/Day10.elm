module Pages.Day10 exposing (..)

import Browser.Dom exposing (getElement)
import Browser.Events exposing (onMouseMove)
import Element exposing (..)
import Element.Font as Font exposing (center, size)
import Html exposing (h1)
import Html.Attributes as HtmlAttributes exposing (id)
import Html.Events exposing (onInput)
import Json.Decode as Decode
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Svg.Attributes exposing (result)
import Task
import Tuple exposing (first, second)


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
    { mousePosition : ( Int, Int ), rootXY : ( ( Int, Int ), ( Int, Int ) ) }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { mousePosition = ( 0, 0 ), rootXY = ( ( 0, 0 ), ( 0, 0 ) ) }, getRootXY )


type Msg
    = Set Int Int
    | GotRootXY (Result Browser.Dom.Error Browser.Dom.Element)


getRootXY : Cmd Msg
getRootXY =
    Task.attempt GotRootXY <| getElement "the_element"


relativeToRoot : ( Int, Int ) -> ( ( Int, Int ), ( Int, Int ) ) -> ( Int, Int )
relativeToRoot ( x, y ) ( ( rootX, rootY ), ( finalX, finalY ) ) =
    if x < rootX || y < rootY || x > finalX || y > finalY then
        ( 0, 0 )

    else
        ( x - rootX, y - rootY )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Set x y ->
            ( { model | mousePosition = relativeToRoot ( x, y ) model.rootXY }
            , Cmd.none
            )

        GotRootXY result ->
            case result of
                Ok { element } ->
                    ( { model
                        | rootXY =
                            ( ( round element.x, round element.y )
                            , ( round (element.x + element.width), round (element.y + element.height) )
                            )
                      }
                    , Cmd.none
                    )

                Err error ->
                    ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    onMouseMove
        (Decode.map2 Set
            (Decode.field "pageX" Decode.int)
            (Decode.field "pageY" Decode.int)
        )


view : Model -> Document Msg
view { mousePosition } =
    { title = "Day 10"
    , body =
        [ column
            [ centerX
            , padding 40
            , Font.size 30
            , width fill
            , htmlAttribute <| HtmlAttributes.id "the_element"
            , htmlAttribute <| HtmlAttributes.style "cursor" "crosshair"
            ]
            [ row [ centerX ] [ html <| h1 [] [ Html.text "Mouse coordinates" ] ]
            , row [ width fill, centerX ] [ paragraph [ Font.center ] [ Element.text <| String.fromInt <| first mousePosition, Element.text " , ", Element.text <| String.fromInt <| second mousePosition ] ]
            ]
        ]
    }
