module Pokemons.State exposing (init, update)

import Pokemons.Types exposing (Model, PokemonDetail, ApiResponse, Msg(..))
import Pokemons.Rest exposing (fetchPokemons, fetchPokemonDetails)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemons (Ok response) ->
            ( { model | isLoading = False, api = response }, Cmd.none )

        FetchPokemons (Err _) ->
            ( { model | isLoading = False }, Cmd.none )

        ChangePage pageUrl ->
            ( { model | isLoading = True }, fetchPokemons (Just pageUrl) )

        LoadDetails url ->
            ( { model | pokemonDetail = (PokemonDetail "" "" "" [] True) }, fetchPokemonDetails url )

        FetchPokemonDetails (Ok response) ->
            ( { model | pokemonDetail = response }, Cmd.none )

        FetchPokemonDetails (Err _) ->
            ( model, Cmd.none )



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        api =
            ApiResponse
                0
                []
                Nothing
                Nothing
    in
        ( Model True api (PokemonDetail "" "" "" [] False)
        , fetchPokemons Nothing
        )
