module Pages.Day19 exposing (..)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (Html, h1, p)
import Html.Events exposing (onInput)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Svg exposing (..)
import Svg.Attributes as SVGAttrs exposing (..)
import Task
import Time
import TimeZone


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


type alias TimeZoneAndName =
    { zone : Time.Zone, name : String }


type alias Model =
    ( ( TimeZoneAndName, TimeZoneAndName, TimeZoneAndName ), Time.Posix )


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( ( ( TimeZoneAndName (TimeZone.america__los_angeles ()) "America/Los Angeles"
        , TimeZoneAndName Time.utc ""
        , TimeZoneAndName (TimeZone.asia__tokyo ()) "Asia/Tokyo"
        )
      , Time.millisToPosix 0
      )
    , TimeZone.getZone |> Task.attempt AdjustTimeZone
    )


type Msg
    = Tick Time.Posix
    | AdjustTimeZone (Result TimeZone.Error ( String, Time.Zone ))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( zones, time ) =
    case msg of
        Tick newTime ->
            ( ( zones, newTime )
            , Cmd.none
            )

        AdjustTimeZone result ->
            let
                ( la, _, tk ) =
                    zones

                newZone =
                    case result of
                        Ok ( zoneName, zone ) ->
                            TimeZoneAndName
                                zone
                                zoneName

                        Err error ->
                            TimeZoneAndName
                                Time.utc
                                "UTC"
            in
            ( ( ( la, newZone, tk ), time )
            , Cmd.none
            )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick


clock : ( TimeZoneAndName, Time.Posix ) -> Element.Element Msg
clock ( { zone, name }, time ) =
    let
        hour =
            toFloat (Time.toHour zone time)

        minute =
            toFloat (Time.toMinute zone time)

        second =
            toFloat (Time.toSecond zone time)
    in
    Element.column [ Element.centerX, Font.size 15 ]
        [ Element.row [ Element.centerX ]
            [ Element.html <|
                svg
                    [ viewBox "0 0 200 200"
                    , width "200"
                    , height "200"
                    ]
                    [ defs
                        []
                        [ linearGradient
                            [ id "backgroundGradient"
                            ]
                            [ stop
                                [ offset "10%"
                                , stopColor "darkred"
                                ]
                                []
                            , stop
                                [ offset "80%"
                                , stopColor "midnightblue"
                                ]
                                []
                            ]
                        ]
                    , circle [ cx "100", cy "100", r "60", fill "url('#backgroundGradient')" ] []
                    , hand 6 40 (hour / 12) "white"
                    , hand 4 50 (minute / 60) "white"
                    , hand 2 50 (second / 60) "tomato"
                    ]
            ]
        , Element.row [ Element.centerX ] [ Element.text name ]
        ]


hand : Int -> Float -> Float -> String -> Svg msg
hand width length turns color =
    let
        t =
            2 * pi * (turns - 0.25)

        x =
            100 + length * cos t

        y =
            100 + length * sin t
    in
    line
        [ x1 "100"
        , y1 "100"
        , x2 (String.fromFloat x)
        , y2 (String.fromFloat y)
        , stroke color
        , strokeWidth (String.fromInt width)
        , strokeLinecap "round"
        ]
        []


view : Model -> Document Msg
view ( ( la, here, tk ), time ) =
    { title = "Day 19"
    , body =
        [ Element.column
            [ Element.centerX
            , Element.padding 40
            , Font.size 30
            ]
            [ Element.row [ Element.centerX ] [ Element.html <| h1 [] [ Html.text "Day 19" ] ]
            , Element.row []
                [ clock ( la, time )
                , clock ( here, time )
                , clock ( tk, time )
                ]
            ]
        ]
    }
