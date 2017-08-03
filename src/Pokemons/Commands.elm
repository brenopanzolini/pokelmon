module Pokemons.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (Decoder)
import Pokemons.Msg exposing (Msg(FetchPokemons))
import Pokemons.Models exposing (Pokemon, ApiResponse)


fetchPokemons : Maybe String -> Cmd Msg
fetchPokemons url =
    let
        request =
            Http.get (Maybe.withDefault "http://www.pokeapi.co/api/v2/pokemon/" url) decoder
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
