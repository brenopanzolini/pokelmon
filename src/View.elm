module View exposing (view)

import Html exposing (div, nav)
import Html.Attributes exposing (class)
import Types exposing (Model, Msg(PokemonsMsg))
import Pokemons.View


view : Model -> Html.Html Msg
view model =
    div [ class "container" ]
        [ Html.map PokemonsMsg (Pokemons.View.view model.pokemons)
        ]
