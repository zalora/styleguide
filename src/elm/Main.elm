module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Html exposing (Html, text)
import Maybe exposing (withDefault)
import Page exposing (pageView)
import Page.Article as Article exposing (Msg, init, update, view)
import Page.Home as Home
import Page.NotFound as NotFound
import Page.Playground as Playground exposing (Msg, init, update, view)
import Route exposing (Route, fromUrl)
import UI exposing (pageFooter)
import Url exposing (Url)
import Url.Builder exposing (absolute)



-- MODEL


type alias Model =
    { navKey : Key
    , route : Route
    , page : Page
    }


type Page
    = HomePage
    | ArticlePage Article.Model
    | PlaygroundPage Playground.Model
    | NotFoundPage
    | EmptyPage



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        pageInfo =
            case .page model of
                HomePage ->
                    { title = "Home"
                    , view = Home.view :: [ UI.pageFooter ]
                    }

                ArticlePage article ->
                    { title = withDefault "Documentation" (.title article)
                    , view = [ Html.map GotArticleMsg (Article.view article) ]
                    }

                PlaygroundPage playground ->
                    { title = "Playground"
                    , view = [ Html.map GotPlaygroundMsg (Playground.view playground) ]
                    }

                NotFoundPage ->
                    { title = "Not Found"
                    , view = NotFound.view :: [ UI.pageFooter ]
                    }

                EmptyPage ->
                    { title = ""
                    , view = [ text "" ]
                    }
    in
    Page.pageView pageInfo



-- UPDATE


type Msg
    = Ignored
    | ChangedUrl Url
    | RequestUrl Browser.UrlRequest
    | GotArticleMsg Article.Msg
    | GotPlaygroundMsg Playground.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( ChangedUrl url, _ ) ->
            let
                newRoute =
                    Route.fromUrl url
            in
            ( { model | route = newRoute }, Cmd.none )
                |> loadCurrentPage

        ( RequestUrl urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model, Nav.load url )

        ( GotArticleMsg subMsg, ArticlePage articleModel ) ->
            let
                ( newArticleModel, newCmd ) =
                    Article.update subMsg articleModel
            in
            ( { model | page = ArticlePage newArticleModel }
            , Cmd.map GotArticleMsg newCmd
            )

        ( GotPlaygroundMsg subMsg, PlaygroundPage playgroundModel ) ->
            let
                ( newPlaygroundModel, newCmd ) =
                    Playground.update subMsg playgroundModel
            in
            ( { model | page = PlaygroundPage newPlaygroundModel }
            , Cmd.map GotPlaygroundMsg newCmd
            )

        ( _, _ ) ->
            -- disregard messages that arrived for the wrong page.
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        model =
            { navKey = navKey
            , route = fromUrl url
            , page = HomePage
            }
    in
    ( model, Cmd.none )
        |> loadCurrentPage



-- PROGRAM


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = RequestUrl
        , onUrlChange = ChangedUrl
        }



-- INTERNALS


loadCurrentPage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
loadCurrentPage ( model, cmd ) =
    let
        ( page, newCmd ) =
            case model.route of
                Route.Home ->
                    ( HomePage, Cmd.none )

                Route.Components ->
                    let
                        ( articleModel, articleCmd ) =
                            Article.init "components" Nothing
                    in
                    ( ArticlePage articleModel, Cmd.map GotArticleMsg articleCmd )

                Route.Component name ->
                    let
                        ( articleModel, articleCmd ) =
                            Article.init "components" (Just name)
                    in
                    ( ArticlePage articleModel, Cmd.map GotArticleMsg articleCmd )

                Route.Guides ->
                    let
                        ( articleModel, articleCmd ) =
                            Article.init "guides" Nothing
                    in
                    ( ArticlePage articleModel, Cmd.map GotArticleMsg articleCmd )

                Route.Guide name ->
                    let
                        ( articleModel, articleCmd ) =
                            Article.init "guides" (Just name)
                    in
                    ( ArticlePage articleModel, Cmd.map GotArticleMsg articleCmd )

                Route.Playground ->
                    let
                        ( playgroundModel, playgroundCmd ) =
                            Playground.init
                    in
                    ( PlaygroundPage playgroundModel, Cmd.map GotPlaygroundMsg playgroundCmd )

                Route.NotFound ->
                    ( NotFoundPage, Cmd.none )
    in
    ( { model | page = page }, Cmd.batch [ cmd, newCmd ] )
