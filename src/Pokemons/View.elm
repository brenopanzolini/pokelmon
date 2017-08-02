module Pokemons.View exposing (..)

import Html exposing (a, div, h1, text, ul, li)
import String.Extra exposing (toSentenceCase)
import Pokemons.Msg exposing (Msg(..))
import Pokemons.Models exposing (..)


pokemonView : Pokemon -> Html.Html Msg
pokemonView model =
    li []
        [ model.name |> toSentenceCase |> text ]


listView : Model -> Html.Html Msg
listView model =
    if model.isLoading then
        text "Loading..."
    else
        ul [] (List.map pokemonView model.api.pokemons)


view : Model -> Html.Html Msg
view model =
    let
        isLoading =
            True
    in
        div []
            [ h1 [] [ text "Pokémons" ]
            , listView model
            ]
