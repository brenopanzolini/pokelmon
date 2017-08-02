module Main exposing (..)

import Html exposing (a, div, h1, ul, li, text)
import String.Extra exposing (toSentenceCase)
import Http
import Json.Decode as Decode exposing (Decoder)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\n -> Sub.none)
        }



-- MODEL


type alias Pokemon =
    { name : String
    , url : String
    }


type alias Model =
    { total : Int
    , pokemons : List Pokemon
    , prevPage : Maybe String
    , nextPage : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 [] Nothing Nothing
    , loadPokemons
    )



-- UPDATE


type Msg
    = LoadPokemons (Result Http.Error Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadPokemons (Ok model) ->
            ( model, Cmd.none )

        LoadPokemons (Err _) ->
            ( model, Cmd.none )



-- VIEW


viewPokemon : Pokemon -> Html.Html Msg
viewPokemon pokemon =
    li [] [ pokemon.name |> toSentenceCase |> text ]


view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "Pokelmon" ]
        , ul [] (List.map viewPokemon model.pokemons)
        ]



--HTTP


loadPokemons : Cmd Msg
loadPokemons =
    let
        url =
            "http://www.pokeapi.co/api/v2/pokemon"
    in
        Http.send LoadPokemons (Http.get url decode)



--DECODER


decodePokemon : Decoder Pokemon
decodePokemon =
    Decode.map2
        Pokemon
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "url" ] Decode.string)


decode : Decoder Model
decode =
    Decode.map4
        Model
        (Decode.at [ "count" ] Decode.int)
        (Decode.at [ "results" ] (Decode.list decodePokemon))
        (Decode.maybe (Decode.at [ "previous" ] Decode.string))
        (Decode.maybe (Decode.at [ "next" ] Decode.string))
