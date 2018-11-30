module CodeEditor exposing (codeEditor, editorValue, onEditorChanged, playground)

import Html exposing (Attribute, Html, div, h1, section, text)
import Html.Attributes exposing (attribute, class, id, property)
import Html.Events exposing (on)
import Json.Decode exposing (at, map, string)
import Json.Encode exposing (string)


codeEditor : List (Html.Attribute msg) -> Html msg
codeEditor attributes =
    Html.node "code-editor" attributes []


editorValue : String -> Html.Attribute msg
editorValue code =
    Html.Attributes.property "editorValue" <|
        Json.Encode.string code


onEditorChanged : (String -> msg) -> Html.Attribute msg
onEditorChanged toMsg =
    Html.Events.on "editorChanged" <|
        Json.Decode.map toMsg <|
            Json.Decode.at
                [ "target", "editorValue" ]
                Json.Decode.string


playground : String -> (String -> msg) -> Html msg
playground code toMsg =
    section [ class "playground" ]
        [ h1 [] [ text "Playground" ]
        , div [ class "playground__wrapper" ]
            [ div
                [ id "playground__preview"
                , class "playground__preview"
                , attribute "data-html" code
                ]
                []
            , codeEditor
                [ class "playground__editor"
                , editorValue code
                , onEditorChanged toMsg
                ]
            ]
        ]
