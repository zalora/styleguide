module Util exposing (codePreview, codeSnippet, loading, menuIcon, pageFooter)

import Html exposing (Html, a, div, footer, text)
import Html.Attributes exposing (class, href)
import Json.Encode exposing (string)
import Route exposing (Route)


menuIcon : Html msg
menuIcon =
    div [ class "menuIcon" ]
        [ div [] []
        , div [] []
        , div [] []
        ]


loading : Html msg
loading =
    div [ class "loadingIcon" ]
        [ div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        , div [] []
        ]


codeSnippet : String -> Html msg
codeSnippet code =
    Html.node "code-snippet" [ property "innerCode" code ] []


property : String -> String -> Html.Attribute msg
property propertyName code =
    Html.Attributes.property propertyName <|
        Json.Encode.string code


codePreview : String -> Html msg
codePreview code =
    Html.node "code-preview" [ property "srcdoc" code ] []


pageFooter : Html msg
pageFooter =
    footer [ class "footer u-bg-grey-100 u-text-white" ]
        [ div [ class "row" ]
            [ div [ class "col" ] [ a [ class "u-text-white", href "https://github.com/zalora/style" ] [ text "Github" ] ]
            , div [ class "col" ] [ a [ class "u-text-white", href "https://www.zalora.com" ] [ text "ZALORA" ] ]
            , div [ class "col" ] [ a [ class "u-text-white", Route.href <| Route.Component "color" ] [ text "Color" ] ]
            , div [ class "col" ] [ a [ class "u-text-white", Route.href <| Route.Guides ] [ text "Design Priciple" ] ]
            ]
        , div [ class "row u-margin-top-l" ]
            [ div [ class "col u-text-micro" ] [ text "Currently v1.4.0. Released under the Apache License 2.0" ] ]
        ]
