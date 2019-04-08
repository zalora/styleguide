module Page.Playground exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Html exposing (Attribute, Html, div, h1, main_, text)
import Html.Attributes exposing (attribute, class, id, property)
import Html.Events exposing (on)
import Json.Decode exposing (at, map, string)
import Json.Encode exposing (string)



-- MODEL


type alias Model =
    { title : String
    , code : String
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { title = "Playground"
      , code = "<!-- Try @zalora/style here -->"
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Html Msg
view model =
    main_ [ class "container--fluid" ]
        [ div [ class "playground" ]
            [ h1 [] [ text "Playground" ]
            , div [ class "playground__wrapper" ]
                [ div
                    [ id "playground__preview"
                    , class "playground__preview"
                    , attribute "data-html" <| .code model
                    ]
                    []
                , codeEditor
                    [ class "playground__editor"
                    , editorValue <| .code model
                    , onEditorChanged CodeChanged
                    ]
                ]
            ]
        ]


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



-- UPDATE


type Msg
    = CodeChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CodeChanged code ->
            ( { model | code = code }, Cmd.none )
