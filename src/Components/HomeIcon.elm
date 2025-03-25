module Components.HomeIcon exposing (icon)

import Element exposing (html)
import Html exposing (..)
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr


icon : Element.Element msg
icon =
    html <|
        svg
            [ --  SvgAttr.width "800px"
              -- , SvgAttr.height "800px"
              SvgAttr.viewBox "0 0 24 24"
            , SvgAttr.fill "none"
            ]
            [ path
                [ SvgAttr.d "M22 22L2 22"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                , SvgAttr.strokeLinecap "round"
                ]
                []
            , path
                [ SvgAttr.d "M2 11L10.1259 4.49931C11.2216 3.62279 12.7784 3.62279 13.8741 4.49931L22 11"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                , SvgAttr.strokeLinecap "round"
                ]
                []
            , path
                [ SvgAttr.opacity "0.5"
                , SvgAttr.d "M15.5 5.5V3.5C15.5 3.22386 15.7239 3 16 3H18.5C18.7761 3 19 3.22386 19 3.5V8.5"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                , SvgAttr.strokeLinecap "round"
                ]
                []
            , path
                [ SvgAttr.d "M4 22V9.5"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                , SvgAttr.strokeLinecap "round"
                ]
                []
            , path
                [ SvgAttr.d "M20 22V9.5"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                , SvgAttr.strokeLinecap "round"
                ]
                []
            , path
                [ SvgAttr.opacity "0.5"
                , SvgAttr.d "M15 22V17C15 15.5858 15 14.8787 14.5607 14.4393C14.1213 14 13.4142 14 12 14C10.5858 14 9.87868 14 9.43934 14.4393C9 14.8787 9 15.5858 9 17V22"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                ]
                []
            , path
                [ SvgAttr.opacity "0.5"
                , SvgAttr.d "M14 9.5C14 10.6046 13.1046 11.5 12 11.5C10.8954 11.5 10 10.6046 10 9.5C10 8.39543 10.8954 7.5 12 7.5C13.1046 7.5 14 8.39543 14 9.5Z"
                , SvgAttr.stroke "#1C274C"
                , SvgAttr.strokeWidth "1.5"
                ]
                []
            ]
