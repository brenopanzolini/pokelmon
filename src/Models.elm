module Models exposing (..)

import Pokemons.Models
import Pokemons.Commands exposing (fetchPokemons)
import Msg exposing (Msg(PokemonsMsg))


type alias Model =
    { pokemons : Pokemons.Models.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        pokemonsModel =
            Pokemons.Models.Model
                True
                (Pokemons.Models.ApiResponse
                    0
                    []
                    Nothing
                    Nothing
                )

        cmd =
            Cmd.map PokemonsMsg fetchPokemons
    in
        ( Model pokemonsModel
        , cmd
        )
