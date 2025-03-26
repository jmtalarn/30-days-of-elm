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


port socketSendMessage : String -> Cmd msg


port socketConnect : () -> Cmd msg


port socketDisconnect : () -> Cmd msg


port socketMessageReceiver : (String -> msg) -> Sub msg


port socketStatusReceiver : (Bool -> msg) -> Sub msg
