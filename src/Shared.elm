module Shared exposing
    ( Flags
    , Model
    , Msg(..)
    , decoder
    , init
    , subscriptions
    , update
    )

import Effect exposing (Effect)
import Json.Decode as Json
import Route exposing (Route)


decoder : Json.Decoder Flags
decoder =
    Json.map Flags
        (Json.field "nasaApiKey" Json.string)


type alias Flags =
    Json.Value


type alias Model =
    { nasaApiKey : String
    }


type Msg
    = NoOp


init : Result Json.Error Flags -> Route () -> ( Model, Effect Msg )
init result _ =
    let
        nasaApiKey =
            result
                |> Result.withDefault { nasaApiKey = Nothing }
    in
    ( Model nasaApiKey, Cmd.none )


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update _ msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


subscriptions : Route () -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
