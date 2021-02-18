module Pages.Day21 exposing (..)

import Colors.Opaque
import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input
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
    ( List Planet, Float )


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
    [ Planet "Mercury" "gray" 58.7 87967 4880 57910000
    , Planet "Venus" "yellow" 224.7 243000 12104 108200000
    , Planet "Earth" "blue" 365.25 1000 12756 149600000
    , Planet "Mars" "red" 686.97 1025 6794 227940000
    , Planet "Saturn" "orange" 10752.28 416 108728 1429400000
    , Planet "Jupiter" "gold" 4330.05 413.5 142984 778330000
    , Planet "Uranus" "lightblue" 30776.8 708 51118 2870990000
    , Planet "Neptune" "blue" 60148.64 666 49532 4504300000
    , Planet "Pluto" "beige" 90717.23 6375 2320 5913520000
    ]



-- [ Planet "Mercury" "gray" 58.7 (0.967 + 87) 4880 57910000
-- , Planet "Venus" "yellow" 224.7 243 12104 108200000
-- , Planet "Earth" "blue" 365.25 1 12756 149600000
-- , Planet "Mars" "red" 686.97 1.025 6794 227940000
-- , Planet "Saturn" "orange" ((29 * 365) + 167 + 0.28) 0.416 108728 1429400000
-- , Planet "Jupiter" "gold" ((11 * 365) + 315 + 0.05) 0.4135 142984 778330000
-- , Planet "Uranus" "lightblue" (84.32 * 365) 0.708 51118 2870990000
-- , Planet "Neptune" "blue" ((164 * 365) + 288 + 0.54) 0.666 49532 4504300000
-- , Planet "Pluto" "beige" ((248 * 365) + 197 + 0.23) 6.375 2320 5913520000
-- ]


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( ( planetsList, 4000 ), Cmd.none )


type Msg
    = Tick Time.Posix
    | SetSpeed Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( list, speed ) =
    case msg of
        Tick _ ->
            ( ( list, speed ), Cmd.none )

        SetSpeed newSpeed ->
            ( ( list, newSpeed ), Cmd.none )


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
view ( planets, speed ) =
    { title = "Day 21"
    , body =
        [ Element.column
            [ Element.width Element.fill
            , Font.size 30
            , Element.centerX
            ]
            [ Element.row [ Element.width Element.fill, Element.spacing 100 ]
                [ Element.column [ Element.centerX ] [ Element.html <| h1 [] [ Html.text "Planets obsession" ] ]
                , Element.column [ Element.centerX ] [ speedInput speed ]
                ]
            , Element.row [ Element.centerX ]
                [ Element.html <| drawSolarSystem planets speed ]
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
    250


maxOrbit =
    750


svgWidth =
    maxOrbit * 2 + 200


svgCenter =
    String.fromFloat (svgWidth / 2)


proportionalOrbit distance =
    ((maxOrbit - minOrbit) * (distance - shortestDistance))
        / (largestDistance - shortestDistance)
        + minOrbit


proportionatedDiam size =
    ((maxWidth - minWidth) * (size - smallestPlanet))
        / (biggestPlanet - smallestPlanet)
        + minWidth


rotateAnimation : Float -> Float -> Animation
rotateAnimation period speed =
    let
        rotationPeriod =
            round ((period * speed) / 1000)
    in
    Animation.fromTo
        { duration =
            if rotationPeriod > 0 then
                rotationPeriod

            else
                1000

        -- Long value to see that it moves sloooowly,
        , options = [ Animation.loop, Animation.linear ]
        }
        [ P.property "transform" "rotateZ(0deg)" ]
        [ P.property "transform" "rotateZ(359deg)" ]


orbitAnimation : Float -> Float -> Animation
orbitAnimation period speed =
    let
        orbitPeriod =
            round (period * speed)
    in
    Animation.fromTo
        { duration =
            if orbitPeriod > 0 then
                orbitPeriod

            else
                1000
        , options = [ Animation.loop, Animation.linear ]
        }
        [ P.property "transform" "rotateZ(0deg)" ]
        [ P.property "transform" "rotateZ(359deg)" ]



--24 seconds is a day


drawSolarSystem : List Planet -> Float -> Html Msg
drawSolarSystem planets speed =
    let
        planetsSorted =
            List.sortBy
                .distance
                planets

        numberOfPlanets =
            List.length planetsSorted

        proportionatedDiams =
            List.map proportionatedDiam <| List.map .size planetsSorted

        sizes =
            List.take numberOfPlanets (0 :: proportionatedDiams)

        corrections =
            List.range 0 (numberOfPlanets - 1)
                |> List.map (\n -> n * 20)
                |> List.map toFloat
                |> List.map2 (+) sizes

        planetsCorrectedAndSorted =
            List.map2 (\d p -> { p | distance = d + proportionalOrbit p.distance }) corrections planetsSorted

        _ =
            Debug.log "swWidht" svgWidth

        sw =
            String.fromFloat svgWidth
    in
    svg
        [ viewBox ("0 0 " ++ sw ++ " " ++ sw ++ "")
        , width sw
        , height sw
        , Html.Attributes.attribute
            "transform-origin"
            "center"

        --    (String.fromFloat maxOrbit ++ " " ++ String.fromFloat maxOrbit)
        , transform "rotate(180)"
        , Svg.Attributes.style "background-color: midnightblue"
        ]
        ([ Svg.title [] [ text "The Solar System" ]
         , drawSun
         ]
            ++ List.map drawPath planetsCorrectedAndSorted
            ++ List.map (\p -> drawPlanet p speed) planetsCorrectedAndSorted
        )


animatedImage : Animation -> List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg
animatedImage =
    animatedSvg Svg.image


animatedG : Animation -> List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg
animatedG =
    animatedSvg Svg.g


animatedSvgSvg : Animation -> List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg
animatedSvgSvg =
    animatedSvg Svg.svg


animatedSvg :
    (List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg)
    -> Animation
    -> List (Svg.Attribute msg)
    -> List (Svg msg)
    -> Svg msg
animatedSvg =
    Animated.svg Svg.Attributes.class


drawPath : Planet -> Svg Msg
drawPath planet =
    let
        diam =
            proportionatedDiam planet.size

        radius =
            planet.distance - 120
    in
    circle
        [ cx svgCenter --center minus radius of the planet
        , cy svgCenter
        , r (String.fromFloat radius)
        , stroke planet.texture
        , strokeWidth "1"
        , strokeDasharray "5 5"
        , fill "none"
        ]
        [ Svg.title [] [ text planet.name ] ]


drawPlanet : Planet -> Float -> Svg Msg
drawPlanet planet speed =
    let
        diam =
            proportionatedDiam planet.size

        distance =
            planet.distance

        basePlanet =
            svgWidth / 2
    in
    animatedG (orbitAnimation planet.orbitalPeriod speed)
        [ Html.Attributes.attribute
            "transform-origin"
            (svgCenter ++ " " ++ svgCenter)
        ]
        [ svg
            [ x (String.fromFloat (basePlanet - (diam / 2))) --(String.fromFloat (maxOrbit + distance - 100 - (diam / 2)))
            , y (String.fromFloat (basePlanet + distance - 120 - (diam / 2)))
            ]
            [ animatedImage
                (rotateAnimation
                    planet.rotationalPeriod
                    speed
                )
                [ xlinkHref ("/30-days-of-elm/images/" ++ String.toLower planet.name ++ ".svg")
                , width <| String.fromFloat diam
                , height <| String.fromFloat diam
                , Html.Attributes.attribute "transform-origin" (String.fromFloat (diam / 2) ++ " " ++ String.fromFloat (diam / 2))
                ]
                [ Svg.title [] [ text planet.name ] ]
            ]
        ]



-- ]


speedInput value =
    let
        printValue =
            (toFloat (round (value * 1000)) / 1000) / 1000
    in
    Input.slider
        [ Element.behindContent
            (Element.el
                [ Element.width Element.fill
                , Element.height (Element.px 2)
                , Element.centerY
                , Background.color Colors.Opaque.grey
                , Border.rounded 2
                ]
                Element.none
            )
        , Element.width <| Element.px 500
        ]
        { onChange = SetSpeed
        , min = 1
        , max = 10000
        , label =
            Input.labelAbove [ Font.size 16 ]
                (Element.text ("Speed 1 day in " ++ String.fromFloat printValue ++ " seconds"))
        , thumb = Input.defaultThumb
        , step = Just 1
        , value = value
        }


drawSun : Svg msg
drawSun =
    image
        [ xlinkHref "/30-days-of-elm/images/sun.svg"
        , x (String.fromFloat ((svgWidth / 2) - 100)) --center minus radius of the planet
        , y (String.fromFloat ((svgWidth / 2) - 100))
        , width "200"
        , height "200"
        ]
        [ Svg.title [] [ text "the_SuN" ] ]
