module Main exposing (Model, Msg(..), init, main, update, view)

-- import CodeMirror exposing (..)

import AppState exposing (AppState(..))
import Browser
import Html exposing (Attribute, Html, a, code, div, h1, input, li, pre, text, textarea, ul)
import Html.Attributes exposing (attribute, class, placeholder, type_)
import Html.Events exposing (on, onClick, onInput, stopPropagationOn, targetValue)
import Http
import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required, resolve)
import Json.Encode as Encode exposing (string)
import Markdown exposing (toHtml)
import Markdown.Block as Block exposing (Block, CodeBlock, defaultHtml)
import Markdown.Config exposing (HtmlOption(..), Options)
import Port exposing (highlight)
import Url.Builder as Builder



-- import String exposing (String, repl)
---- MODEL ----


type alias Model =
    { code : String
    , activeDoc : Maybe Doc
    , docList : List String
    , appState : AppState Http.Error
    }


type alias Doc =
    { name : String
    , content : String
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
        , article <| .activeDoc model
        ]


navBar : Html msg
navBar =
    div [ class "navbar" ]
        [ h1 [] [ text "Zalora Styleguide 2.0" ] ]


sideMenu : List String -> Html Msg
sideMenu docs =
    div [ class "sidebar" ]
        [ div [ class "sidebar__search" ]
            [ input [ class "sidebar__search--input", type_ "input", placeholder "Type to search" ] [] ]
        , fileList docs
        ]


fileList : List String -> Html Msg
fileList docnames =
    let
        item : String -> Html Msg
        item name =
            li [ onClick (SelectFile name), class "sidebar__filename" ] [ text <| String.replace ".md" "" name ]
    in
    ul [] <| List.map (\name -> item name) docnames


article : Maybe Doc -> Html msg
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
            .content value
                |> Block.parse (Just options)
                |> List.map customHtmlBlock
                |> List.concat
                |> div [ class "article" ]

        Nothing ->
            div [ class "article" ] [ text "Welcome to our new styleguide!" ]



---- UPDATE ----


type Msg
    = InitView (Result Http.Error (List String))
    | SelectFile String
    | FileLoaded (Result Http.Error Doc)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { activeDoc, appState } =
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
                    ( { model | activeDoc = Just doc, appState = AppState.toSuccess appState }, highlight "test" )

                Err error ->
                    ( { model | appState = AppState.toFailure error appState }, Cmd.none )

        SelectFile filename ->
            ( { model | appState = AppState.toLoading appState }, loadFile filename )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- INIT ----


init : ( Model, Cmd Msg )
init =
    let
        cmd =
            Decode.list Decode.string
                |> Http.get "/docList"
                |> Http.send InitView
    in
    ( { code = ""
      , activeDoc = Nothing
      , docList = []
      , appState = AppState.init
      }
    , cmd
    )


loadFile : String -> Cmd Msg
loadFile filename =
    let
        url =
            Builder.absolute [ "file" ] [ Builder.string "name" filename ]

        docDecoder : Decoder Doc
        docDecoder =
            Decode.succeed Doc
                |> required "name" Decode.string
                |> required "content" Decode.string
    in
    docDecoder
        |> Http.get url
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
