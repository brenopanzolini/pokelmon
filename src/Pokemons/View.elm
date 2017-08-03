module Pokemons.View exposing (view)

import Html exposing (a, div, h1, text, nav, ul, li, table, thead, tbody, tr, th, td)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import String.Extra exposing (toSentenceCase)
import Pokemons.Types exposing (Pokemon, ApiResponse, Model, Msg(..))


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
        [ td [] [ model.name |> toSentenceCase |> text ]
        ]


list : Model -> Html.Html Msg
list model =
    if model.isLoading then
        text "Loading..."
    else
        div []
            [ table [ class "table table-sm" ]
                [ thead []
                    [ tr []
                        [ th [] [ "Name" |> text ]
                        ]
                    ]
                , tbody [] (List.map item model.api.pokemons)
                ]
            , pagination model.api
            ]


view : Model -> Html.Html Msg
view model =
    list model
