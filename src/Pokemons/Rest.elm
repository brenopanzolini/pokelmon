module Pokemons.Rest exposing (..)

import Http
import Json.Decode as Decode exposing (Decoder)
import Pokemons.Types exposing (Pokemon, PokemonDetail, ApiResponse, Msg(FetchPokemons, FetchPokemonDetails))


fetchPokemons : Maybe String -> Cmd Msg
fetchPokemons url =
    let
        request =
            Http.get (Maybe.withDefault "http://www.pokeapi.co/api/v2/pokemon?limit=10" url) decoder
    in
        Http.send FetchPokemons request


fetchPokemonDetails : String -> Cmd Msg
fetchPokemonDetails url =
    let
        request =
            Http.get url detailDecoder
    in
        Http.send FetchPokemonDetails request



-- DECODER


typeDecoder : Decoder String
typeDecoder =
    (Decode.at [ "type", "name" ] Decode.string)


detailDecoder : Decoder PokemonDetail
detailDecoder =
    Decode.map5
        PokemonDetail
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "sprites", "front_default" ] Decode.string)
        (Decode.at [ "sprites", "back_default" ] Decode.string)
        (Decode.at [ "types" ] (Decode.list typeDecoder))
        (Decode.succeed False)


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
