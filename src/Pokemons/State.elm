module Pokemons.State exposing (init, update)

import Pokemons.Types exposing (..)
import Pokemons.Rest exposing (fetchPokemons, fetchDetail)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemons (Ok response) ->
            let
                newPokemons =
                    (Pokemons False response)
            in
                ( { model | pokemons = newPokemons }, Cmd.none )

        FetchPokemons (Err _) ->
            let
                newPokemons =
                    (Pokemons False model.pokemons.api)
            in
                ( { model | pokemons = newPokemons }, Cmd.none )

        ChangePage url ->
            let
                newPokemons =
                    (Pokemons True model.pokemons.api)
            in
                ( { model | pokemons = newPokemons }, fetchPokemons (Just url) )

        LoadDetail url ->
            let
                newDetail =
                    (Detail True model.detail.api)
            in
                ( { model | detail = newDetail }, fetchDetail url )

        FetchDetail (Ok response) ->
            let
                newDetail =
                    (Detail False response)
            in
                ( { model | detail = newDetail }, Cmd.none )

        FetchDetail (Err _) ->
            let
                newDetail =
                    (Detail False model.detail.api)
            in
                ( { model | detail = newDetail }, Cmd.none )



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        pokemons =
            Pokemons
                True
                (ApiPokemons 0 [] Nothing Nothing)

        detail =
            Detail
                False
                (ApiDetail "" [] "" "")
    in
        ( Model pokemons detail
        , fetchPokemons Nothing
        )
