module Pages.Day29 exposing (Model, Msg, page)

-- import Html.Attributes exposing (..)

import Colors.Opaque exposing (dimgray, grey)
import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, p)
import Html.Events exposing (onInput)
import Json.Decode as Decode
import Page exposing (Page)
import Regex exposing (Regex, contains)
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


maxLength =
    20


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddItem value ->
            let
                trimmedText =
                    String.left maxLength value
            in
            ( { model
                | list =
                    model.list ++ [ trimmedText ]
                , text = ""
              }
            , Cmd.none
            )

        RemoveItem value ->
            ( { model | list = List.filter (\x -> x /= value) model.list }, Cmd.none )

        DraftItem value ->
            let
                trimmedText =
                    String.left maxLength value
            in
            ( { model | text = trimmedText }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


buttonAttrs : Maybe Color -> List (Attribute msg)
buttonAttrs color =
    [ Element.width fill
    , padding 10
    , spacing 10
    , Background.color <| Maybe.withDefault Colors.Opaque.dodgerblue color
    , Border.rounded 5
    , Font.size 20
    , Font.color Colors.Opaque.white
    , Border.shadow { offset = ( 2, 2 ), size = 1, blur = 5, color = dimgray }
    , centerX
    ]


reduceCountLettersPerString : Model -> List (Element Msg)
reduceCountLettersPerString model =
    List.map
        (\x ->
            row
                [ centerY, padding 10, height (fill |> minimum 40) ]
                (charOccurrences x
                    |> Dict.toList
                    |> List.map
                        (\( c, i ) ->
                            [ row []
                                [ column [ Font.semiBold ] [ Element.text <| String.fromChar c ]
                                , column [ Font.light, Font.family [ Font.monospace ], Font.size 14, moveUp 4 ] [ Element.text <| String.fromInt i ]
                                ]
                            ]
                        )
                    |> List.foldr (++) []
                )
        )
        model.list


mappedList : Model -> List (Element Msg)
mappedList model =
    List.map
        (\x ->
            row
                [ centerY, padding 10, width fill, height (fill |> minimum 40) ]
                [ List.map
                    (\c ->
                        if Char.isUpper c then
                            Char.toLower c

                        else
                            Char.toUpper c
                    )
                    (String.toList
                        x
                    )
                    |> String.fromList
                    |> Element.text
                ]
        )
        model.list


hasBadWord : String -> Bool
hasBadWord input =
    let
        pattern : Maybe Regex
        pattern =
            Regex.fromString "F+U+C+K+"

        -- Matches "FUCK" with any repeated letters
    in
    case pattern of
        Just regex ->
            contains regex input

        Nothing ->
            False


filteredList : Model -> List (Element Msg)
filteredList model =
    List.map
        (\x ->
            row
                [ centerY
                , padding 10
                , height (fill |> minimum 40)
                ]
                [ Element.text x
                ]
        )
        (List.filter
            (\x -> x |> String.toUpper |> hasBadWord |> not)
            model.list
        )


rowStyle =
    [ spacing 4, width shrink ]


listConstructor : Model -> List (Element Msg)
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

        canBeAdded =
            not (List.member model.text model.list)
    in
    row
        (rowStyle
            ++ [ width <| px 460, height (fill |> minimum 40) ]
        )
        [ Input.text
            ((if canBeAdded then
                [ onEnter <| AddItem model.text ]

              else
                []
             )
                ++ [ width <| fillPortion 11, Border.rounded 5 ]
            )
            { placeholder = Just (Input.placeholder [] (Element.text "Add Item"))
            , onChange = DraftItem
            , label = Input.labelHidden "New Item"
            , text = model.text
            }
        , button ((buttonAttrs <| Just Colors.Opaque.mediumspringgreen) ++ [ width <| fillPortion 1 ])
            { onPress =
                if canBeAdded then
                    Just <| AddItem model.text

                else
                    Nothing
            , label = Element.column [ centerX ] [ Element.text "+" ]
            }
        ]
        :: List.map
            (\x ->
                row
                    (rowStyle ++ [ width <| px 460, height (fill |> minimum 40) ])
                    [ Element.column [ width <| fillPortion 11 ] [ Element.text x ]
                    , button ((buttonAttrs <| Just Colors.Opaque.indianred) ++ [ width <| fillPortion 1 ])
                        { onPress = Just <| RemoveItem x
                        , label = Element.column [ centerX ] [ Element.text "ｘ" ]
                        }
                    ]
            )
            model.list


charOccurrences : String -> Dict Char Int
charOccurrences str =
    String.foldl
        (\char dict ->
            Dict.update char
                (\maybeCount ->
                    Just <| Maybe.withDefault 0 maybeCount + 1
                )
                dict
        )
        Dict.empty
        str


columnStyle =
    [ width <| fillPortion 3, alignTop, spacing 4 ]


gridStyle =
    [ width (fillPortion 3), clipX, scrollbarX ]


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
                    , row [ width fill, spacing 16, Font.size 20, alignTop ]
                        [ column columnStyle (listConstructor model)
                        , column columnStyle ([ row rowStyle [ Element.text "Map" ], row (Font.light :: rowStyle) [ Element.text "Reverse letter case" ] ] ++ mappedList model)
                        , column columnStyle ([ row rowStyle [ Element.text "Filter" ], row (Font.light :: rowStyle) [ Element.text "Not f* words" ] ] ++ filteredList model)
                        , column columnStyle ([ row rowStyle [ Element.text "Reduce" ], row (Font.light :: rowStyle) [ Element.text "Count letters" ] ] ++ reduceCountLettersPerString model)
                        ]
                    ]
    }
