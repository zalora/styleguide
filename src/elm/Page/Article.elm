module Page.Article exposing (Model, Msg, init, update, view)

import AppState exposing (AppState(..))
import Array
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Html exposing (Attribute, Html, a, button, div, input, label, li, main_, table, tbody, td, text, th, thead, tr, ul)
import Html.Attributes exposing (class, classList, for, id, property, style, type_)
import Html.Events exposing (onClick, onInput)
import Http exposing (Error, expectJson, expectString, get)
import Json.Decode as Decode exposing (Decoder, list, string)
import List exposing (head)
import Markdown exposing (toHtml)
import Markdown.Block as Block exposing (Block, CodeBlock, defaultHtml)
import Markdown.Config exposing (HtmlOption(..), Options)
import Markdown.Inline as Inline exposing (Inline)
import Maybe exposing (withDefault)
import Regex
import Route exposing (href)
import String exposing (contains, isEmpty, toLower)
import Url.Builder exposing (absolute)
import Util exposing (codeSnippet, loading, menuIcon)



-- MODEL


type alias Model =
    { title : Maybe String
    , content : Maybe String
    , category : String
    , fileList : List String
    , shownFileList : List String
    , appState : AppState Http.Error
    , compact : Bool
    , searchValue : String
    }


type alias ImgMetadata =
    { class : String
    , tag : String
    , caption : String
    }



-- INIT


init : String -> Maybe String -> ( Model, Cmd Msg )
init category maybeTitle =
    let
        decoder : Decoder (List String)
        decoder =
            Decode.list (Decode.map (String.replace ".md" "") Decode.string)
    in
    ( { title = maybeTitle
      , content = Nothing
      , category = category
      , fileList = []
      , shownFileList = []
      , appState = AppState.init
      , compact = False
      , searchValue = ""
      }
    , Http.get
        { url = "/pages/" ++ category ++ "/fileList.json"
        , expect = expectJson InitView decoder
        }
    )



-- VIEW


view : Model -> Html Msg
view model =
    let
        { appState } =
            model
    in
    case appState of
        InitLoading ->
            main_ [] [ loading ]

        Loaded maybeError ->
            main_ []
                [ case maybeError of
                    Just error ->
                        text <| "Error: " ++ Debug.toString error

                    Nothing ->
                        main_ []
                            [ div [ class "row u-padding-horizontal-m" ]
                                [ sideMenu model
                                , article <| .content model
                                ]
                            ]
                ]

        Loading ->
            main_ [] [ loading ]

        LoadingError error ->
            main_ [] [ text <| Debug.toString error ]


sideMenu : Model -> Html Msg
sideMenu model =
    div [ class "col-sm-4 col-md-2 col-l-2 sideMenu" ]
        [ div [ class "row justify-content-between" ]
            [ div [ class "textField col" ]
                [ input [ id "searchArticle", classList [ ( "has-value", not (isEmpty <| .searchValue model) ) ], type_ "text", onInput SearchArticle ] []
                , label [ for "searchArticle" ] [ text "Search ..." ]
                ]
            , button [ class "btn btn--outline articleListToggle", onClick ToggleArticleList ] [ Util.menuIcon ]
            ]
        , List.map (\s -> listItem (.category model) s (s == withDefault "" (.title model))) (.shownFileList model)
            |> ul [ class "list collapse__target articleList", showList <| .compact model ]
        ]


listItem : String -> String -> Bool -> Html msg
listItem category fileName isActive =
    li [ classList [ ( "list__item", True ), ( "u-font-weight-bold", isActive ) ] ]
        [ a [ class "listItem__text", Route.href <| getCategoryRoute category fileName ]
            [ div [ class "listItemText__title" ] [ text fileName ] ]
        ]


article : Maybe String -> Html msg
article content =
    let
        tableRegex : Regex.Regex
        tableRegex =
            withDefault Regex.never <| Regex.fromString " *\\|(.+)\n *\\|( *[-:]+[-| :]*)\n((?: *\\|.*(?:\n|$))*)\n*"

        leftAlign : Regex.Regex
        leftAlign =
            withDefault Regex.never <| Regex.fromString ":-+[^-:]"

        rightAlign : Regex.Regex
        rightAlign =
            withDefault Regex.never <| Regex.fromString "[^:-]-+:"

        centerAlign : Regex.Regex
        centerAlign =
            withDefault Regex.never <| Regex.fromString ":-+:"

        leadingTrailingDivider : Regex.Regex
        leadingTrailingDivider =
            withDefault Regex.never <| Regex.fromString "^\\||\\|$"

        options : Options
        options =
            { softAsHardLineBreak = False
            , rawHtml = ParseUnsafe
            }

        customHtmlInline : Inline i -> Html msg
        customHtmlInline inline =
            case inline of
                Inline.Image url maybeTitle inlines ->
                    case maybeTitle of
                        Just title ->
                            let
                                className =
                                    if String.startsWith "Do[" title then
                                        "figure-caption__tag do"

                                    else if String.startsWith "Don't[" title then
                                        "figure-caption__tag dont"

                                    else
                                        ""

                                tag =
                                    if String.startsWith "Do[" title then
                                        "Do"

                                    else if String.startsWith "Don't[" title then
                                        "Don't"

                                    else
                                        ""

                                caption =
                                    if String.startsWith "Do[" title then
                                        String.slice 3 -1 title

                                    else if String.startsWith "Don't[" title then
                                        String.slice 6 -1 title

                                    else
                                        title
                            in
                            Html.figure [ class "col-sm-4 col-md-3 col-lg-5 offset-lg-1 figure" ]
                                [ Html.img
                                    [ Html.Attributes.alt (Inline.extractText inlines)
                                    , Html.Attributes.src url
                                    ]
                                    []
                                , Html.figcaption []
                                    [ Html.div [ class className ] [ text tag ]
                                    , Html.div [ class "figure-caption__text" ] [ text caption ]
                                    ]
                                ]

                        Nothing ->
                            Html.div
                                [ class "lightbox" ]
                                [ Html.img
                                    [ class "lightbox__img"
                                    , Html.Attributes.alt (Inline.extractText inlines)
                                    , Html.Attributes.src url
                                    ]
                                    []
                                ]

                _ ->
                    Inline.defaultHtml (Just customHtmlInline) inline

        customHtmlBlock : Block b i -> List (Html msg)
        customHtmlBlock block =
            case block of
                Block.CodeBlock codeblock codestr ->
                    [ div [ class "example" ]
                        [ div [ class "example__preview" ] [ Util.codePreview codestr ]
                        , div [ class "example__codeblock" ] [ Util.codeSnippet codestr ]
                        ]
                    ]

                Block.Paragraph blk inlineList ->
                    case Regex.contains tableRegex blk of
                        True ->
                            let
                                tableRows : List String
                                tableRows =
                                    String.split "\n" blk
                                        |> List.map (\str -> Regex.replace leadingTrailingDivider (\_ -> "") str)

                                tableAlignment : Array.Array String
                                tableAlignment =
                                    List.drop 1 tableRows
                                        |> List.head
                                        |> withDefault ""
                                        |> String.split "|"
                                        |> List.map
                                            (\align ->
                                                if Regex.contains leftAlign align then
                                                    "left"

                                                else if Regex.contains rightAlign align then
                                                    "right"

                                                else if Regex.contains centerAlign align then
                                                    "center"

                                                else
                                                    "left"
                                            )
                                        |> Array.fromList

                                tableHeader : Html msg
                                tableHeader =
                                    List.head tableRows
                                        |> withDefault ""
                                        |> String.split "|"
                                        |> Array.fromList
                                        |> Array.indexedMap
                                            (\i a ->
                                                th
                                                    [ style "text-align" (withDefault "left" <| Array.get i tableAlignment) ]
                                                    (toHtml Nothing a)
                                            )
                                        |> Array.toList
                                        |> tr []

                                tableBody : Html msg
                                tableBody =
                                    let
                                        tableBodyRow : String -> Html msg
                                        tableBodyRow str =
                                            String.split "|" str
                                                |> Array.fromList
                                                |> Array.indexedMap
                                                    (\i a ->
                                                        td
                                                            [ style "text-align" (withDefault "left" <| Array.get i tableAlignment) ]
                                                            (toHtml Nothing a)
                                                    )
                                                |> Array.toList
                                                |> tr []
                                    in
                                    List.drop 2 tableRows
                                        |> List.map (\s -> tableBodyRow s)
                                        |> tbody []
                            in
                            [ table [] [ thead [] [ tableHeader ], tableBody ] ]

                        False ->
                            Block.defaultHtml
                                (Just customHtmlBlock)
                                (Just customHtmlInline)
                                block

                _ ->
                    Block.defaultHtml
                        (Just customHtmlBlock)
                        (Just customHtmlInline)
                        block
    in
    withDefault "" content
        |> Block.parse (Just options)
        |> List.map customHtmlBlock
        |> List.concat
        |> div [ class "col-sm-4 col-md-6 col-l-10 u-padding-l" ]



-- UPDATE


type Msg
    = InitView (Result Http.Error (List String))
    | SearchArticle String
    | FileLoaded (Result Http.Error String)
    | ToggleArticleList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { appState, fileList, title, category, compact } =
            model
    in
    case msg of
        InitView data ->
            case data of
                Ok value ->
                    let
                        ( currentTitle, cmd ) =
                            case title of
                                Nothing ->
                                    case head value of
                                        Just name ->
                                            ( Just name
                                            , Http.get
                                                { url = "/pages/" ++ category ++ "/" ++ name ++ ".md"
                                                , expect = expectString FileLoaded
                                                }
                                            )

                                        Nothing ->
                                            ( Nothing, Cmd.none )

                                Just fileName ->
                                    ( Just fileName
                                    , Http.get
                                        { url = "/pages/" ++ category ++ "/" ++ fileName ++ ".md"
                                        , expect = expectString FileLoaded
                                        }
                                    )
                    in
                    ( { model | fileList = value, shownFileList = value, appState = AppState.toSuccess appState, title = currentTitle }, cmd )

                Err error ->
                    ( { model | appState = AppState.toFailure error appState }, Cmd.none )

        FileLoaded data ->
            case data of
                Ok file ->
                    ( { model | content = Just file, title = title, appState = AppState.toSuccess appState }, Cmd.none )

                Err error ->
                    ( { model | content = Just "Fail to load content", appState = AppState.toFailure error appState }, Cmd.none )

        SearchArticle input ->
            ( { model | shownFileList = fileFilter input fileList, searchValue = input }, Cmd.none )

        ToggleArticleList ->
            ( { model | compact = not compact }, Cmd.none )


fileFilter : String -> List String -> List String
fileFilter input fileList =
    List.filter (\file -> contains (toLower input) (toLower file)) fileList


showList : Bool -> Attribute msg
showList display =
    case display of
        True ->
            style "height" "100%"

        False ->
            style "height" "0"


getCategoryRoute : String -> String -> Route.Route
getCategoryRoute category name =
    case category of
        "components" ->
            Route.Component name

        "guides" ->
            Route.Guide name

        _ ->
            Route.NotFound
