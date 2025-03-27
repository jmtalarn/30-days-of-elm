module Pages.NotFound_ exposing (..)

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
    { title = "404 - Not Found"
    , body =
        UI.layout <|
            Element.layoutWith { options = [ Element.noStaticStyleSheet ] } [] <|
                column [ centerX, centerY, padding 24, Font.light, spacing 24 ]
                    [ row []
                        [ paragraph [ centerX, Font.size 64, padding 8, spacing 16, Element.width (fill |> maximum 800) ]
                            [ Element.text "PAGE NOT FOUND" ]
                        ]
                    , row []
                        [ paragraph [ centerX, Font.size 32, padding 8, spacing 16, Element.width (fill |> maximum 800) ]
                            [ Element.text "Please, go back to Index here "
                            , Element.link
                                [ Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                                , Border.dotted
                                , Border.color <| Colors.Opaque.steelblue
                                , mouseOver [ Border.glow Colors.Opaque.cornflowerblue 0.5 ]
                                ]
                                { url = "/"
                                , label = Element.text "Home ⌂"
                                }
                            , Element.text " and navigate to an existing page."
                            ]
                        ]
                    ]
    }
