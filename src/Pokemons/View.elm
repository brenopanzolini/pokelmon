module Pokemons.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import String.Extra exposing (toSentenceCase)
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
        text "Loading..."
    else
        div [ class "row" ]
            [ div [ class "col-md-6" ]
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
            , div [ class "col-md-6" ]
                [ detail model.pokemonDetail ]
            ]


typeText : String -> Html.Html Msg
typeText pokeType =
    li [ class "list-group-item" ]
        [ (pokeType) |> toSentenceCase |> text
        ]


detail : PokemonDetail -> Html.Html Msg
detail model =
    let
        d =
            ""
    in
        div [ class "card" ]
            [ div [ class "card-header" ] [ text "Details" ]
            , div [ class "card-block" ]
                [ h4 [ class "card-title" ] [ model.name |> toSentenceCase |> text ]
                , ul [ class "list-group" ] (List.map typeText model.types)
                , div [ style [ ( "text-align", "center" ) ] ]
                    [ img [ src model.frontImage ] []
                    , img [ src model.backImage ] []
                    ]
                ]
            ]


view : Model -> Html.Html Msg
view model =
    list model
