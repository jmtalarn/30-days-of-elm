module Pages.Day9 exposing (..)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Debug
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Attributes as HtmlAttributes
import Html.Events exposing (onInput)
import Http
import Json.Decode exposing (Decoder, bool, decodeString, field, float, index, list, string)
import List exposing (sortBy)
import Maybe
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Task
import Time exposing (Month(..), Posix, toDay, toMonth, toYear, utc)


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


type Response
    = Failure
    | Loading
    | Success (List Asteroid)


type alias Model =
    { response : Response, date : String, nasaApiKey : String }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( Model Loading "" shared.nasaApiKey, now )


type alias Asteroid =
    { name : String, size : Float, hazardous : Bool, distance : Float, time : String }


type Msg
    = GotAsteroids (Result Http.Error (List Asteroid))
    | SetDate String
    | SetNowToDate Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotAsteroids result ->
            case result of
                Ok asteroids ->
                    let
                        _ =
                            Debug.log "asteroids" asteroids
                    in
                    ( { model | response = Success asteroids }, Cmd.none )

                Err error ->
                    let
                        _ =
                            Debug.log "error" error
                    in
                    ( { model | response = Failure }, Cmd.none )

        SetNowToDate date ->
            let
                _ =
                    Debug.log "SetNowToDate" formatDate <| date
            in
            ( { model | date = formatDate <| date }, getAsteroids model )

        SetDate date ->
            let
                _ =
                    Debug.log "SetDate" date
            in
            ( { model | date = date }, getAsteroids model )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getPaddingLeft : List Asteroid -> Asteroid -> Int
getPaddingLeft asteroids asteroid =
    let
        max =
            Maybe.withDefault 500 <| List.maximum (List.map .distance asteroids)

        min =
            Maybe.withDefault 0 <| List.minimum (List.map .distance asteroids)

        a =
            0

        b =
            500
    in
    round <| (((b - a) * (asteroid.distance - min)) / (max - min) + a)


view : Model -> Document Msg
view model =
    { title = "Day 9"
    , body =
        [ column
            [ paddingXY 40 0
            , Font.size 20
            , Element.width Element.fill
            ]
            [ row
                [ Element.width Element.fill, spaceEvenly ]
                [ html <| h1 [] [ Html.text "Close asteroids" ], datepicker model ]
            , row [ Element.width Element.fill ]
                [ column [ Element.width <| fillPortion 1 ] [ Element.image [ Element.width <| px 100 ] { src = "/30-days-of-elm/images/earth-clip-rotating-17.gif", description = "Image of a rotating Earth planet." } ]
                , column [ Element.width <| fillPortion 5 ]
                    [ column [ Element.spacing 10, Border.dashed, Border.color Colors.Opaque.deepskyblue, Border.widthEach { bottom = 0, left = 2, right = 0, top = 0 } ] (renderResult model.response)
                    ]
                ]
            ]
        ]
    }


stringIf : String -> Bool -> String
stringIf el cond =
    if cond then
        el

    else
        ""


renderAsteroidSVG : List Asteroid -> Asteroid -> Element Msg
renderAsteroidSVG asteroids asteroid =
    let
        max =
            Maybe.withDefault 100 <| List.maximum (List.map .size asteroids)

        min =
            Maybe.withDefault 5 <| List.minimum (List.map .size asteroids)

        a =
            5

        b =
            100

        widthValue =
            ((b - a) * (asteroid.size - min)) / (max - min) + a

        radius =
            String.fromFloat <| (widthValue / 2)

        width =
            String.fromFloat <| widthValue
    in
    Element.html <|
        svg
            [ Svg.Attributes.width width
            , Svg.Attributes.height width
            , Svg.Attributes.viewBox ("0 0 " ++ width ++ " " ++ width)
            ]
            [ Svg.circle
                [ Svg.Attributes.cx radius
                , Svg.Attributes.cy radius
                , Svg.Attributes.r radius
                ]
                []
            ]


renderAsteroid : List Asteroid -> Asteroid -> Element Msg
renderAsteroid asteroids asteroid =
    row [ Element.width Element.fill, paddingEach { top = 0, right = 0, bottom = 0, left = getPaddingLeft asteroids asteroid } ]
        [ column [] [ renderAsteroidSVG asteroids asteroid ]
        , column [ Font.size 12, padding 4, Element.width <| px 200 ]
            [ row [ Font.size 20, Font.extraBold ] [ Element.text (asteroid.name ++ stringIf "☢️" asteroid.hazardous) ]
            , row [] [ Element.text <| (String.fromFloat <| round3decimals <| asteroid.size) ++ " Km  ⌀" ]
            , row [] [ Element.text <| ((String.fromFloat <| round3decimals <| asteroid.distance) ++ " Km  🔭") ]
            ]
        ]


renderResult : Response -> List (Element Msg)
renderResult response =
    case response of
        Loading ->
            [ Element.text "Loading ☄️ ... " ]

        Failure ->
            [ Element.text "Failure loading data 💥" ]

        Success asteroids ->
            List.map (renderAsteroid asteroids) (sortBy .distance asteroids)


getAsteroids : Model -> Cmd Msg
getAsteroids model =
    Http.get { url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=" ++ model.date ++ "&end_date=" ++ model.date ++ "&api_key=" ++ model.nasaApiKey, expect = Http.expectJson GotAsteroids asteroidsDecoder }


round3decimals : Float -> Basics.Float
round3decimals float =
    toFloat (round (float * 1000.0)) / 1000


floatDecoder : Decoder Float
floatDecoder =
    Json.Decode.string |> Json.Decode.andThen (String.toFloat >> Maybe.withDefault 0.0 >> Json.Decode.succeed)


asteroidDecoder : Decoder Asteroid
asteroidDecoder =
    Json.Decode.map5 Asteroid
        (field "name" Json.Decode.string)
        (field "estimated_diameter" (field "kilometers" (field "estimated_diameter_max" float)))
        (field "is_potentially_hazardous_asteroid" bool)
        (field "close_approach_data" (index 0 (field "miss_distance" (field "kilometers" floatDecoder))))
        (field "close_approach_data" (index 0 (field "close_approach_date_full" Json.Decode.string)))



-- { name: String, size: String, hazardous: Bool, distance: String, time: String}
--


asteroidsDecoder : Decoder (List Asteroid)
asteroidsDecoder =
    --  field "near_earth_objects" (field "2015-09-07" (list asteroidDecoder))
    field "near_earth_objects" dateKeyAsteroidsDecoder


dateKeyAsteroidsDecoder =
    let
        result pair =
            case pair of
                Just ( _, asteroids ) ->
                    Json.Decode.succeed asteroids

                Nothing ->
                    Json.Decode.fail ""
    in
    Json.Decode.keyValuePairs (list asteroidDecoder) |> Json.Decode.andThen (List.head >> result)


datepicker : Model -> Element Msg
datepicker model =
    Html.input
        [ HtmlAttributes.style "height" "2rem"
        , HtmlAttributes.style "width" "10rem"
        , HtmlAttributes.style "text-align" "center"
        , HtmlAttributes.id "pick-color"
        , HtmlAttributes.type_ "date"
        , onInput SetDate
        , HtmlAttributes.value model.date
        ]
        []
        |> html


toNumberMonth : Time.Month -> String
toNumberMonth month =
    case month of
        Jan ->
            "01"

        Feb ->
            "02"

        Mar ->
            "03"

        Apr ->
            "04"

        May ->
            "05"

        Jun ->
            "06"

        Jul ->
            "07"

        Aug ->
            "08"

        Sep ->
            "09"

        Oct ->
            "10"

        Nov ->
            "11"

        Dec ->
            "12"


formatDate : Time.Posix -> String
formatDate time =
    String.fromInt (toYear utc time)
        ++ "-"
        ++ toNumberMonth (toMonth utc time)
        ++ "-"
        ++ String.fromInt (toDay utc time)


now : Cmd Msg
now =
    Task.perform SetNowToDate Time.now
