module Pokemons.Rest exposing (..)

import Http
import Json.Decode as Decode exposing (Decoder)
import Pokemons.Types exposing (Pokemon, ApiResponse, Msg(FetchPokemons))


fetchPokemons : Maybe String -> Cmd Msg
fetchPokemons url =
    let
        request =
            Http.get (Maybe.withDefault "http://www.pokeapi.co/api/v2/pokemon?limit=10" url) decoder
    in
        Http.send FetchPokemons request



-- DECODER


pokemonDecoder : Decoder Pokemon
pokemonDecoder =
    Decode.map2
        Pokemon
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "url" ] Decode.string)


decoder : Decoder ApiResponse
decoder =
    Decode.map4
        ApiResponse
        (Decode.at [ "count" ] Decode.int)
        (Decode.at [ "results" ] (Decode.list pokemonDecoder))
        (Decode.at [ "previous" ] (Decode.nullable Decode.string))
        (Decode.at [ "next" ] (Decode.nullable Decode.string))
