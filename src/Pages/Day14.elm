module Pages.Day14 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (grey)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, h3)
import Html.Events exposing (onInput)
import List exposing (foldl, map, map2)
import Page exposing (Page)
import Parser exposing (float, run)
import Regex
import Route exposing (Route)
import Shared
import String exposing (split, toInt)
import Tuple exposing (first)
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


type alias Kata1 =
    { initialPopulation : Int, percentGrowPerYear : Float, inhabitantsPerYear : Int, populationToSurpass : Int, population : Int, years : Maybe Int }


type alias Kata2 =
    { value : Int, result : String }


type alias Kata3 =
    { divisor : Int, bound : Int, mm : Int }


type alias Kata4 =
    { base : String, mumbling : String }


type alias Model =
    { kata1 : Kata1, kata2 : Kata2, kata3 : Kata3, kata4 : Kata4 }


init : ( Model, Cmd Msg )
init =
    ( Model (Kata1 0 2.0 0 0 0 Nothing) (Kata2 0 "") (Kata3 0 0 0) (Kata4 "" ""), Cmd.none )


type Msg
    = Kata1SetInitialPopulation String
    | Kata1SetPercentageGrowing String
    | Kata1SetPopulationToSurpass String
    | Kata1SetInhabitantsPerYear String
    | Kata2SetNumber String
    | Kata3SetDivisor String
    | Kata3SetBound String
    | Kata4SetMumblingBase String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { kata1, kata2, kata3, kata4 } =
            model
    in
    case msg of
        Kata1SetInitialPopulation value ->
            let
                pop0 =
                    Maybe.withDefault 0 <| toInt value
            in
            ( { model | kata1 = { kata1 | initialPopulation = pop0, population = pop0, years = Nothing } |> solveKata1 }, Cmd.none )

        Kata1SetPercentageGrowing value ->
            ( { model | kata1 = { kata1 | percentGrowPerYear = Maybe.withDefault 0 <| parseFloat value, population = kata1.initialPopulation, years = Nothing } |> solveKata1 }, Cmd.none )

        Kata1SetPopulationToSurpass value ->
            ( { model | kata1 = { kata1 | populationToSurpass = Maybe.withDefault 0 <| toInt value, population = kata1.initialPopulation, years = Nothing } |> solveKata1 }, Cmd.none )

        Kata1SetInhabitantsPerYear value ->
            ( { model | kata1 = { kata1 | inhabitantsPerYear = Maybe.withDefault 0 <| toInt value, population = kata1.initialPopulation, years = Nothing } |> solveKata1 }, Cmd.none )

        Kata2SetNumber value ->
            ( { model | kata2 = { kata2 | value = Maybe.withDefault 0 <| toInt value } |> solveKata2 }, Cmd.none )

        Kata3SetDivisor value ->
            ( { model | kata3 = { kata3 | divisor = Maybe.withDefault 0 <| toInt value, mm = kata3.bound } |> solveKata3 }, Cmd.none )

        Kata3SetBound value ->
            ( { model
                | kata3 =
                    { kata3
                        | bound = Maybe.withDefault 0 <| toInt value
                        , mm = Maybe.withDefault 0 <| toInt value
                    }
                        |> solveKata3
              }
            , Cmd.none
            )

        Kata4SetMumblingBase value ->
            ( { model | kata4 = { kata4 | base = justLettersFilter value } |> solveKata4 }, Cmd.none )


justLetters : Regex.Regex
justLetters =
    Maybe.withDefault Regex.never <|
        Regex.fromString "[^a-zA-Z]+"


justLettersFilter : String -> String
justLettersFilter string =
    Regex.replace justLetters (\_ -> "") string


solveKata4 : Kata4 -> Kata4
solveKata4 { base } =
    Kata4 base
        (String.split "" (String.toLower base)
            |> List.map2
                Tuple.pair
                (List.range 1 1000)
            |> List.map (\( n, letter ) -> List.repeat n letter)
            |> List.map
                (\letters ->
                    case letters of
                        [] ->
                            [ "" ]

                        l :: etters ->
                            String.toUpper l :: etters
                )
            |> List.map (String.join "")
            |> String.join "-"
        )



-- SolveKata1 { initialPopulation, percentGrowPerYear, inhabitantsPerYear, populationToSurpass } ->
--     ( { model | years = solveKata1 initialPopulation percentGrowPerYear inhabitantsPerYear populationToSurpass 0 }, Cmd.none )


solveKata3 : Kata3 -> Kata3
solveKata3 kata3 =
    let
        { divisor, bound, mm } =
            kata3

        _ =
            Debug.log "Kata3" kata3
    in
    if mm == 0 then
        Kata3 divisor bound mm

    else if modBy mm divisor == 0 then
        Kata3 divisor bound mm

    else
        solveKata3 (Kata3 divisor bound (mm - 1))


solveKata2 : Kata2 -> Kata2
solveKata2 { value } =
    let
        factorialOfDigits =
            String.fromInt value |> split "" |> List.map toInt |> List.map (Maybe.withDefault 0) |> List.map fact |> foldl (+) 0
    in
    if factorialOfDigits == value then
        Kata2 value "a STRONG number"

    else
        Kata2 value "NOT a STRONG number"


fact : Int -> Int
fact n =
    case n of
        0 ->
            1

        1 ->
            1

        _ ->
            n * fact (n - 1)


solveKata1 : Kata1 -> Kata1
solveKata1 kata1 =
    let
        { percentGrowPerYear, inhabitantsPerYear, populationToSurpass, population, years, initialPopulation } =
            kata1

        _ =
            Debug.log "kata1" kata1
    in
    if inhabitantsPerYear == 0 && initialPopulation == 0 then
        { kata1 | years = Nothing }

    else if population >= populationToSurpass then
        kata1

    else
        let
            populationOnNextYear =
                population + round (toFloat population * (percentGrowPerYear / 100)) + inhabitantsPerYear

            oneMoreYear =
                case years of
                    Just n ->
                        n + 1

                    Nothing ->
                        1
        in
        if populationOnNextYear == kata1.population then
            kata1

        else
            solveKata1 { kata1 | population = populationOnNextYear, years = Just oneMoreYear }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


parseFloat : String -> Maybe Float
parseFloat string =
    string
        |> Parser.run Parser.float
        |> Result.toMaybe


viewKata1 : Kata1 -> List (Element Msg)
viewKata1 kata1 =
    [ html <| h3 [] [ Html.text "Growth of a Population" ]
    , row [ spacing 20 ]
        [ column [ spacing 15 ]
            [ Input.text
                [ Font.extraLight ]
                { onChange = Kata1SetInitialPopulation
                , text = String.fromInt kata1.initialPopulation
                , placeholder = Just (Input.placeholder [] (Element.text "Write the number here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Initial population")
                }
            , Input.text
                [ Font.extraLight ]
                { onChange = Kata1SetPercentageGrowing
                , text = String.fromFloat kata1.percentGrowPerYear
                , placeholder = Just (Input.placeholder [] (Element.text "Write the percentage %"))
                , label =
                    Input.labelAbove []
                        (Element.text "Percentage growing per year")
                }
            , Input.text
                [ Font.extraLight ]
                { onChange = Kata1SetInhabitantsPerYear
                , text = String.fromInt kata1.inhabitantsPerYear
                , placeholder = Just (Input.placeholder [] (Element.text "Write a number here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Inhabitants variation per year")
                }
            , Input.text
                [ Font.extraLight ]
                { onChange = Kata1SetPopulationToSurpass
                , text = String.fromInt kata1.populationToSurpass
                , placeholder = Just (Input.placeholder [] (Element.text "Write the number"))
                , label =
                    Input.labelAbove []
                        (Element.text "Population to surpass")
                }
            ]
        , column [ spacing 20 ]
            [ row []
                [ Element.el [ Font.extraBold ] <|
                    Element.text
                        ("Years to surpass " ++ String.fromInt kata1.populationToSurpass ++ " of  population")
                ]
            , row [ centerX ]
                [ Element.el [ Font.extraLight, Font.size 30 ] <|
                    Element.text <|
                        case kata1.years of
                            Just number ->
                                String.fromInt number

                            Nothing ->
                                if kata1.initialPopulation >= kata1.populationToSurpass then
                                    "Already happened"

                                else
                                    "It'll never happen"
                ]
            ]
        ]
    ]


viewKata2 : Kata2 -> List (Element Msg)
viewKata2 kata2 =
    [ html <| h3 [] [ Html.text "Strong number" ]
    , paragraph [ Font.extraLight ] [ Element.text "Strong number is the number that the sum of the factorial of its digits is equal to number itself." ]
    , row [ spacing 20, width fill ]
        [ column [ spacing 8, paddingXY 0 12, width <| fillPortion 1 ]
            [ Input.text
                [ Font.extraLight ]
                { onChange = Kata2SetNumber
                , text = String.fromInt kata2.value
                , placeholder = Just (Input.placeholder [] (Element.text "Write the number here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Write a number to check if it is Strong")
                }
            ]
        , column [ width <| fillPortion 1 ]
            [ row [] [ paragraph [ Font.extraBold ] [ Element.text ("This number " ++ String.fromInt kata2.value ++ " is " ++ kata2.result) ] ]
            ]
        ]
    ]


viewKata3 : Kata3 -> List (Element Msg)
viewKata3 kata3 =
    [ html <| h3 [] [ Html.text "Maximum multiple" ]
    , row [ width fill, Font.extraLight, paddingXY 0 16 ] [ paragraph [] [ Element.text "Given a Divisor and a Bound , Find the largest integer N , Such That: N is divisible by divisor, N is less than or equal to bound, N is greater than 0." ] ]
    , row [ spacing 20, Element.width fill ]
        [ column [ spacing 20, Element.width <| fillPortion 1 ]
            [ Input.text
                [ Font.extraLight ]
                { onChange = Kata3SetDivisor
                , text = String.fromInt kata3.divisor
                , placeholder = Just (Input.placeholder [] (Element.text "Write the number here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Divisor")
                }
            , Input.text
                [ Font.extraLight ]
                { onChange = Kata3SetBound
                , text = String.fromInt kata3.bound
                , placeholder = Just (Input.placeholder [] (Element.text "Write the Bound"))
                , label =
                    Input.labelAbove []
                        (Element.text "Bound")
                }
            ]
        , column [ spacing 20, Element.width <| fillPortion 1 ]
            [ row [ centerX ]
                [ Element.el [ Font.extraBold ] <|
                    Element.text
                        "The maximum multiple is "
                ]
            , row [ centerX ] [ Element.el [ Font.extraLight, Font.size 30 ] <| Element.text <| String.fromInt kata3.mm ]
            ]
        ]
    ]


viewKata4 : Kata4 -> List (Element Msg)
viewKata4 kata4 =
    [ html <| h3 [] [ Html.text "Mumbling" ]
    , row [ spacing 20 ]
        [ column [ alignTop ]
            [ Input.text
                [ Font.extraLight, width <| px 300 ]
                { onChange = Kata4SetMumblingBase
                , text = kata4.base
                , placeholder = Just (Input.placeholder [] (Element.text "Write the letters here"))
                , label =
                    Input.labelAbove []
                        (Element.text "Mumbling base")
                }
            ]
        , column [ alignTop, width fill ]
            [ row []
                [ Element.el [ Font.extraBold ] <|
                    Element.text
                        "Mumbling with that base "
                ]
            , row [] [ Element.paragraph [ Font.extraLight, paddingEach { top = 10, left = 0, right = 0, bottom = 10 } ] [ Element.text kata4.mumbling ] ]
            ]
        ]
    ]


view : Model -> View Msg
view model =
    let
        { kata1, kata2, kata3, kata4 } =
            model
    in
    { title = "Day 14"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ paddingXY 40 20
                    , Font.size 30
                    , width fill
                    ]
                    [ html <| h1 [] [ Html.text "Day 14" ]
                    , row [ spacing 100, Font.size 15 ]
                        [ column [ alignTop ] (viewKata1 kata1)
                        , column [ alignTop ] (viewKata2 kata2 ++ viewKata3 kata3 ++ viewKata4 kata4)
                        ]
                    ]
    }
