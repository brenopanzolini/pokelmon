module State exposing (init, update)

import Types exposing (Model, Msg(..))
import Pokemons.State


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        PokemonsMsg subMsg ->
            let
                ( newPokemons, cmd ) =
                    Pokemons.State.update subMsg model.pokemons
            in
                { model | pokemons = newPokemons } ! [ Cmd.map PokemonsMsg cmd ]



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        ( pokemonsModel, pokemonsCmd ) =
            Pokemons.State.init

        cmds =
            Cmd.batch [ Cmd.map PokemonsMsg pokemonsCmd ]
    in
        ( Model pokemonsModel
        , cmds
        )
