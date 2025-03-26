port module Ports exposing
    ( scrolled
    , socketConnect
    , socketDisconnect
    , socketMessageReceiver
    , socketSendMessage
    , socketStatusReceiver
    )

{-

   ██████      ██████     ██████     ████████    ███████
   ██   ██    ██    ██    ██   ██       ██       ██
   ██████     ██    ██    ██████        ██       ███████
   ██         ██    ██    ██   ██       ██            ██
   ██          ██████     ██   ██       ██       ███████

-}


port scrolled : (Bool -> msg) -> Sub msg


port socketSendMessage : String -> Effect Msg


port socketConnect : () -> Effect Msg


port socketDisconnect : () -> Effect Msg


port socketMessageReceiver : (String -> msg) -> Sub msg


port socketStatusReceiver : (Bool -> msg) -> Sub msg
