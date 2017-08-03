module Pokemons.View exposing (view)

import Html exposing (a, div, h1, text, ul, li)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import String.Extra exposing (toSentenceCase)
import Pokemons.Msg exposing (Msg(..))
import Pokemons.Models exposing (Pokemon, Model)


pagination : Maybe String -> String -> Html.Html Msg
pagination url linkText =
    case url of
        Just url ->
            a [ onClick (ChangePage url), href "#" ] [ text linkText ]

        Nothing ->
            a [] [ text linkText ]


item : Pokemon -> Html.Html Msg
item model =
    li []
        [ model.name |> toSentenceCase |> text ]


list : Model -> Html.Html Msg
list model =
    if model.isLoading then
        text "Loading..."
    else
        div []
            [ ul [] (List.map item model.api.pokemons)
            , pagination model.api.prevPage "Previous"
            , text "  |  "
            , pagination model.api.nextPage "Next"
            ]


view : Model -> Html.Html Msg
view model =
    let
        isLoading =
            True
    in
        div []
            [ h1 [] [ text "Pokémons" ]
            , list model
            ]
