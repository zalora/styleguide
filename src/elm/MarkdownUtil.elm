module MarkdownUtil exposing (centerAlign, customHtmlBlock, customHtmlInline, leadingTrailingDivider, leftAlign, options, rightAlign, tableRegex)

import Array
import Html exposing (Html)
import Html.Attributes as Attr
import Markdown exposing (toHtml)
import Markdown.Block as Block exposing (Block, CodeBlock, defaultHtml)
import Markdown.Config exposing (HtmlOption(..), Options)
import Markdown.Inline as Inline exposing (Inline)
import Maybe exposing (withDefault)
import Regex
import UI


tableRegex : Regex.Regex
tableRegex =
    withDefault Regex.never <| Regex.fromString " *\\|(.+)\n *\\|( *[-:]+[-| :]*)\n((?: *\\|.*(?:\n|$))*)\n*"


leftAlign : Regex.Regex
leftAlign =
    withDefault Regex.never <| Regex.fromString ":-+[^-:]"


rightAlign : Regex.Regex
rightAlign =
    withDefault Regex.never <| Regex.fromString "[^:-]-+:"


centerAlign : Regex.Regex
centerAlign =
    withDefault Regex.never <| Regex.fromString ":-+:"


leadingTrailingDivider : Regex.Regex
leadingTrailingDivider =
    withDefault Regex.never <| Regex.fromString "^\\||\\|$"


options : Options
options =
    { softAsHardLineBreak = False
    , rawHtml = ParseUnsafe
    }


customHtmlInline : Inline i -> Html msg
customHtmlInline inline =
    case inline of
        Inline.Image url maybeTitle inlines ->
            case maybeTitle of
                Just title ->
                    let
                        className =
                            if String.startsWith "Do[" title then
                                "figure-caption__tag do"

                            else if String.startsWith "Don't[" title then
                                "figure-caption__tag dont"

                            else
                                ""

                        tag =
                            if String.startsWith "Do[" title then
                                "Do"

                            else if String.startsWith "Don't[" title then
                                "Don't"

                            else
                                ""

                        caption =
                            if String.startsWith "Do[" title then
                                String.slice 3 -1 title

                            else if String.startsWith "Don't[" title then
                                String.slice 6 -1 title

                            else
                                title
                    in
                    Html.figure [ Attr.class "col-sm-4 col-md-3 col-lg-5 offset-lg-1 figure" ]
                        [ Html.img
                            [ Attr.alt (Inline.extractText inlines)
                            , Attr.src url
                            ]
                            []
                        , Html.figcaption []
                            [ Html.div [ Attr.class className ] [ Html.text tag ]
                            , Html.div [ Attr.class "figure-caption__text" ] [ Html.text caption ]
                            ]
                        ]

                Nothing ->
                    Html.div
                        [ Attr.class "lightbox" ]
                        [ Html.img
                            [ Attr.class "lightbox__img"
                            , Attr.alt (Inline.extractText inlines)
                            , Attr.src url
                            ]
                            []
                        ]

        _ ->
            Inline.defaultHtml (Just customHtmlInline) inline


customHtmlBlock : Block b i -> List (Html msg)
customHtmlBlock block =
    case block of
        Block.CodeBlock codeblock codestr ->
            [ Html.div [ Attr.class "example" ]
                [ Html.div [ Attr.class "example__preview" ] [ UI.codePreview codestr ]
                , Html.div [ Attr.class "example__codeblock" ] [ UI.codeSnippet codestr ]
                ]
            ]

        Block.Paragraph blk inlineList ->
            case Regex.contains tableRegex blk of
                True ->
                    let
                        tableRows : List String
                        tableRows =
                            String.split "\n" blk
                                |> List.map (\str -> Regex.replace leadingTrailingDivider (\_ -> "") str)

                        tableAlignment : Array.Array String
                        tableAlignment =
                            List.drop 1 tableRows
                                |> List.head
                                |> withDefault ""
                                |> String.split "|"
                                |> List.map
                                    (\align ->
                                        if Regex.contains leftAlign align then
                                            "left"

                                        else if Regex.contains rightAlign align then
                                            "right"

                                        else if Regex.contains centerAlign align then
                                            "center"

                                        else
                                            "left"
                                    )
                                |> Array.fromList

                        tableHeader : Html msg
                        tableHeader =
                            List.head tableRows
                                |> withDefault ""
                                |> String.split "|"
                                |> Array.fromList
                                |> Array.indexedMap
                                    (\i a ->
                                        Html.th
                                            [ Attr.style "text-align" (withDefault "left" <| Array.get i tableAlignment) ]
                                            (toHtml Nothing a)
                                    )
                                |> Array.toList
                                |> Html.tr []

                        tableBody : Html msg
                        tableBody =
                            let
                                tableBodyRow : String -> Html msg
                                tableBodyRow str =
                                    String.split "|" str
                                        |> Array.fromList
                                        |> Array.indexedMap
                                            (\i a ->
                                                Html.td
                                                    [ Attr.style "text-align" (withDefault "left" <| Array.get i tableAlignment) ]
                                                    (toHtml Nothing a)
                                            )
                                        |> Array.toList
                                        |> Html.tr []
                            in
                            List.drop 2 tableRows
                                |> List.map (\s -> tableBodyRow s)
                                |> Html.tbody []
                    in
                    [ Html.table [] [ Html.thead [] [ tableHeader ], tableBody ] ]

                False ->
                    Block.defaultHtml
                        (Just customHtmlBlock)
                        (Just customHtmlInline)
                        block

        _ ->
            Block.defaultHtml
                (Just customHtmlBlock)
                (Just customHtmlInline)
                block
