module Main exposing
    ( conf
    , main
    )

-- import Html.String
-- import Html.String.Attributes
-- import Html.String.Extra
-- import Starter.ConfMeta
-- import Starter.SnippetHtml
-- import Starter.SnippetJavascript

import Browser
import Browser.Navigation as Nav
import Shared exposing (Flags, urls)
import Spa.Document as Document exposing (Document)
import Spa.Pages as Pages
import Spa.Route as Route exposing (Route)
import Starter.ConfMain
import Url exposing (Url)



-- backgroundColor : { blue : number, green : number1, red : number2 }
-- backgroundColor =
--     -- { red = 116, green = 222, blue = 165 }
--     { red = 38, green = 104, blue = 69 }


conf : Starter.ConfMain.Conf
conf =
    { urls = Shared.urls
    , assetsToCache = []
    }


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view >> Document.toBrowserDocument
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }



-- INIT


type alias Model =
    { shared : Shared.Model
    , page : Pages.Model
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        _ =
            Debug.log "flags on main" flags

        ( shared, sharedCmd ) =
            Shared.init flags url key

        ( page, pageCmd ) =
            Pages.init (fromUrl url) shared
    in
    ( Model shared page
    , Cmd.batch
        [ Cmd.map Shared sharedCmd
        , Cmd.map Pages pageCmd
        ]
    )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | Shared Shared.Msg
    | Pages Pages.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked (Browser.Internal url) ->
            ( model
            , Nav.pushUrl model.shared.key (Url.toString url)
            )

        LinkClicked (Browser.External href) ->
            ( model
            , Nav.load href
            )

        UrlChanged url ->
            let
                original =
                    model.shared

                shared =
                    { original | url = url }

                ( page, pageCmd ) =
                    Pages.init (fromUrl url) shared
            in
            ( { model | page = page, shared = Pages.save page shared }
            , Cmd.map Pages pageCmd
            )

        Shared sharedMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update sharedMsg model.shared

                ( page, pageCmd ) =
                    Pages.load model.page shared
            in
            ( { model | page = page, shared = shared }
            , Cmd.batch
                [ Cmd.map Shared sharedCmd
                , Cmd.map Pages pageCmd
                ]
            )

        Pages pageMsg ->
            let
                ( page, pageCmd ) =
                    Pages.update pageMsg model.page

                shared =
                    Pages.save page model.shared
            in
            ( { model | page = page, shared = shared }
            , Cmd.map Pages pageCmd
            )


view : Model -> Document Msg
view model =
    Shared.view
        { page =
            Pages.view model.page
                |> Document.map Pages
        , toMsg = Shared
        }
        model.shared


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Shared.subscriptions model.shared
            |> Sub.map Shared
        , Pages.subscriptions model.page
            |> Sub.map Pages
        ]



-- URL


fromUrl : Url -> Route
fromUrl =
    Route.fromUrl >> Maybe.withDefault Route.NotFound
