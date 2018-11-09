module UI exposing (loading)

import Html exposing (Html, div)
import Html.Attributes exposing (class)


loading : Html msg
loading =
    div [ class "loading__icon" ]
        [ div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        ]
