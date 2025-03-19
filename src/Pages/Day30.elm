module Pages.Day30 exposing (Model, Msg, page)

import Colors.Opaque
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font exposing (size)
import Element.Input as Input exposing (..)
import Html exposing (h1, h2, h3, li, ul)
import Page
import Request exposing (Request)
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    Float


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


type Msg
    = Set Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Set value ->
            ( value, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> View Msg
view model =
    { title = "Day 30"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    ]
                    [ row [] [ html <| h1 [] [ Html.text "Day 30" ] ]
                    , row [ Font.size 20 ] [ html <| h2 [] [ Html.text "Final thoughts" ] ]
                    , column [ width fill, spacing 16, Font.size 20, Font.light ]
                        [ row [ paddingXY 0 8 ] [ paragraph [ spacing 8 ] [ Element.text "Initially I took the challenge just to practice and improve my skills on Elm. I've just adapted the challenges proposed by Kristian Pedersen who originally did this with his 30 days of Elm. I've just coding Elm mainly as a hobby and I've been doing when I had some spare time between projects and I needed some relaxing time in front of the computer. Yes, coding in Elm relaxes me ... you just need to find the piece that works and that's it, like solving puzzles or sudokus." ] ]
                        , row [ paddingXY 0 8 ] [ paragraph [ spacing 8 ] [ Element.text "To set up the whole thing, I've created an ", link linkAttrs { label = Element.text "elm-spa", url = "https://www.elm-spa.dev/" }, Element.text " app and added a page for each day of the challenge. I've been using a mix of ", link linkAttrs { url = "https://package.elm-lang.org/packages/elm/html/1.0.0/", label = Element.text "elm/html" }, Element.text " and ", link linkAttrs { url = "https://package.elm-lang.org/packages/mdgriffith/elm-ui/1.1.8/", label = Element.text "mdgriffith/elm-ui" }, Element.text " for building the UI. Elm-ui abstracts away the complexities of HTML and CSS, allowing you to focus on the layout and design directly. However, since I'm accustomed to working with HTML, CSS, and JavaScript in my day-to-day job, I sometimes find myself thinking in terms of traditional web development. This can be a bit challenging when trying to translate those ideas into elm-ui's paradigm." ] ]
                        , row [ paddingXY 0 8 ] [ paragraph [ spacing 8 ] [ Element.text "Despite this, elm-ui is quite powerful and intuitive once you get the hang of it. Additionally, using elm/html and elm/css is straightforward and integrates well with Elm, making it easy to switch between different approaches as needed. This flexibility has been particularly useful in tackling the diverse set of challenges presented throughout the 30 days." ] ]
                        , row [] [ html <| h3 [] [ Html.text "My favourites ones are..." ] ]
                        , row []
                            [ column [ width fill, spacing 32, padding 8 ]
                                [ row [] [ showDayRow "Day 21 - The Spinning Planets" "This day involves creating an animation of spinning planets. The code likely includes functions to handle the animation logic and rendering the planets on the screen." ]
                                , row []
                                    [ showDayRow "Day 9 - The Close Asteroids" "This day might involve simulating the movement of asteroids. The code would include logic for positioning and moving the asteroids."
                                    ]
                                , row []
                                    [ showDayRow "Day 28 - The Knights Tour" "This day involves solving the Knight's Tour problem on a chessboard. The code would include the algorithm to find the tour and render the chessboard."
                                    ]
                                , row []
                                    [ showDayRow "Day 27 - Working with WebSocket" "This day involves using WebSocket for real-time communication. The code would include setting up the WebSocket connection and handling messages."
                                    ]
                                ]
                            ]
                        , row [] [ html <| h3 [] [ Html.text "I struggled with..." ] ]
                        , row []
                            [ column [ width fill, spacing 16 ]
                                [ row [ paddingXY 0 8 ]
                                    [ paragraph [ spacing 8 ]
                                        [ Element.text "Initially, decoding JSON in Elm seemed quite tedious, especially coming from JavaScript where you can directly parse JSON data into JS objects. However, after constructing the appropriate decoder, I felt a sense of security knowing that the data handling was robust and less prone to errors. If something did go wrong, it was clear that the issue lay within the decoder itself, which could be adjusted accordingly." ]
                                    ]
                                , row [ paddingXY 0 8 ]
                                    [ paragraph [ spacing 8 ]
                                        [ Element.text "Additionally, attempting to solve the Knight's Tour problem on my own was a humbling experience. It turns out my algorithmic problem-solving skills are about as sharp as a marble. In the end, I shamelessly borrowed the solution from this repository "
                                        , link linkAttrs { url = "https://github.com/dc25/knightsTourElm", label = Element.text "https://github.com/dc25/knightsTourElm" }
                                        , Element.text ". Despite this, it was gratifying to see the problem being solved correctly each time I clicked on a chess cell."
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
    }


linkAttrs =
    [ Border.dotted, Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }, Border.color Colors.Opaque.steelblue ]


showDayRow : String -> String -> Element Msg
showDayRow title content =
    column [ width fill, spacing 8 ]
        [ row [ Font.bold ] [ Element.text title ]
        , row []
            [ paragraph []
                [ Element.text content
                ]
            ]
        ]
