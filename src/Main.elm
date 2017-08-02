module Main exposing (..)

import Html
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.View exposing (view)
import App.Update exposing (update)
import App.Commands exposing (fetchAll)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\n -> Sub.none)
        }



-- INITIAL MODEL


init : ( Model, Cmd Msg )
init =
    ( Model 0 [] Nothing Nothing
    , fetchAll
    )
