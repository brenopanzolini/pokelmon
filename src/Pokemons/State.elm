module Pokemons.State exposing (init, update)

import Pokemons.Types exposing (Model, ApiResponse, Msg(..))
import Pokemons.Rest exposing (fetchPokemons)


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
        ( Model True api
        , fetchPokemons Nothing
        )
