module Pokemons.Types exposing (..)

import Http


type Msg
    = NoOp
    | FetchPokemons (Result Http.Error ApiPokemons)
    | FetchDetail (Result Http.Error ApiDetail)
    | LoadDetail String
    | ChangePage String


type alias Pokemon =
    { name : String
    , url : String
    }


type alias ApiPokemons =
    { total : Int
    , list : List Pokemon
    , prevPage : Maybe String
    , nextPage : Maybe String
    }


type alias Pokemons =
    { isLoading : Bool
    , api : ApiPokemons
    }


type alias ApiDetail =
    { name : String
    , types : List String
    , frontImage : String
    , backImage : String
    }


type alias Detail =
    { isLoading : Bool
    , api : ApiDetail
    }


type alias Model =
    { pokemons : Pokemons
    , detail : Detail
    }
