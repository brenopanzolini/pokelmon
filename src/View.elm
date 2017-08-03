module View exposing (view)

import Html
import Types exposing (Model, Msg(PokemonsMsg))
import Pokemons.View


view : Model -> Html.Html Msg
view model =
    Html.map PokemonsMsg (Pokemons.View.view model.pokemons)
