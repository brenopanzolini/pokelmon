module Pokemons.Update exposing (..)

import Pokemons.Msg exposing (Msg(..))
import Pokemons.Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemons (Ok response) ->
            ( { model | isLoading = False, api = response }, Cmd.none )

        FetchPokemons (Err _) ->
            ( model, Cmd.none )
