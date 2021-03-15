module Pokemons.Rest exposing (fetchPokemons, fetchDetail)

import Http
import Json.Decode as Decode exposing (Decoder)
import Pokemons.Types exposing (..)


fetchPokemons : Maybe String -> Cmd Msg
fetchPokemons url =
    let
        request =
            Http.get (Maybe.withDefault "https://pokeapi.co/api/v2/pokemon?limit=10" url) pokemonsDecoder
    in
        Http.send FetchPokemons request


fetchDetail : String -> Cmd Msg
fetchDetail url =
    let
        request =
            Http.get url detailDecoder
    in
        Http.send FetchDetail request



-- DECODER


pokemonsDecoder : Decoder ApiPokemons
pokemonsDecoder =
    Decode.map4
        ApiPokemons
        (Decode.at [ "count" ] Decode.int)
        (Decode.at [ "results" ] (Decode.list pokemonDecoder))
        (Decode.at [ "previous" ] (Decode.nullable Decode.string))
        (Decode.at [ "next" ] (Decode.nullable Decode.string))


pokemonDecoder : Decoder Pokemon
pokemonDecoder =
    Decode.map2
        Pokemon
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "url" ] Decode.string)


detailDecoder : Decoder ApiDetail
detailDecoder =
    Decode.map4
        ApiDetail
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "types" ] (Decode.list ((Decode.at [ "type", "name" ] Decode.string))))
        (Decode.at [ "sprites", "front_default" ] Decode.string)
        (Decode.at [ "sprites", "back_default" ] Decode.string)
