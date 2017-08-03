module Main exposing (..)

import Html
import Msg exposing (Msg)
import Models exposing (init, Model)
import View exposing (view)
import Update exposing (update)


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
