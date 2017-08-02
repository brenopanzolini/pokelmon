module Pokemons.Update exposing (..)

import Pokemons.Msg exposing (Msg(..))
import Pokemons.Models exposing (ApiResponse)


update : Msg -> ApiResponse -> ( ApiResponse, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemons (Ok response) ->
            ( response, Cmd.none )

        FetchPokemons (Err _) ->
            ( model, Cmd.none )
