module Pokemons.Update exposing (..)

import Pokemons.Msg exposing (Msg(..))
import Pokemons.Models exposing (Model)
import Pokemons.Commands exposing (fetchPokemons)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemons (Ok response) ->
            ( { model | isLoading = False, api = response }, Cmd.none )

        FetchPokemons (Err _) ->
            ( { model | isLoading = False }, Cmd.none )

        ChangePage pageUrl ->
            ( { model | isLoading = True }, fetchPokemons (Just pageUrl) )
