module Main exposing (..)

import Html
import Types exposing (Model, Msg)
import View exposing (view)
import State exposing (init, update)


{-| Main entry point
-}
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
