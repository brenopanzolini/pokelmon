module Models exposing (..)

import Pokemons.Models
import Pokemons.Commands exposing (fetchPokemons)
import Msg exposing (Msg(PokemonsMsg))


type alias Model =
    { showLoader : Bool
    , pokemons : Pokemons.Models.ApiResponse
    }


init : ( Model, Cmd Msg )
init =
    let
        pokemonsModel =
            Pokemons.Models.ApiResponse
                0
                []
                Nothing
                Nothing

        cmd =
            Cmd.map PokemonsMsg fetchPokemons
    in
        ( Model True pokemonsModel
        , cmd
        )
