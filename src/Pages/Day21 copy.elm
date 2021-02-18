module Pages.Day21 exposing (..)

import Element
import Element.Font as Font exposing (size)
import Html exposing (Html, h1)
import Html.Attributes
import Shared
import Simple.Animated as Animated
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time


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
    ( List Planet, Int )


type alias Planet =
    { name : String
    , texture : String
    , orbitalPeriod : Float
    , rotationalPeriod : Float
    , size : Float
    , distance : Float
    }


planetsList : List Planet
planetsList =
    [ Planet "Mercury" "gray" 58.7 (0.967 + 87) 4880 57910000
    , Planet "Venus" "yellow" 224.7 243 12104 108200000
    , Planet "Earth" "blue" 365.25 1 12756 149600000
    , Planet "Mars" "red" 686.97 1.025 6794 227940000
    , Planet "Saturn" "orange" ((29 * 365) + 167 + 0.28) 0.416 108728 1429400000
    , Planet "Jupiter" "gold" ((11 * 365) + 315 + 0.05) 0.4135 142984 778330000
    , Planet "Uranus" "lightblue" (84.32 * 365) 0.708 51118 2870990000
    , Planet "Neptune" "blue" ((164 * 365) + 288 + 0.54) 0.666 49532 4504300000
    , Planet "Pluto" "beige" ((248 * 365) + 197 + 0.23) 6.375 2320 5913520000
    ]


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( ( planetsList, 1 ), Cmd.none )


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick


view : Model -> Document Msg
view ( planets, amisteriousnumber ) =
    { title = "Day 21"
    , body =
        [ Element.column
            [ Element.centerX
            , Element.padding 10
            , Font.size 30
            ]
            [ Element.row [ Element.centerX ] [ Element.html <| h1 [] [ Html.text "Planets obsession" ] ]
            , Element.row []
                [ Element.html <| drawSolarSystem planets ]
            ]
        ]
    }


orbitScale : Float
orbitScale =
    5000000.0


biggestPlanet =
    Maybe.withDefault 500 <| List.maximum (List.map .size planetsList)


largestDistance =
    Maybe.withDefault 1500 <| List.maximum (List.map .distance planetsList)


smallestPlanet =
    Maybe.withDefault 10 <| List.minimum (List.map .size planetsList)


shortestDistance =
    Maybe.withDefault 10 <| List.minimum (List.map .distance planetsList)


minWidth =
    20


maxWidth =
    100


minOrbit =
    200


maxOrbit =
    700


proportionalOrbit distance =
    ((maxOrbit - minOrbit) * (distance - shortestDistance))
        / (largestDistance - shortestDistance)
        + minOrbit


proportionatedDiam size =
    ((maxWidth - minWidth) * (size - smallestPlanet))
        / (biggestPlanet - smallestPlanet)
        + minWidth


rotateAnimation : Float -> Animation
rotateAnimation period =
    Animation.fromTo
        { duration = round (period / 1000)
        , options = [ Animation.loop, Animation.linear ]
        }
        [ P.property "transform" "rotateZ(0deg)" ]
        [ P.property "transform" "rotateZ(359deg)" ]


orbitAnimation : Float -> Float -> Animation
orbitAnimation period pos =
    Animation.fromTo
        { duration = round (period / 500)
        , options = [ Animation.loop, Animation.linear ]
        }
        [ P.scale 1, P.xy pos pos ]
        [ P.scale 1, P.xy pos pos ]



-- [ P.rotate 0, P.xy pos pos ]
-- [ P.rotate 359, P.xy pos pos ]
--24 seconds is a day


drawSolarSystem : List Planet -> Html Msg
drawSolarSystem planets =
    let
        planetsSorted =
            List.sortBy
                .distance
                planets

        numberOfPlanets =
            List.length planetsSorted

        sizes =
            List.take numberOfPlanets (0 :: (List.map proportionatedDiam <| List.map .size planetsSorted))

        corrections =
            List.range 0 (numberOfPlanets - 1)
                |> List.map (\n -> n * 15)
                |> List.map toFloat
                |> List.map2 (+) sizes

        planetsCorrectedAndSorted =
            List.map2 (\d p -> { p | distance = d + proportionalOrbit p.distance }) corrections planetsSorted
    in
    svg
        [ viewBox "0 0 1500 1500"
        , width "1500"
        , height "1500"
        ]
        ([ Svg.title [] [ text "The Solar System" ]
         , drawSun
         ]
            ++ List.map drawPlanet planetsCorrectedAndSorted
        )


animatedImage : Animation -> List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg
animatedImage =
    animatedSvg Svg.image


animatedG : Animation -> List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg
animatedG =
    animatedSvg Svg.g


animatedSvg :
    (List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg)
    -> Animation
    -> List (Svg.Attribute msg)
    -> List (Svg msg)
    -> Svg msg
animatedSvg =
    Animated.svg Svg.Attributes.class


drawPlanet : Planet -> Svg Msg
drawPlanet planet =
    let
        diam =
            proportionatedDiam planet.size

        distance =
            planet.distance

        radius =
            diam / 2

        pos =
            maxOrbit + distance - 100 - radius
    in
    -- animatedG (orbitAnimation planet.orbitalPeriod pos)
    --     [ Html.Attributes.attribute "transform-origin" ("-" ++ (String.fromFloat (distance - 100 - radius) ++ " -" ++ String.fromFloat (distance - 100 - radius))) ]
    animatedImage
        (rotateAnimation planet.rotationalPeriod)
        [ xlinkHref ("/30-days-of-elm/images/" ++ String.toLower planet.name ++ ".svg")
        , width <| String.fromFloat diam
        , height <| String.fromFloat diam

        --, Html.Attributes.attribute "transform-origin" (String.fromFloat radius ++ " " ++ String.fromFloat radius)
        -- , x (String.fromFloat diam)
        -- , y (String.fromFloat diam)
        , x (String.fromFloat (maxOrbit + distance - 100 - (diam / 2)))
        , y (String.fromFloat (maxOrbit + distance - 100 - (diam / 2)))
        ]
        [ Svg.title [] [ text planet.name ] ]


drawSun : Svg msg
drawSun =
    image
        [ xlinkHref "/30-days-of-elm/images/sun.svg"
        , x (String.fromFloat (maxOrbit - 100)) --center minus radius of the planet
        , y (String.fromFloat (maxOrbit - 100))
        , width "200"
        , height "200"
        ]
        [ Svg.title [] [ text "the_SuN" ] ]



-- @TODO: Orbit
