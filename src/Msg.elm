module Msg exposing (..)

import Pokemons.Msg


type Msg
    = NoOp
    | PokemonsMsg Pokemons.Msg.Msg
