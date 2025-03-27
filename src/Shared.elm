module Shared exposing
    ( Flags
    , Model
    , Msg
    , decoder
    , init
    , subscriptions
    , update
    )

import Effect exposing (Effect)
import Json.Decode exposing (field, map, string)
import Route exposing (Route)
import Shared.Model
import Shared.Msg


type alias Flags =
    { nasaApiKey : Maybe String }


decoder : Json.Decode.Decoder Flags
decoder =
    map Flags
        (field "nasaApiKey" (Json.Decode.maybe string))


type alias Model =
    Shared.Model.Model


type alias Msg =
    Shared.Msg.Msg


init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init result _ =
    let
        flags =
            result
                |> Result.withDefault { nasaApiKey = Nothing }
    in
    ( Shared.Model.Model <| Maybe.withDefault "" <| flags.nasaApiKey, Effect.none )


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update _ msg model =
    case msg of
        Shared.Msg.NoOp ->
            ( model
            , Effect.none
            )


subscriptions : Route () -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none
