port module Main exposing (Model, Msg(..), init, main, update, view)

-- import CodeMirror exposing (..)

import AppState exposing (AppState(..))
import Browser
import Dict exposing (Dict)
import Html exposing (Attribute, Html, a, code, div, h1, input, li, pre, text, textarea, ul)
import Html.Attributes exposing (attribute, class, placeholder, type_)
import Html.Events exposing (on, onClick, onInput, stopPropagationOn, targetValue)
import Http
import Json.Decode as Decode exposing (Decoder, dict, list, string)
import Json.Decode.Pipeline exposing (hardcoded, required, resolve)
import Json.Encode as Encode exposing (string)
import Markdown exposing (toHtml)
import Markdown.Block as Block exposing (Block, CodeBlock, defaultHtml)
import Markdown.Config exposing (HtmlOption(..), Options)
import Url.Builder as Builder



-- import String exposing (String, repl)
---- MODEL ----


type alias Model =
    { code : String
    , activeDocContent : Maybe String
    , activeDocName : Maybe String
    , docList : Dict String (List File)
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
            div [] [ text "init loading" ]

        Loaded maybeError ->
            div []
                [ case maybeError of
                    Just error ->
                        text <| "Error: " ++ Debug.toString error

                    Nothing ->
                        text ""
                , mainView model
                ]

        Loading ->
            div [] [ text "loading..." ]

        LoadingError error ->
            div [] [ text <| Debug.toString error ]


mainView : Model -> Html Msg
mainView model =
    div []
        [ navBar
        , sideMenu <| .docList model
        , article <| .activeDocContent model
        ]


navBar : Html msg
navBar =
    div [ class "navbar" ]
        [ h1 [] [ text "Zalora Styleguide 2.0" ] ]


sideMenu : Dict String (List File) -> Html Msg
sideMenu docs =
    div [ class "sidebar" ]
        [ div [ class "sidebar__search" ]
            [ input [ class "sidebar__search--input", type_ "input", placeholder "Type to search" ] [] ]
        , sideMenuList docs
        ]


sideMenuList : Dict String (List File) -> Html Msg
sideMenuList docMap =
    let
        subList : ( String, List File ) -> Html Msg
        subList ( category, fileList ) =
            div []
                [ a [] [ text category ]
                , ul [] <|
                    List.map (\i -> item i) fileList
                ]

        item : File -> Html Msg
        item file =
            li [ onClick (SelectFile file), class "sidebar__filename", attribute "data-path" <| .path file ] [ text <| .name file ]
    in
    ul [] <| List.map (\s -> subList s) (Dict.toList docMap)


article : Maybe String -> Html msg
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
    case doc of
        Just value ->
            value
                |> Block.parse (Just options)
                |> List.map customHtmlBlock
                |> List.concat
                |> div [ class "article" ]

        Nothing ->
            div [ class "article" ] [ text "Welcome to our new styleguide!" ]



---- UPDATE ----


type Msg
    = InitView (Result Http.Error (Dict String (List File)))
    | SelectFile File
    | FileLoaded (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { appState } =
            model
    in
    case msg of
        InitView data ->
            case data of
                Ok docList ->
                    ( { model | docList = docList, appState = AppState.toSuccess appState }, Cmd.none )

                Err error ->
                    ( { model | appState = AppState.toFailure error appState }, Cmd.none )

        FileLoaded data ->
            case data of
                Ok doc ->
                    ( { model | activeDocContent = Just doc, appState = AppState.toSuccess appState }, highlight "test" )

                Err error ->
                    ( { model | activeDocContent = Just "Fail to load content", appState = AppState.toFailure error appState }, Cmd.none )

        SelectFile file ->
            ( { model | activeDocName = Just (.name file), appState = AppState.toLoading appState }, loadFile file )


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
    ( { code = ""
      , activeDocContent = Nothing
      , activeDocName = Nothing
      , docList = Dict.fromList []
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
