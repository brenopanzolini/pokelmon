module Update exposing (..)

import Msg exposing (Msg(NoOp, PokemonsMsg))
import Pokemons.Update
import Models exposing (Model)


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
