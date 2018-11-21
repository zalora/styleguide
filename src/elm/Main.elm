module Main exposing (Model, Msg(..), init, main, update, view)

import AppState exposing (AppState(..))
import Browser
import CodeEditor exposing (playground)
import Dict exposing (Dict)
import Html exposing (Attribute, Html, a, code, div, input, li, pre, text, textarea, ul)
import Html.Attributes exposing (attribute, class, placeholder, type_)
import Html.Events exposing (on, onClick, onInput, stopPropagationOn, targetValue)
import Http
import Json.Decode as Decode exposing (Decoder, dict, list, string)
import Json.Decode.Pipeline exposing (hardcoded, required, resolve)
import Json.Encode as Encode exposing (string)
import UI exposing (article, loading, navBar)
import Url.Builder as Builder



---- MODEL ----


type alias Model =
    { code : String
    , activeFileContent : Maybe String
    , activeFileName : Maybe String
    , fileList : Dict String (List File)
    , shownfileList : Dict String (List File)
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


sideMenu : Model -> Html Msg
sideMenu model =
    div [ class "sidebar" ]
        [ div [ class "sidebar__search" ]
            [ input [ class "sidebar__search--input", type_ "input", placeholder "Type to search", onInput SearchArticle ] [] ]
        , ul [] <| List.map (\s -> categoryList s (.activeFileName model)) (Dict.toList <| .shownfileList model)
        ]


categoryList : ( String, List File ) -> Maybe String -> Html Msg
categoryList ( category, fileList ) activeFile =
    div []
        [ a [ class "sidebar__category" ] [ text category ]
        , ul [] <|
            List.map (\i -> categoryItem i activeFile) fileList
        ]


categoryItem : File -> Maybe String -> Html Msg
categoryItem file activeFile =
    let
        className =
            if .name file == Maybe.withDefault "" activeFile then
                "sidebar__filename--active"

            else
                "sidebar__filename"
    in
    li [ onClick (SelectFile file), class className, attribute "data-path" <| .path file ] [ text <| .name file ]


mainContent : Model -> Html Msg
mainContent model =
    div [ class "main" ] <|
        case .activeFileContent model of
            Just value ->
                [ article value
                , playground (.code model) CodeChanged
                ]

            Nothing ->
                [ text "Welcome to our new styleguide!" ]



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
        { appState, fileList } =
            model
    in
    case msg of
        InitView data ->
            case data of
                Ok value ->
                    ( { model | fileList = value, shownfileList = value, appState = AppState.toSuccess appState }, Cmd.none )

                Err error ->
                    ( { model | appState = AppState.toFailure error appState }, Cmd.none )

        FileLoaded data ->
            case data of
                Ok file ->
                    ( { model | activeFileContent = Just file, shownfileList = fileList, appState = AppState.toSuccess appState }, Cmd.none )

                Err error ->
                    ( { model | activeFileContent = Just "Fail to load content", appState = AppState.toFailure error appState }, Cmd.none )

        SelectFile file ->
            ( { model | activeFileName = Just (.name file), appState = AppState.toLoading appState }, loadFile file )

        CodeChanged code ->
            ( { model | code = code }, Cmd.none )

        SearchArticle input ->
            ( { model | shownfileList = filterCategoriesAndFiles input fileList }, Cmd.none )


loadFile : File -> Cmd Msg
loadFile file =
    let
        url =
            Builder.relative [ .path file ] []
    in
    Http.getString url
        |> Http.send FileLoaded


filterCategoriesAndFiles : String -> Dict String (List File) -> Dict String (List File)
filterCategoriesAndFiles keyword fileList =
    let
        map : String -> ( String, List File ) -> ( String, List File )
        map input categoryFileMap =
            if String.contains (String.toLower input) (String.toLower <| Tuple.first categoryFileMap) then
                categoryFileMap

            else
                Tuple.mapSecond (filterFile input) categoryFileMap

        filterFile input list =
            list
                |> List.filter (\f -> String.contains (String.toLower input) (String.toLower <| .name f))
    in
    Dict.toList fileList
        |> List.map (\list -> map keyword list)
        |> List.filter (\list -> List.length (Tuple.second list) /= 0)
        |> Dict.fromList



---- SUBSCRIPTIONS ----


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
      , activeFileContent = Nothing
      , activeFileName = Nothing
      , fileList = Dict.fromList []
      , shownfileList = Dict.fromList []
      , appState = AppState.init
      }
    , cmd
    )



---- PROGRAM ----


main : Program {} Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
