module Pages.Home_ exposing (page)

import Colors.Opaque
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html exposing (..)
import Html.Attributes exposing (..)
import UI
import View exposing (View)


page : View msg
page =
    { title = "Homepage"
    , body = UI.layout <| Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <| content
    }


dayItem : String -> String -> String -> String -> Element msg
dayItem label day originalPost text =
    column [ spacing 16, Element.width fill ]
        [ Element.row [ Font.extraBold ] [ Element.text label ]
        , paragraph [] [ Element.text text ]
        , Element.row [ Element.width fill, Font.bold, Font.size 14 ]
            [ Element.column [ Element.width <| fillPortion 2 ]
                [ Element.link
                    [ alignLeft
                    , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                    , Border.dotted
                    , Border.color <| Colors.Opaque.steelblue
                    , mouseOver [ Border.glow Colors.Opaque.cornflowerblue 0.5 ]
                    ]
                    { url = "/" ++ day
                    , label = Element.text "Link to day"
                    }
                ]
            , Element.link
                [ centerX
                , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                , Border.dotted
                , Border.color <| Colors.Opaque.steelblue
                , mouseOver [ Border.glow Colors.Opaque.cornflowerblue 0.5 ]
                ]
                { url = "https://github.com/jmtalarn/30-days-of-elm/blob/main/src/Pages/" ++ (String.toUpper (String.left 1 day) ++ String.dropLeft 1 day) ++ ".elm"
                , label = Element.text "Link to source code"
                }
            , Element.column [ Element.width <| fillPortion 2 ]
                [ Element.link
                    [ alignRight
                    , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                    , Border.dotted
                    , Border.color <| Colors.Opaque.steelblue
                    , mouseOver [ Border.glow Colors.Opaque.cornflowerblue 0.5 ]
                    ]
                    { url = originalPost
                    , label = Element.text "Show original post"
                    }
                ]
            ]
        ]


content : Element msg
content =
    let
        someLongText =
            "Mollit officia id ipsum est laborum amet consequat ea commodo quis laborum culpa nostrud voluptate. Deserunt eu aliquip deserunt fugiat sunt in enim incididunt qui velit est deserunt commodo Lorem. Adipisicing laboris commodo sit commodo veniam cupidatat magna aliqua dolore nulla eu ad veniam non. Voluptate voluptate ex culpa nostrud duis minim elit ea. Sint excepteur esse laboris commodo excepteur ex esse irure. Labore sit nisi sit ipsum aute duis est occaecat consectetur qui pariatur."
    in
    column [ centerX, padding 24, Font.light, spacing 24 ]
        [ row []
            [ paragraph [ centerX, padding 8, spacing 16, Element.width (fill |> maximum 800) ]
                [ Element.text "I was trying to find something interesting to improve my skills with Elm and I stepped in this challenge proposed by Kristian Pedersen. I've just followed his 30 days challenge adapting it in my own way. I've been using mainly elm-ui to build the ui" ]
            ]
        , column [ centerX, spacing 64, padding 8, Element.width (fill |> maximum 800) ]
            [ dayItem "Day 01: Range slider value in p tag" "day1" "https://dev.to/kristianpedersen/30-days-of-elm-1-30-show-range-slider-value-in-p-tag-jdb" "This is simple as showing the value changed from a range input into a paragraph."
            , dayItem "Day 02: HTML element for each item in list" "day2" "https://dev.to/kristianpedersen/30daysofelm-day-2-html-element-for-each-item-in-list-3d20" "Another simple challenge, in this case about transform the string items in a list into paragraphs."
            , dayItem "Day 03: Random checkbox grid" "day3" "https://dev.to/kristianpedersen/30daysofelm-day-3-random-checkbox-grid-29j5" "Day 3 was about showing a grid of checkbox that individually can be checked on and off. It uses the Random package to randomize the checkboxes setted on and off and the UI is built just with the elm/html package. "
            , dayItem "Day 04: Toggle visibility" "day4" "https://dev.to/kristianpedersen/30daysofelm-day-4-toggle-visibility-1141" "This one is about hiding and showing an element in the screen depending on a model value. I've introduced also the use of the Time package to animate the showed element and give it some kind of animation using just the transform property. "
            , dayItem "Day 05: \"Lights Out\" game" "day5" "https://dev.to/kristianpedersen/30daysofelm-day-5-lights-out-game-4b16" "THis extends the grid of checkboxes from Day 3, but adding a kind of puzzle mechanic about turning off all the checkboxes taking in account that each click will toggle the checkboxes around  the one clicked (the ones that are around it forming a cross shape +). I've added a button to set up an easy setup to solve it quickly"
            , dayItem "Day 06: Accessible background colors" "day6" "https://dev.to/kristianpedersen/30daysofelm-day-6-accessible-background-colors-29ao" "This is an utility page, that will check if the contrast from a text and its background is \"valid\" in accessibility terms. The contrast will good enough to not compromise the readibility"
            , dayItem "Day 07: Centered divs and content" "day7" "https://dev.to/kristianpedersen/30daysofelm-day-7-centered-div-and-content-hfa" "Easy one about centering content, using elm-ui is quite straightforward."
            , dayItem "Day 08: Data from JS and auto-reload" "day8" "https://dev.to/kristianpedersen/30daysofelm-day-8-data-from-js-and-auto-reload-1o4h" "The original challenge was about passing data from flags into the Elm component. What I did here instead was, using the page features added with elm-spa I've used the params passed from the URL to initialize the model. If you edit the params from the fields a link to the page with the parameters is showed."
            , dayItem "Day 09: Astronomy data from Python in Elm" "day9" "https://dev.to/kristianpedersen/30daysofelm-day-9-astronomy-data-from-python-in-elm-deployment-difficulties-2i47" "This was an interesting one. Using the flags to pass in the API Key to request data about asteroids close to Earth from the NASA API, the page request the data about it and then parsing the JSON data received it shows a representation of these."
            , dayItem "Day 10: Mouse coordinates" "day10" "https://dev.to/kristianpedersen/30daysofelm-day-10-mouse-coordinates-1llo" "Using a subscription on the browser onMouseMove event, it shows the coordinates of the cursor relative to the main container."
            , dayItem "Day 11: Next binary number with same number of 1's" "day11" "https://dev.to/kristianpedersen/30daysofelm-day-11-next-binary-number-with-same-number-of-1-s-34gg" "This is about converting a decimal positive number in its binary representation and find out which is the next decimal number with the same amount of ones in its binary representation."
            , dayItem "Day 12: Same as yesterday, but with elm-binary" "day12" "https://dev.to/kristianpedersen/30daysofelm-day-12-elm-binary-4ijc" "The same as previous challenge but using a helper library, icidasset/elm-binary, to transform the numbers into its binary representation."
            , dayItem "Day 13: Simple line charts from yesterday's project" "day13" "https://dev.to/kristianpedersen/30daysofelm-day-13-simple-line-chart-1pkn" "Grabbed some range of data from the previous challenge and show how the difference looks like into a chart using the package terezka/line-charts"
            , dayItem "Day 14: Four CodeWars katas" "day14" "https://dev.to/kristianpedersen/30daysofelm-day-14-four-codewars-katas-3nck" "Four problems from https://www.codewars.com and its solution with elm."
            , dayItem "Day 15: Struggling with JSON :|" "day15" "https://dev.to/kristianpedersen/30daysofelm-day-15-struggling-with-json-4hhm" "This challenge is about parsing JSON. I created a free text input wher you can place a stringified JSON, it's parsed and then is showed at the side using the package klazuka/elm-json-tree-view"
            , dayItem "Day 16: Struggling slightly less with JSON" "day16" "https://dev.to/kristianpedersen/30daysofelm-day-16-struggling-slightly-less-with-json-38g7" "In this challenge continues dealing with JSON and parsing it. Now it uses specific decoders for the input data so it can just understand two specific kinds of data, book and user."
            , dayItem "Day 17: I decoded some JSON!" "day17" "https://dev.to/kristianpedersen/30daysofelm-day-17-i-decoded-some-json-4na5" "I've added nothing in this challenge and what is presented was kind of already solved in previous challenges."
            , dayItem "Day 18: Decoding JSON from a Python backend" "day18" "https://dev.to/kristianpedersen/day-18-decoding-json-from-a-python-backend-4010" "Eighteenth challenge is a bit more challenging, it decodes some random user data from https://randomuser.me/api/, it parses and decodes the JSON data received and shows up a card with the details."
            , dayItem "Day 19: Basic time" "day19" "https://dev.to/kristianpedersen/30daysofelm-day-19-basic-time-ac" "Quite simple but also interesting, given three timezones from TimeZone packages it shows the current time for the three diferent zones using the actual posix time given by Time package."
            , dayItem "Day 20: Getting the browser's width and height" "day20" "https://dev.to/kristianpedersen/30daysofelm-day-20-getting-browser-width-and-height-1nf9" "Using subscriptions and ports it gets the viewport size as well as the scroll position."
            , dayItem "Day 21: Planet list -> SVG drawings" "day21" "https://dev.to/kristianpedersen/30daysofelm-day-21-planet-list-svg-drawings-3n96" "From the data from a list of the planets on solar system and using the package elm/svg it show a graphical representation of it, where you can adjust the speed of the rotation changing the seconds that represents a day duration."
            , dayItem "Day 22: Simple codewars.com challenges" "day22" "https://dev.to/kristianpedersen/30daysofelm-day-22-simple-codewars-com-challenges-557c" "6 simple code challenges form codewars.com"
            , dayItem "Day 23: Simple layout with elm-ui" "day23" "https://dev.to/kristianpedersen/30daysofelm-day-23-simple-layout-with-elm-ui-274l" "This challenge was originally about using elm-ui package but as I was already been using it for most of the previous challenges I wanted to progress a bit more on a future challenge about solving the Knights Tour problem."
            , dayItem "Day 24: msg vs. Msg" "day24" "https://dev.to/kristianpedersen/30daysofelm-day-24-msg-vs-msg-2n1h" someLongText
            , dayItem "Day 25: Displaying a List (List String)" "day25" "https://dev.to/kristianpedersen/30daysofelm-day-25-displaying-a-list-list-string-5bf4" "This challenge was about understanding the difference between msg and Msg which is used along most of the Elm code. "
            , dayItem "Day 26: Debug.log, Debug.toString and the REPL" "day26" "https://dev.to/kristianpedersen/30daysofelm-day-26-inspecting-values-with-debug-log-debug-tostring-and-the-repl-3k4k" "Challenge about use of the Debug utility functions on Elm."
            , dayItem "Day 27: Using WebSockets+ports to control TouchDesigner" "day27" "https://dev.to/kristianpedersen/30daysofelm-day-27-using-websockets-ports-to-control-a-desktop-app-4b00" "I don't have access to any fancy stuff like the original post suggests so I've just picked up the echo websocket demo server (https://websocket.org/tools/websocket-echo-server/) using ports and subscriptions"
            , dayItem "Day 28: Chess board + intro to Knight's Tour" "day28" "https://dev.to/kristianpedersen/30daysofelm-day-28-chess-board-intro-to-knight-s-tour-1eb4" someLongText
            , dayItem "Day 29: Basic map, filter and reduce/foldl" "day29" "https://dev.to/kristianpedersen/30daysofelm-day-29-basic-map-filter-and-reduce-366l" someLongText
            , dayItem "Day 30: Closing thoughts" "day30" "https://dev.to/kristianpedersen/30daysofelm-day-30-closing-thoughts-2oka" someLongText
            ]
        ]
