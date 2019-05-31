module Page.Home exposing (view)

import Html exposing (Html, code, div, h1, h4, li, main_, p, strong, text, ul)
import Html.Attributes exposing (class, tabindex)



-- VIEW


view : Html msg
view =
    main_ [ class "container--fluid", tabindex -1 ]
        [ h1 [ class "row justify-content-center u-margin-top-xl" ] [ text "ZALORA Style" ]
        , h4 [ class "row justify-content-center u-text-center" ] [ text "Style is built in a scalable, reusable way that ensures consistency, low cost of changes and a balance between creativity and efficiency. Start to build a responsive, mobile-first project with Style today!" ]
        , div [ class "divider" ] []
        , div [ class "row" ]
            [ div [ class "col-sm-4 col-lg" ]
                [ h4 [] [ text "Installation" ]
                , div []
                    [ text "Install @zalora/style's source files via npm. The installed package also includes the original SASS and demostration HTML for building the project."
                    , code [ class "code--block" ] [ text "$ npm install @zalora/style" ]
                    ]
                ]
            , div [ class "col-sm-4 col-lg" ]
                [ h4 [] [ text "Usage" ]
                , div []
                    [ text "To use @zalora/style you can inject the "
                    , strong [] [ text "style.css" ]
                    , text " into your html file."
                    , div [] [ text "Or you can import @zalora/style into your js file as a css module" ]
                    , code [ class "code--block" ] [ text "import Style from '@zalora/style'" ]
                    ]
                ]
            , div [ class "col-sm-4 col-lg" ]
                [ h4 [] [ text "Vision" ]
                , p [] [ text "Through our UI, customers will" ]
                , ul []
                    [ li [] [ text "Enjoy an enriching, unified experience whether they’re new or returning customers" ]
                    , li [] [ text "Be inspired by our clean canvas, content, products, and banners" ]
                    , li [] [ text "Find all the information they need, in a quick and timely manner" ]
                    , li [] [ text "Be guided throughout their shopping journey on ZALORA" ]
                    ]
                ]
            ]
        ]
