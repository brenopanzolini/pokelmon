module App.Update exposing (..)

import App.Messages exposing (Msg(..))
import App.Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchAll (Result.Ok pokemons) ->
            ( pokemons, Cmd.none )

        FetchAll (Result.Err _) ->
            ( model, Cmd.none )
