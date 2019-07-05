module Page.Article exposing (Model, Msg, init, update, view)

import AppState exposing (AppState(..))
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Http exposing (Error, expectJson, expectString, get)
import Json.Decode as Decode exposing (Decoder, list, string)
import List exposing (head)
import Markdown.Block
import MarkdownUtil
import Maybe exposing (withDefault)
import Route exposing (href)
import String
import UI
import Url.Builder exposing (absolute)



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
            Html.main_ [] [ UI.loading ]

        Loaded maybeError ->
            Html.main_ []
                [ case maybeError of
                    Just error ->
                        Html.text <| "Error: " ++ Debug.toString error

                    Nothing ->
                        Html.main_ []
                            [ Html.div [ Attr.class "row u-padding-horizontal-m" ]
                                [ sideMenu model
                                , article <| .content model
                                ]
                            ]
                ]

        Loading ->
            Html.main_ [] [ UI.loading ]

        LoadingError error ->
            Html.main_ [] [ Html.text <| Debug.toString error ]


sideMenu : Model -> Html Msg
sideMenu model =
    Html.div [ Attr.class "col-sm-4 col-md-2 col-l-2 sideMenu" ]
        [ Html.div [ Attr.class "row justify-content-between" ]
            [ Html.div [ Attr.class "textField col" ]
                [ Html.input
                    [ Attr.id "searchArticle"
                    , Attr.classList [ ( "has-value", not (String.isEmpty <| .searchValue model) ) ]
                    , Attr.type_ "text"
                    , onInput SearchArticle
                    ]
                    []
                , Html.label [ Attr.for "searchArticle" ] [ Html.text "Search ..." ]
                ]
            , Html.button
                [ Attr.class "btn btn--outline articleListToggle"
                , onClick ToggleArticleList
                ]
                [ UI.menuIcon ]
            ]
        , List.map (\s -> listItem (.category model) s (s == withDefault "" (.title model))) (.shownFileList model)
            |> Html.ul
                [ Attr.class "list collapse__target articleList"
                , showList <| .compact model
                ]
        ]


listItem : String -> String -> Bool -> Html msg
listItem category fileName isActive =
    Html.li [ Attr.classList [ ( "list__item", True ), ( "u-font-weight-bold", isActive ) ] ]
        [ Html.a [ Attr.class "listItem__text", Route.href <| getCategoryRoute category fileName ]
            [ Html.div [ Attr.class "listItemText__title" ] [ Html.text fileName ] ]
        ]


article : Maybe String -> Html msg
article content =
    withDefault "" content
        |> Markdown.Block.parse (Just MarkdownUtil.options)
        |> List.map MarkdownUtil.customHtmlBlock
        |> List.concat
        |> Html.div [ Attr.class "col-sm-4 col-md-6 col-l-10 u-padding-l" ]



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
    List.filter (\file -> String.contains (String.toLower input) (String.toLower file)) fileList


showList : Bool -> Attribute msg
showList display =
    case display of
        True ->
            Attr.style "height" "100%"

        False ->
            Attr.style "height" "0"


getCategoryRoute : String -> String -> Route.Route
getCategoryRoute category name =
    case category of
        "components" ->
            Route.Component name

        "guides" ->
            Route.Guide name

        _ ->
            Route.NotFound
