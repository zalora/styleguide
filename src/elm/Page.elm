module Page exposing (pageView)

import Browser
import Html exposing (Html, a, div, img, li, small, text, ul)
import Html.Attributes as Attr exposing (alt, class, href, src)
import Route exposing (href)


pageView : { title : String, view : List (Html msg) } -> Browser.Document msg
pageView { title, view } =
    { title = "Style -" ++ title
    , body = currentPage view
    }


currentPage : List (Html msg) -> List (Html msg)
currentPage content =
    viewHeader :: content


viewHeader : Html msg
viewHeader =
    div [ class "navbar align-items-center justify-content-start" ]
        [ a [ class "navbar__logo", Route.href Route.Home ] [ img [ src "/assets/primary_logo_white.png", alt "ZALORA" ] [] ]
        , ul [ class "navbar__nav" ]
            [ li [ class "navbar__navItem" ] [ a [ class "u-text-white", Route.href Route.Components ] [ text "Documentation" ] ]
            , li [ class "navbar__navItem" ] [ a [ class "u-text-white", Route.href Route.Guides ] [ text "Guide" ] ]
            , li [ class "navbar__navItem" ] [ a [ class "u-text-white", Route.href Route.Playground ] [ text "Playground" ] ]
            ]
        ]
