module Types exposing (..)

import Pokemons.Types


type Msg
    = NoOp
    | PokemonsMsg Pokemons.Types.Msg


type alias Model =
    { pokemons : Pokemons.Types.Model
    }
