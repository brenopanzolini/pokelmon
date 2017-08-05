module Pokemons.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import String.Extra exposing (toSentenceCase)
import Pokemons.Types exposing (..)


pageItem : Maybe String -> String -> Html.Html Msg
pageItem url linkText =
    case url of
        Just url ->
            li
                [ class "page-item" ]
                [ a [ onClick (ChangePage url), href "#", class "page-link" ] [ text linkText ] ]

        Nothing ->
            li
                [ class "page-item disabled" ]
                [ a [ class "page-link" ] [ text linkText ] ]


pagination : ApiPokemons -> Html.Html Msg
pagination model =
    nav
        []
        [ ul
            [ class "pagination justify-content-center" ]
            [ pageItem model.prevPage "Previous"
            , pageItem model.nextPage "Next"
            ]
        ]


pokemon : Pokemon -> Html.Html Msg
pokemon model =
    tr
        []
        [ td
            []
            [ a [ onClick (LoadDetail model.url), href "#" ] [ model.name |> toSentenceCase |> text ] ]
        ]


pokemons : Pokemons -> Html.Html Msg
pokemons model =
    if model.isLoading then
        div
            [ style [ ( "text-align", "center" ) ] ]
            [ img [ width 80, src "images/loader.gif" ] [] ]
    else
        div
            []
            [ table
                [ class "table table-hover table-sm" ]
                [ thead
                    []
                    [ tr [] [ th [] [ text "Name" ] ] ]
                , tbody
                    []
                    (List.map pokemon model.api.results)
                ]
            , pagination model.api
            ]


detailContent : Detail -> Html.Html Msg
detailContent model =
    if model.isLoading then
        div
            [ class "card-block", style [ ( "text-align", "center" ) ] ]
            [ img [ width 80, src "images/loader.gif" ] [] ]
    else if String.isEmpty model.api.name then
        div
            [ class "card-block", style [ ( "text-align", "center" ) ] ]
            [ span [] [ text "Select a Pokémon to view details..." ] ]
    else
        div
            [ class "card-block" ]
            [ h4
                [ class "card-title" ]
                [ model.api.name |> toSentenceCase |> text ]
            , h6
                [ class "card-subtitle mb-2 text-muted" ]
                [ "Type: " ++ (String.join ", " model.api.types) |> text ]
            , div
                [ style [ ( "text-align", "center" ) ] ]
                [ img [ src model.api.frontImage ] []
                , img [ src model.api.backImage ] []
                ]
            ]


detail : Detail -> Html.Html Msg
detail model =
    div
        [ class "card" ]
        [ div
            [ class "card-header" ]
            [ text "Details" ]
        , detailContent model
        ]


view : Model -> Html.Html Msg
view model =
    div
        [ class "row" ]
        [ div
            [ class "col-md-6" ]
            [ pokemons model.pokemons ]
        , div
            [ class "col-md-6" ]
            [ detail model.detail ]
        ]
