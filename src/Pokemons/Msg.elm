module Pokemons.Msg exposing (..)

import Http
import Pokemons.Models exposing (ApiResponse)


type Msg
    = NoOp
    | FetchPokemons (Result Http.Error ApiResponse)
    | ChangePage String
