module App.Commands exposing (..)

import Http
import App.Messages exposing (Msg(..))
import Json.Decode as Decode exposing (Decoder)
import App.Models exposing (Pokemon, Model)


fetchAll : Cmd Msg
fetchAll =
    let
        request =
            Http.get "http://www.pokeapi.co/api/v2/pokemon" decode
    in
        Http.send FetchAll request



--DECODER


decodePokemon : Decoder Pokemon
decodePokemon =
    Decode.map2
        Pokemon
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "url" ] Decode.string)


decode : Decoder Model
decode =
    Decode.map4
        Model
        (Decode.at [ "count" ] Decode.int)
        (Decode.at [ "results" ] (Decode.list decodePokemon))
        (Decode.at [ "previous" ] (Decode.nullable Decode.string))
        (Decode.at [ "next" ] (Decode.nullable Decode.string))
