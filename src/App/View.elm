module App.View exposing (view)

import Html exposing (a, div, h1, ul, li, text)
import String.Extra exposing (toSentenceCase)
import App.Models exposing (Pokemon, Model)
import App.Messages exposing (Msg(..))


viewPokemon : Pokemon -> Html.Html Msg
viewPokemon pokemon =
    li [] [ pokemon.name |> toSentenceCase |> text ]


view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "Pokelmon" ]
        , ul [] (List.map viewPokemon model.pokemons)
        ]
