module Pokemons.View exposing (..)

import Html exposing (a, div, h1, text, ul, li)
import String.Extra exposing (toSentenceCase)
import Pokemons.Msg exposing (Msg(..))
import Pokemons.Models exposing (Pokemon, ApiResponse)


pokemonView : Pokemon -> Html.Html Msg
pokemonView model =
    li []
        [ model.name |> toSentenceCase |> text ]


view : ApiResponse -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "Pokémons" ]
        , ul [] (List.map pokemonView model.pokemons)
        ]
