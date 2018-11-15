module CodeEditor exposing (codeEditor, editorValue, onEditorChanged)

import Html exposing (Attribute, Html)
import Html.Attributes exposing (property)
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
