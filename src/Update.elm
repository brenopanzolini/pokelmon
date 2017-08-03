module Update exposing (..)

import Msg exposing (Msg(NoOp, PokemonsMsg))
import Models exposing (Model)
import Pokemons.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        PokemonsMsg subMsg ->
            let
                ( newApiResponse, cmd ) =
                    Pokemons.Update.update subMsg model.pokemons
            in
                ( { model | pokemons = newApiResponse }, Cmd.map PokemonsMsg cmd )
