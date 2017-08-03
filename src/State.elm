module State exposing (init, update)

import Types exposing (Model, Msg(..))
import Pokemons.State


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        PokemonsMsg subMsg ->
            let
                ( newApiResponse, cmd ) =
                    Pokemons.State.update subMsg model.pokemons
            in
                ( { model | pokemons = newApiResponse }, Cmd.map PokemonsMsg cmd )



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        ( pokemonsModel, pokemonsCmd ) =
            Pokemons.State.init
    in
        ( Model pokemonsModel
        , Cmd.map PokemonsMsg pokemonsCmd
        )
