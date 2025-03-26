module Pages.Day20 exposing (Model, Msg, page)

--port module Pages.Day20 exposing (Model, Msg, page)
-- import Page exposing (Page)s.Day18 exposing (Response(..))

import Browser.Dom exposing (Viewport, getElement, getViewport)
import Browser.Events exposing (onResize)
import Colors.Opaque
import Element exposing (..)
import Element.Background
import Element.Border as Border
import Element.Font as Font exposing (center, size)
import Html exposing (h1)
import Html.Attributes as HtmlAttributes exposing (id)
import Html.Events exposing (onInput)
import Json.Decode as Decode
import Page exposing (Page)
import Ports
import Route exposing (Route)
import Shared
import Svg.Attributes exposing (result)
import Task
import Tuple exposing (first, second)
import UI
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type Model
    = Loading
    | Failure
    | Success Viewport


init : ( Model, Cmd Msg )
init =
    ( Loading, getNewViewport )


type Msg
    = GotNewViewport Viewport
    | GetNewViewport


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotNewViewport result ->
            ( Success result
            , Cmd.none
            )

        GetNewViewport ->
            ( Loading, getNewViewport )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onResize (\_ _ -> GetNewViewport)
        , Ports.scrolled (\_ -> GetNewViewport)
        ]


getNewViewport =
    Task.perform GotNewViewport getViewport



-- onMouseMove
--     (Decode.map2 Set
--         (Decode.field "pageX" Decode.int)
--         (Decode.field "pageY" Decode.int)
--     )


viewViewportInfo : Viewport -> Element Msg
viewViewportInfo viewport =
    row [ spacing 40 ]
        [ column [ spacing 15, alignTop ]
            [ row [ Font.extraBold ] [ text "scene " ]
            , row [] [ text "width : ", text (String.fromFloat viewport.scene.width) ]
            , row []
                [ text "height : "
                , text (String.fromFloat viewport.scene.height)
                ]
            ]
        , column [ spacing 15, alignTop ]
            [ row [ Font.extraBold ] [ text "viewport " ]
            , row [] [ text "x : ", text (String.fromFloat viewport.viewport.x) ]
            , row [] [ text "y : ", text (String.fromFloat viewport.viewport.y) ]
            , row [] [ text "width : ", text (String.fromFloat viewport.viewport.width) ]
            , row [] [ text "height : ", text (String.fromFloat viewport.viewport.height) ]
            ]
        ]


loremipsum : String
loremipsum =
    "Reprehenderit consequat et ullamco laboris occaecat quis qui veniam. Ut veniam consequat dolore dolor duis eu fugiat exercitation veniam aliqua. Ea ut proident qui eu deserunt. Incididunt exercitation occaecat anim voluptate excepteur non qui ullamco enim nulla consequat ullamco. Fugiat ullamco non amet sunt labore. Aliqua sunt aute Lorem dolore sunt sunt. Excepteur do incididunt anim Lorem officia.Ad reprehenderit ea sit est irure fugiat velit laborum eu minim nulla id cillum commodo. Ullamco non commodo fugiat id incididunt consequat irure anim culpa ut officia sint nisi. Ut pariatur excepteur aliquip qui dolore ea fugiat amet officia et. Pariatur minim in culpa ea occaecat do nulla excepteur est ipsum consequat ipsum elit. Sint laborum eiusmod Lorem irure elit commodo quis aliquip.\n\nEu est esse Lorem eiusmod reprehenderit ipsum consequat deserunt esse. Do amet laboris elit proident anim esse. Enim consequat aliquip laborum veniam ullamco nulla consectetur non quis occaecat cupidatat. Minim pariatur velit dolore mollit excepteur dolore quis laboris anim pariatur. Est eu velit ullamco consectetur reprehenderit excepteur et proident dolore fugiat cillum ad sunt. Commodo exercitation excepteur labore proident.\n\nAliqua consequat occaecat in commodo. Enim voluptate id ullamco nulla nulla cupidatat tempor voluptate. Tempor aliqua quis nostrud enim cupidatat veniam voluptate dolore culpa dolore proident magna mollit. Quis nostrud culpa nulla irure fugiat culpa Lorem voluptate veniam occaecat. Elit irure sunt reprehenderit esse aute. Ullamco nulla exercitation qui culpa et veniam enim irure ea non anim sunt et sint.\n\nAliquip in eu aliquip ea est excepteur duis aliqua cillum sit consectetur qui. Cupidatat velit mollit ea id. Sit cillum incididunt nostrud irure aliqua culpa enim aliqua magna velit aliqua qui minim. Esse anim exercitation aliquip labore quis occaecat nisi quis enim aliquip. Eu culpa ex eiusmod reprehenderit eiusmod duis tempor. Pariatur do reprehenderit et consequat consequat excepteur. Do officia proident sit enim tempor ex dolore sit minim ut ipsum reprehenderit incididunt.\n\nAnim consequat ex anim cupidatat duis sit. Occaecat eiusmod aute et laboris elit laboris incididunt eu enim dolor adipisicing proident dolor. Mollit eu ea et et excepteur non culpa minim Lorem occaecat dolore minim. Amet irure aliquip sit ut qui veniam aute aute nisi enim ipsum.\n\nSint aliquip sint ut cillum sunt enim aute excepteur do est. Officia nulla aute consectetur nisi incididunt. Do mollit nulla proident anim consectetur non mollit. Dolor dolor non do labore proident cillum veniam elit ut irure.\n\nIncididunt irure eiusmod ad consectetur in. Culpa qui aliqua eu eu eiusmod sint reprehenderit nisi sunt veniam dolor. Amet mollit ut cupidatat reprehenderit qui enim magna laboris qui in. Occaecat sunt incididunt nulla et pariatur Lorem irure."


view : Model -> View Msg
view model =
    let
        content =
            case model of
                Loading ->
                    text "Loading ..."

                Failure ->
                    text "There was a failure"

                Success viewport ->
                    viewViewportInfo viewport
    in
    { title = "Day 20"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column
                    [ centerX
                    , padding 40
                    , Font.size 30
                    , width fill
                    ]
                    [ row [ centerX ] [ html <| h1 [] [ Html.text "Viewport size" ] ]
                    , row [ centerX, padding 40, spacing 50 ] [ paragraph [ spacing 15, Font.extraLight, Font.size 10 ] (List.repeat 100 (Element.text loremipsum)) ]
                    , row
                        [ width fill
                        , Element.htmlAttribute <| HtmlAttributes.style "top" "15rem"
                        , Element.htmlAttribute <| HtmlAttributes.style "right" "5rem"
                        , Element.htmlAttribute <| HtmlAttributes.style "position" "fixed"
                        ]
                        [ column
                            [ alignRight
                            , width <| px 300
                            , height <| px 175
                            , Font.size 15
                            , padding 20
                            , Border.rounded 15
                            , Border.shadow { offset = ( 5, 5 ), size = 10, blur = 25, color = Colors.Opaque.dimgray }
                            , Element.Background.color Colors.Opaque.lemonchiffon
                            ]
                            [ content
                            ]
                        ]
                    ]
    }
