module Pages.Day18 exposing (..)

-- import Html.Attributes exposing (..)

import Animation exposing (deg, interrupt, px, to)
import Colors.Opaque exposing (grey)
import Date
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Attributes as HtmlAttributes
import Http
import Json.Decode exposing (Decoder, field, float, index, int, list, oneOf, string)
import Json.Decode.Extra exposing (datetime)
import Json.Decode.Pipeline exposing (optional, required)
import Loading as Loader
    exposing
        ( LoaderType(..)
        , defaultConfig
        , render
        )
import Material.Icons.Outlined as Outlined exposing (cake, card_giftcard, email, home, phone)
import Material.Icons.Types exposing (Coloring(..))
import Process exposing (sleep)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Task exposing (perform)
import Time exposing (utc)
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


type Response
    = Failure
    | Loading
    | Success RandomUser


type alias Name =
    { title : String
    , first : String
    , last : String
    }


type alias Street =
    { number : Int, name : String }


type alias Location =
    { street : Street
    , city : String
    , state : String
    , postcode : String
    , coordinates :
        Coordinates
    , timezone :
        TimeZone
    }


type alias Coordinates =
    { latitude : Float
    , longitude : Float
    }


type alias TimeZone =
    { offset : String
    , description : String
    }


type alias DateAndAge =
    { date : Time.Posix
    , age : Int
    }


type alias Picture =
    { large : String
    , medium : String
    , thumbnail : String
    }


type alias UserId =
    { name : String
    , value : String
    }


type alias RandomUser =
    { gender : String
    , name : Name
    , location : Location
    , email : String
    , dob : DateAndAge
    , registered : DateAndAge
    , phone : String
    , cell : String
    , id : UserId
    , picture : Picture
    }


type alias Model =
    ( Response, Animation.State )


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( ( Loading
      , Animation.style
            [ Animation.rotate3d (deg 0) (deg 0) (deg 0)
            ]
      )
    , getRandomUser
    )


type Msg
    = GotRandomUser (Result Http.Error RandomUser)
    | GetRandomUser
    | Animate Animation.Msg
    | StartFlip
    | EndFlip (Result Http.Error RandomUser)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( response, style ) =
    case msg of
        GotRandomUser result ->
            case result of
                Ok randomUser ->
                    let
                        newStyle =
                            Animation.interrupt
                                [ Animation.to
                                    [ Animation.rotate3d (deg 0) (deg 0) (deg 0)
                                    ]
                                ]
                                style
                    in
                    ( ( Success randomUser, newStyle ), Cmd.none )

                Err error ->
                    let
                        newStyle =
                            Animation.interrupt
                                [ Animation.to
                                    [ Animation.rotate3d (deg 0) (deg 0) (deg 0)
                                    ]
                                ]
                                style
                    in
                    ( ( Failure, newStyle ), Cmd.none )

        GetRandomUser ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.rotate3d (deg 0) (deg 180) (deg 0)
                            ]
                        ]
                        style
            in
            ( ( Loading, newStyle ), getRandomUser )

        Animate animMsg ->
            ( ( response, Animation.update animMsg style ), Cmd.none )

        EndFlip result ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.rotate3d (deg 0) (deg 90) (deg 0)
                            ]
                        ]
                        style
            in
            ( ( response, newStyle ), delay 500 (GotRandomUser result) )

        StartFlip ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.rotate3d (deg 0) (deg 90) (deg 0)
                            ]
                        ]
                        style
            in
            ( ( response, newStyle ), delay 500 GetRandomUser )


getRandomUser : Cmd Msg
getRandomUser =
    Http.get { url = "https://randomuser.me/api/", expect = Http.expectJson EndFlip randomUserDecoder }


delay : Float -> msg -> Cmd msg
delay time msg =
    sleep time |> Task.perform (\_ -> msg)


renderUserCard : RandomUser -> List (Element Msg)
renderUserCard user =
    [ column
        [ alignTop ]
        [ Element.image [ width <| Element.px 200, Border.rounded 500, clip, Border.width 1 ] { src = user.picture.large, description = "The avatar for this user" } ]
    , column
        [ alignTop
        , spacing 10
        , paddingXY 10 10
        , Font.size 20
        , width fill
        , alignRight
        , height fill
        ]
        [ Element.row [ Font.bold, alignRight ]
            [ Element.text (user.name.title ++ " " ++ user.name.first ++ " " ++ user.name.last) ]
        , Element.row [ alignRight ]
            [ Outlined.cake 24 Inherit |> html
            , Element.text <| Date.format "MMMM ddd" <| Date.fromPosix utc user.dob.date
            ]
        , Element.row [ alignRight ]
            [ Outlined.home 24 Inherit |> html
            , Element.text (String.fromInt user.location.street.number ++ ", " ++ user.location.street.name)
            ]
        , Element.row [ Font.italic, alignRight ]
            [ Element.text (user.location.postcode ++ ", " ++ user.location.state) ]
        , Element.row [ alignRight, alignBottom ]
            [ Outlined.phone 24 Inherit |> html
            , Element.text user.phone
            ]
        , Element.row [ alignRight, alignBottom ]
            [ Outlined.email 24 Inherit |> html
            , Element.text user.email
            ]
        , Element.row [ alignRight, alignBottom ]
            [ Outlined.card_giftcard 24 Inherit |> html
            , Element.text <| "Member since " ++ (Date.format "MMMM ddd, y" <| Date.fromPosix utc user.dob.date)
            ]
        ]
    ]


randomUserDecoder : Decoder RandomUser
randomUserDecoder =
    let
        floatDecoder =
            Json.Decode.string |> Json.Decode.andThen (String.toFloat >> Maybe.withDefault 0.0 >> Json.Decode.succeed)

        intDecoder =
            Json.Decode.int |> Json.Decode.andThen (String.fromInt >> Json.Decode.succeed)

        postCodeDecoder =
            oneOf [ string, intDecoder ]

        name =
            Json.Decode.succeed Name |> optional "title" string "" |> required "first" string |> required "last" string

        coordinates =
            Json.Decode.succeed Coordinates |> required "latitude" floatDecoder |> required "longitude" floatDecoder

        timezone =
            Json.Decode.succeed TimeZone |> required "offset" string |> required "description" string

        street =
            Json.Decode.succeed Street |> optional "number" int 0 |> optional "name" string ""

        location =
            Json.Decode.succeed Location |> required "street" street |> required "city" string |> required "state" string |> required "postcode" postCodeDecoder |> required "coordinates" coordinates |> required "timezone" timezone

        dateAndAge =
            Json.Decode.succeed DateAndAge |> required "date" datetime |> required "age" int

        userId =
            Json.Decode.succeed UserId |> required "name" string |> optional "value" string ""

        picture =
            Json.Decode.succeed Picture |> required "large" string |> required "medium" string |> required "thumbnail" string

        randomUser =
            Json.Decode.succeed RandomUser
                |> required "gender" string
                |> required "name" name
                |> required "location" location
                |> required "email" string
                |> required "dob" dateAndAge
                |> required "registered" dateAndAge
                |> required "phone" string
                |> required "cell" string
                |> required "id" userId
                |> required "picture" picture
    in
    field "results" (index 0 randomUser)


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions ( response, style ) =
    Animation.subscription Animate [ style ]


renderCardContent : Response -> List (Element Msg)
renderCardContent response =
    case response of
        Loading ->
            [ column
                [ Font.size 58, centerX ]
                [ Element.html <|
                    Loader.render BouncingBalls
                        { defaultConfig | size = 100, color = "#FF7F50" }
                        Loader.On
                ]
            ]

        Failure ->
            [ Element.paragraph [] [ Element.text "There was some error loading user data" ] ]

        Success randomUser ->
            renderUserCard randomUser


renderResult : Model -> Element Msg
renderResult ( response, style ) =
    column
        ([ width fill
         , htmlAttribute <| HtmlAttributes.style "cursor" "pointer"
         , Events.onClick StartFlip
         ]
            ++ (List.map Element.htmlAttribute <|
                    Animation.render style
               )
        )
        [ row
            [ spacing 10
            , padding 10
            , Border.rounded 20
            , Border.width 0
            , Border.shadow
                { offset = ( 10, 10 )
                , size = 10
                , blur = 20
                , color = Colors.Opaque.slategray
                }
            , width <| Element.px 600
            , height <| Element.px 300
            ]
            (renderCardContent response)
        ]


view : Model -> Document Msg
view model =
    { title = "Day 18"
    , body =
        [ column
            [ centerX
            , padding 40
            , Font.size 30
            ]
            [ row [] [ html <| h1 [] [ Html.text "Day 18" ] ]
            , row [] [ renderResult model ]
            ]
        ]
    }
