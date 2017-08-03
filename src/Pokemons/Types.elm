module Pokemons.Types exposing (..)

import Http


type Msg
    = NoOp
    | FetchPokemons (Result Http.Error ApiResponse)
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


type alias Model =
    { isLoading : Bool
    , api : ApiResponse
    }
