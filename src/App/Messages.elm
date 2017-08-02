module App.Messages exposing (..)

import Http
import App.Models exposing (Model)


type Msg
    = NoOp
    | FetchAll (Result Http.Error Model)
