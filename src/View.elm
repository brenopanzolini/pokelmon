module View exposing (..)

import Html exposing (text)
import Pokemons.View
import Msg exposing (Msg(PokemonsMsg))
import Models exposing (Model)


view : Model -> Html.Html Msg
view model =
    Html.map PokemonsMsg (Pokemons.View.view model.pokemons)
