module Pokemons.Types exposing (..)

import Http


type Msg
    = NoOp
    | FetchPokemons (Result Http.Error ApiResponse)
    | FetchPokemonDetails (Result Http.Error PokemonDetail)
    | LoadDetails String
    | ChangePage String


type alias Pokemon =
    { name : String
    , url : String
    }


type alias ApiResponse =
    { total : Int
    , pokemons : List Pokemon
    , prevPage : Maybe String
    , nextPage : Maybe String
    }


type alias PokemonDetail =
    { name : String
    , frontImage : String
    , backImage : String
    , types : List String
    , isLoading : Bool
    }


type alias Model =
    { isLoading : Bool
    , api : ApiResponse
    , pokemonDetail : PokemonDetail
    }
