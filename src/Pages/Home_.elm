module Pages.Home_ exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import UI
import View exposing (View)


view : View msg
view =
    { title = "Homepage"
    , body = UI.layout <| content
    }


content =
    div []
        [ p []
            [ text "These aren't necessarily sorted by difficulty. " ]
        , p []
            [ text "I just come up with a challenge every day that fits my current level. I've also accounted for varying motivation, so any new Elm code or knowledge counts." ]
        , p []
            [ text "(01) 2020-12-17: "
            , a [ href "https://dev.to/kristianpedersen/30-days-of-elm-1-30-show-range-slider-value-in-p-tag-jdb" ]
                [ text "Range slider value in p tag" ]
            , br []
                []
            , text "(02) 2020-12-18: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-2-html-element-for-each-item-in-list-3d20" ]
                [ text "HTML element for each item in list" ]
            , br []
                []
            , text "(03) 2020-12-19: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-3-random-checkbox-grid-29j5" ]
                [ text "Random checkbox grid" ]
            ]
        , p []
            [ text "(04) 2020-12-20: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-4-toggle-visibility-1141" ]
                [ text "Toggle visibility" ]
            , br []
                []
            , text "(05) 2020-12-21: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-5-lights-out-game-4b16" ]
                [ text "\"Lights Out\" game" ]
            , br []
                []
            , text "(06) 2020-12-22: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-6-accessible-background-colors-29ao" ]
                [ text "Accessible background colors" ]
            ]
        , p []
            [ text "(07) 2020-12-23: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-7-centered-div-and-content-hfa" ]
                [ text "Centered divs and content" ]
            , br []
                []
            , text "(08) 2020-12-24: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-8-data-from-js-and-auto-reload-1o4h" ]
                [ text "Data from JS and auto-reload" ]
            , br []
                []
            , text "(09) 2020-12-25: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-9-astronomy-data-from-python-in-elm-deployment-difficulties-2i47" ]
                [ text "Astronomy data from Python in Elm" ]
            ]
        , p []
            [ text "(10) 2020-12-26: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-10-mouse-coordinates-1llo" ]
                [ text "Mouse coordinates" ]
            , br []
                []
            , text "(11) 2020-12-27: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-11-next-binary-number-with-same-number-of-1-s-34gg" ]
                [ text "Next binary number with same number of 1's" ]
            , br []
                []
            , text "(12) 2020-12-28: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-12-elm-binary-4ijc" ]
                [ text "Same as yesterday, but with elm-binary" ]
            ]
        , p []
            [ text "(13) 2020-12-29: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-13-simple-line-chart-1pkn" ]
                [ text "Simple line charts from yesterday's project" ]
            , br []
                []
            , text "(14) 2020-12-30: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-14-four-codewars-katas-3nck" ]
                [ text "Four CodeWars katas" ]
            , br []
                []
            , text "(15) 2020-12-31: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-15-struggling-with-json-4hhm" ]
                [ text "Struggling with JSON :|" ]
            ]
        , p []
            [ text "(16) 2021-01-01: "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-16-struggling-slightly-less-with-json-38g7" ]
                [ text "Struggling slightly less with JSON" ]
            , br []
                []
            , text "(17) 2021-01-02 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-17-i-decoded-some-json-4na5" ]
                [ text "I decoded some JSON!" ]
            , br []
                []
            , text "(18) 2021-01-03 "
            , a [ href "https://dev.to/kristianpedersen/day-18-decoding-json-from-a-python-backend-4010" ]
                [ text "Decoding JSON from a Python backend" ]
            ]
        , p []
            [ text "(19) 2021-01-04 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-19-basic-time-ac" ]
                [ text "Basic time" ]
            , br []
                []
            , text "(20) 2021-01-05 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-20-getting-browser-width-and-height-1nf9" ]
                [ text "Getting the browser's width and height" ]
            , br []
                []
            , text "(21) 2021-01-06 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-21-planet-list-svg-drawings-3n96" ]
                [ text "Planet list -> SVG drawings" ]
            ]
        , p []
            [ text "(22) 2021-01-07 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-22-simple-codewars-com-challenges-557c" ]
                [ text "Simple codewars.com challenges" ]
            , br []
                []
            , text "(23) 2021-01-08 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-23-simple-layout-with-elm-ui-274l" ]
                [ text "Simple layout with elm-ui" ]
            , br []
                []
            , text "(24) 2021-01-09 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-24-msg-vs-msg-2n1h" ]
                [ text "msg vs. Msg" ]
            ]
        , p []
            [ text "(25) 2021-01-10 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-25-displaying-a-list-list-string-5bf4" ]
                [ text "Displaying a List (List String)" ]
            , br []
                []
            , text "(26) 2021-01-11 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-26-inspecting-values-with-debug-log-debug-tostring-and-the-repl-3k4k" ]
                [ text "Debug.log, Debug.toString and the REPL" ]
            , br []
                []
            , text "(27) 2021-01-12 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-27-using-websockets-ports-to-control-a-desktop-app-4b00" ]
                [ text "Using WebSockets+ports to control TouchDesigner" ]
            ]
        , p []
            [ text "(28) 2021-01-13 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-28-chess-board-intro-to-knight-s-tour-1eb4" ]
                [ text "Chess board + intro to Knight's Tour" ]
            , br []
                []
            , text "(29) 2021-01-14 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-29-basic-map-filter-and-reduce-366l" ]
                [ text "Basic map, filter and reduce/foldl" ]
            , br []
                []
            , text "(30) 2021-01-15 "
            , a [ href "https://dev.to/kristianpedersen/30daysofelm-day-30-closing-thoughts-2oka" ]
                [ text "Closing thoughts" ]
            ]
        ]
