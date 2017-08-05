module Pokemons.Types exposing (..)

import Http


-- MSG


type Msg
    = NoOp
    | FetchPokemons (Result Http.Error ApiPokemons)
    | FetchDetail (Result Http.Error ApiDetail)
    | LoadDetail String
    | ChangePage String



--  MODELS


type alias Model =
    { pokemons : Pokemons
    , detail : Detail
    }


type alias Pokemons =
    { isLoading : Bool
    , api : ApiPokemons
    }


type alias ApiPokemons =
    { total : Int
    , results : List Pokemon
    , prevPage : Maybe String
    , nextPage : Maybe String
    }


type alias Pokemon =
    { name : String
    , url : String
    }


type alias Detail =
    { isLoading : Bool
    , api : ApiDetail
    }


type alias ApiDetail =
    { name : String
    , types : List String
    , frontImage : String
    , backImage : String
    }
