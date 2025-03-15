module UI exposing (layout)

import Components.Top exposing (header)
import Element
import Html exposing (Html)
import Html.Attributes as Attr


layout : Html msg -> List (Html msg)
layout children =
    [ Html.div
        [ Attr.class "container"
        , Attr.style "display" "flex"
        , Attr.style "flex-direction" "column"
        , Attr.style "height" "100%"
        ]
        [ Html.header [ Attr.class "navbar" ]
            [ Element.layout
                []
                header
            ]
        , Html.main_ [ Attr.style "flex-grow" "1" ] [ children ]
        ]
    ]
