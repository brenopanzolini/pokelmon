module App.Models exposing (..)


type alias Pokemon =
    { name : String
    , url : String
    }


type alias Model =
    { total : Int
    , pokemons : List Pokemon
    , prevPage : Maybe String
    , nextPage : Maybe String
    }
