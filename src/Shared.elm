port module Shared exposing
    ( Flags
    , Model
    , Msg(..)
    , init
    , scrolled
    , socketConnect
    , socketDisconnect
    , socketMessageReceiver
    , socketSendMessage
    , socketStatusReceiver
    , subscriptions
    , update
    )

import Json.Decode as Json
import Request exposing (Request)


type alias Flags =
    Json.Value


type alias Model =
    { nasaApiKey : String
    }



{-

   ██████      ██████     ██████     ████████    ███████
   ██   ██    ██    ██    ██   ██       ██       ██
   ██████     ██    ██    ██████        ██       ███████
   ██         ██    ██    ██   ██       ██            ██
   ██          ██████     ██   ██       ██       ███████

-}


port scrolled : (Bool -> msg) -> Sub msg


port socketSendMessage : String -> Cmd msg


port socketConnect : () -> Cmd msg


port socketDisconnect : () -> Cmd msg


port socketMessageReceiver : (String -> msg) -> Sub msg


port socketStatusReceiver : (Bool -> msg) -> Sub msg


type Msg
    = NoOp


init : Request -> Flags -> ( Model, Cmd Msg )
init _ flags =
    let
        nasaApiKey =
            flags
                |> Json.decodeValue (Json.field "nasaApiKey" Json.string)
                |> Result.withDefault ""
    in
    ( Model nasaApiKey, Cmd.none )


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
