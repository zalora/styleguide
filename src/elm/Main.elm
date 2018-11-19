port module Main exposing (Model, Msg(..), init, main, update, view)

-- import CodeMirror exposing (..)

import AppState exposing (AppState(..))
import Browser
import CodeEditor exposing (codeEditor, editorValue, onEditorChanged)
import Dict exposing (Dict)
import Html exposing (Attribute, Html, a, code, div, h1, input, li, pre, section, text, textarea, ul)
import Html.Attributes exposing (attribute, class, id, placeholder, type_)
import Html.Events exposing (on, onClick, onInput, stopPropagationOn, targetValue)
import Http
import Json.Decode as Decode exposing (Decoder, dict, list, string)
import Json.Decode.Pipeline exposing (hardcoded, required, resolve)
import Json.Encode as Encode exposing (string)
import Markdown exposing (toHtml)
import Markdown.Block as Block exposing (Block, CodeBlock, defaultHtml)
import Markdown.Config exposing (HtmlOption(..), Options)
import UI exposing (loading)
import Url.Builder as Builder



-- import String exposing (String, repl)
---- MODEL ----


type alias Model =
    { code : String
    , activeDocContent : Maybe String
    , activeDocName : Maybe String
    , docList : Dict String (List File)
    , shownDocList : Dict String (List File)
    , appState : AppState Http.Error
    }


type alias File =
    { name : String
    , path : String
    }



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        { appState } =
            model
    in
    case appState of
        InitLoading ->
            div [] [ UI.loading ]

        Loaded maybeError ->
            div []
                [ case maybeError of
                    Just error ->
                        text <| "Error: " ++ Debug.toString error

                    Nothing ->
                        text ""
                , viewContainer model
                ]

        Loading ->
            div [] [ UI.loading ]

        LoadingError error ->
            div [] [ text <| Debug.toString error ]


viewContainer : Model -> Html Msg
viewContainer model =
    div [ class "grid-container" ]
        [ navBar
        , sideMenu model
        , mainContent model
        ]


navBar : Html msg
navBar =
    div [ class "navbar" ]
        [ h1 [] [ text "Zalora Styleguide" ] ]


sideMenu : Model -> Html Msg
sideMenu model =
    div [ class "sidebar" ]
        [ div [ class "sidebar__search" ]
            [ input [ class "sidebar__search--input", type_ "input", placeholder "Type to search", onInput SearchArticle ] [] ]
        , sideMenuList model
        ]


sideMenuList : Model -> Html Msg
sideMenuList model =
    ul [] <| List.map (\s -> categoryList s (.activeDocName model)) (Dict.toList <| .shownDocList model)


categoryList : ( String, List File ) -> Maybe String -> Html Msg
categoryList ( category, fileList ) activeFile =
    let
        isActiveFile : File -> Maybe String -> Bool
        isActiveFile file activeFileName =
            .name file == Maybe.withDefault "" activeFileName
    in
    div []
        [ a [ class "sidebar__category" ] [ text category ]
        , ul [] <|
            List.map (\i -> categoryItem i <| isActiveFile i activeFile) fileList
        ]


categoryItem : File -> Bool -> Html Msg
categoryItem file isActive =
    let
        className =
            if isActive then
                "sidebar__filename--active"

            else
                "sidebar__filename"
    in
    li [ onClick (SelectFile file), class className, attribute "data-path" <| .path file ] [ text <| .name file ]


mainContent : Model -> Html Msg
mainContent model =
    div [ class "main" ] <|
        case .activeDocContent model of
            Just value ->
                [ article value
                , playground <| .code model
                ]

            Nothing ->
                [ text "Welcome to our new styleguide!" ]


playground : String -> Html Msg
playground code =
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
                , CodeEditor.editorValue code
                , CodeEditor.onEditorChanged CodeChanged
                ]
            ]
        ]


article : String -> Html msg
article doc =
    let
        options : Options
        options =
            { softAsHardLineBreak = False
            , rawHtml = ParseUnsafe
            }

        customHtmlBlock : Block b i -> List (Html msg)
        customHtmlBlock block =
            let
                toHtmlCodeblock str =
                    "```html\n" ++ str ++ "\n```"
            in
            case block of
                Block.CodeBlock codeblock codestr ->
                    [ div [ class "example" ]
                        [ div [ class "example__preview" ] <| Markdown.toHtml (Just options) codestr
                        , div [ class "example__codeblock" ] <| Markdown.toHtml Nothing (toHtmlCodeblock codestr)
                        ]
                    ]

                _ ->
                    Block.defaultHtml
                        (Just customHtmlBlock)
                        Nothing
                        block
    in
    doc
        |> Block.parse (Just options)
        |> List.map customHtmlBlock
        |> List.concat
        |> div [ class "article" ]



---- UPDATE ----


type Msg
    = InitView (Result Http.Error (Dict String (List File)))
    | SelectFile File
    | FileLoaded (Result Http.Error String)
    | CodeChanged String
    | SearchArticle String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { appState, docList } =
            model
    in
    case msg of
        InitView data ->
            case data of
                Ok value ->
                    ( { model | docList = value, shownDocList = value, appState = AppState.toSuccess appState }, Cmd.none )

                Err error ->
                    ( { model | appState = AppState.toFailure error appState }, Cmd.none )

        FileLoaded data ->
            case data of
                Ok doc ->
                    ( { model | activeDocContent = Just doc, shownDocList = docList, appState = AppState.toSuccess appState }, highlight "test" )

                Err error ->
                    ( { model | activeDocContent = Just "Fail to load content", appState = AppState.toFailure error appState }, Cmd.none )

        SelectFile file ->
            ( { model | activeDocName = Just (.name file), appState = AppState.toLoading appState }, loadFile file )

        CodeChanged code ->
            ( { model | code = code }, setPreview code )

        SearchArticle input ->
            ( { model | shownDocList = filterCategoriesAndFiles input docList }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- INIT ----


init : ( Model, Cmd Msg )
init =
    let
        fileDecoder : Decoder File
        fileDecoder =
            Decode.succeed File
                |> required "name" Decode.string
                |> required "path" Decode.string

        cmd =
            Decode.dict (Decode.list fileDecoder)
                |> Http.get "/pages/categoryPostMap.json"
                |> Http.send InitView
    in
    ( { code = "<!-- try to write some html code here -->"
      , activeDocContent = Nothing
      , activeDocName = Nothing
      , docList = Dict.fromList []
      , shownDocList = Dict.fromList []
      , appState = AppState.init
      }
    , cmd
    )


loadFile : File -> Cmd Msg
loadFile file =
    let
        url =
            Builder.relative [ .path file ] []
    in
    Http.getString url
        |> Http.send FileLoaded


filterCategoriesAndFiles : String -> Dict String (List File) -> Dict String (List File)
filterCategoriesAndFiles keyword docList =
    let
        map : String -> ( String, List File ) -> ( String, List File )
        map input categoryFileMap =
            if String.contains (String.toLower input) (String.toLower <| Tuple.first categoryFileMap) then
                categoryFileMap

            else
                Tuple.mapSecond (filterFile input) categoryFileMap

        filterFile input fileList =
            fileList
                |> List.filter (\f -> String.contains (String.toLower input) (String.toLower <| .name f))
    in
    Dict.toList docList
        |> List.map (\list -> map keyword list)
        |> List.filter (\list -> List.length (Tuple.second list) /= 0)
        |> Dict.fromList



---- PROGRAM ----


main : Program {} Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



---- PORT -----


port highlight : String -> Cmd msg


port setPreview : String -> Cmd msg
