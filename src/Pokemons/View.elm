module Pokemons.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import String.Extra exposing (toSentenceCase, nonEmpty)
import Pokemons.Types exposing (Pokemon, PokemonDetail, ApiResponse, Model, Msg(..))


pageItem : Maybe String -> String -> Html.Html Msg
pageItem url linkText =
    case url of
        Just url ->
            li [ class "page-item" ]
                [ a [ class "page-link", onClick (ChangePage url), href "#" ] [ text linkText ]
                ]

        Nothing ->
            li [ class "page-item disabled" ]
                [ a [ class "page-link" ] [ text linkText ]
                ]


pagination : ApiResponse -> Html.Html Msg
pagination model =
    nav []
        [ ul [ class "pagination justify-content-center" ]
            [ pageItem model.prevPage "Previous"
            , pageItem model.nextPage "Next"
            ]
        ]


item : Pokemon -> Html.Html Msg
item model =
    tr []
        [ td []
            [ a [ onClick (LoadDetails model.url), href "#" ]
                [ model.name |> toSentenceCase |> text
                ]
            ]
        ]


list : Model -> Html.Html Msg
list model =
    if model.isLoading then
        div [ style [ ( "text-align", "center" ) ] ]
            [ img [ width 80, src "images/ajax-loader.gif" ] []
            ]
    else
        div []
            [ table [ class "table table-hover table-sm" ]
                [ thead []
                    [ tr []
                        [ th [] [ "Name" |> text ]
                        ]
                    ]
                , tbody [] (List.map item model.api.pokemons)
                ]
            , pagination model.api
            ]


pluralize : Int -> String -> String
pluralize qtd name =
    if qtd == 1 then
        name
    else
        name ++ "s"


pokeType : List String -> Html.Html Msg
pokeType types =
    let
        count =
            List.length types

        title =
            (pluralize count "Type") ++ ": "

        tiposFinais =
            String.join ", " types
    in
        h6 [ class "card-subtitle mb-2 text-muted" ]
            [ text title
            , text tiposFinais
            ]


detail : PokemonDetail -> Html.Html Msg
detail model =
    div [ class "card" ]
        [ div [ class "card-header" ] [ text "Details" ]
        , detailContent model
        ]


detailContent : PokemonDetail -> Html.Html Msg
detailContent model =
    if model.isLoading then
        div [ class "card-block", style [ ( "text-align", "center" ) ] ]
            [ img [ width 80, src "images/ajax-loader.gif" ] []
            ]
    else if not model.isLoading && String.isEmpty model.name then
        div [ class "card-block", style [ ( "text-align", "center" ) ] ]
            [ span [] [ text "Select a Pokémon to view details..." ]
            ]
    else
        div [ class "card-block" ]
            [ h4 [ class "card-title" ] [ model.name |> toSentenceCase |> text ]
            , pokeType model.types
            , div [ style [ ( "text-align", "center" ) ] ]
                [ img [ src model.frontImage ] []
                , img [ src model.backImage ] []
                ]
            ]


viewFinal : Model -> Html.Html Msg
viewFinal model =
    div [ class "row" ]
        [ div [ class "col-md-6" ]
            [ list model ]
        , div [ class "col-md-6" ]
            [ detail model.pokemonDetail ]
        ]


view : Model -> Html.Html Msg
view model =
    viewFinal model
