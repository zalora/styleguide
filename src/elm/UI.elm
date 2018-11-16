module UI exposing (article, loading, navBar)

import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import Json.Encode exposing (string)
import Markdown exposing (toHtml)
import Markdown.Block as Block exposing (Block, CodeBlock, defaultHtml)
import Markdown.Config exposing (HtmlOption(..), Options)


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


navBar : Html msg
navBar =
    div [ class "navbar" ]
        [ h1 [] [ text "Zalora Styleguide" ] ]


article : String -> Html msg
article file =
    let
        options : Options
        options =
            { softAsHardLineBreak = False
            , rawHtml = ParseUnsafe
            }

        customHtmlBlock : Block b i -> List (Html msg)
        customHtmlBlock block =
            case block of
                Block.CodeBlock codeblock codestr ->
                    [ div [ class "example" ]
                        [ div [ class "example__preview" ] <| Markdown.toHtml (Just options) codestr
                        , div [ class "example__codeblock" ] [ codeSnippet [ innerCode codestr ] ]
                        ]
                    ]

                _ ->
                    Block.defaultHtml
                        (Just customHtmlBlock)
                        Nothing
                        block
    in
    file
        |> Block.parse (Just options)
        |> List.map customHtmlBlock
        |> List.concat
        |> div [ class "article" ]


codeSnippet : List (Html.Attribute msg) -> Html msg
codeSnippet attributes =
    Html.node "code-snippet" attributes []


innerCode : String -> Html.Attribute msg
innerCode code =
    Html.Attributes.property "innerCode" <|
        Json.Encode.string code
