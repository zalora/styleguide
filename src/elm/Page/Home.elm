module Page.Home exposing (view)

import Html as Html exposing (Html)
import Html.Attributes as Attr



-- VIEW


view : Html msg
view =
    Html.main_ [ Attr.class "container--fluid", Attr.tabindex -1 ]
        [ Html.h1
            [ Attr.class "row justify-content-center align-items-center u-margin-vertical-xl" ]
            [ Html.text "ZALORA Style"
            , Html.img [ Attr.src "assets/palatte.png" ] []
            ]
        , Html.h4 [ Attr.class "row justify-content-center u-Html.text-center" ] [ Html.text "Style is built in a scalable, reusable way that ensures consistency, low cost of changes and a balance between creativity and efficiency. Start to build a responsive, mobile-first project with Style today!" ]
        , Html.div [ Attr.class "Html.divider u-margin-vertical-xl" ] []
        , Html.div [ Attr.class "row" ]
            [ Html.div [ Attr.class "col-sm-4 col-lg" ]
                [ Html.h4 [] [ Html.text "Installation" ]
                , Html.div []
                    [ Html.text "Install @zalora/style's source files via npm. The installed package also includes the original SASS and demostration HTML for building the project."
                    , Html.code [ Attr.class "code--block" ] [ Html.text "$ npm install @zalora/style" ]
                    ]
                ]
            , Html.div [ Attr.class "col-sm-4 col-lg" ]
                [ Html.h4 [] [ Html.text "React Components" ]
                , Html.div []
                    [ Html.a [ Attr.href "https://zalora.github.io/style-react", Attr.target "_blank" ] [ Html.text "@zalora/style-react \u{00A0}" ]
                    , Html.text "implements all components in style using React components"
                    , Html.code [ Attr.class "code--block" ] [ Html.text "$ npm install @zalora/style-react" ]
                    , Html.div [ Attr.class "u-Html.text-grey-60" ]
                        [ Html.text "Both @zalora/style and @zalora/style-react are private. To download them, you need to be a member of"
                        , Html.a [ Attr.href "https://www.npmjs.com/settings/zalora/members", Attr.target "_blank" ] [ Html.text "\u{00A0} ZALORA" ]
                        ]
                    ]
                ]
            , Html.div [ Attr.class "col-sm-4 col-lg" ]
                [ Html.h4 [] [ Html.text "Vision" ]
                , Html.p [] [ Html.text "Through our UI, customers will" ]
                , Html.ul []
                    [ Html.li [] [ Html.text "Enjoy an enriching, unified experience whether they’re new or returning customers" ]
                    , Html.li [] [ Html.text "Be inspired by our clean canvas, content, products, and banners" ]
                    , Html.li [] [ Html.text "Find all the information they need, in a quick and timely manner" ]
                    , Html.li [] [ Html.text "Be guided throughout their shopping journey on ZALORA" ]
                    ]
                ]
            ]
        ]
