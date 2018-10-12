module AppState exposing
    ( AppState(..)
    , dismissError
    , init
    , toFailure
    , toLoading
    , toSuccess
    )


type AppState e
    = InitLoading --            fullscreen spinner
    | LoadingError e --         fullscreen error with retry
    | Loading --                normal view with spinner overlay
    | Loaded (Maybe e) --       normal view with dismiss-able error (if Just error)


init : AppState e
init =
    InitLoading


toSuccess : AppState e -> AppState e
toSuccess appState =
    case appState of
        InitLoading ->
            Loaded Nothing

        Loading ->
            Loaded Nothing

        -- only loading state can transit to success state
        -- the rest cannot
        Loaded _ ->
            appState

        LoadingError _ ->
            appState


toFailure : e -> AppState e -> AppState e
toFailure error appState =
    case appState of
        InitLoading ->
            LoadingError error

        Loading ->
            Loaded (Just error)

        -- only loading state can transit to failure state
        -- the rest cannot
        Loaded _ ->
            appState

        LoadingError _ ->
            appState


toLoading : AppState e -> AppState e
toLoading appState =
    case appState of
        Loaded _ ->
            -- only loaded state can transit to loading state
            Loading

        LoadingError _ ->
            -- only loading error state can transit back to loading state
            -- the only way to do that is through "retry"
            InitLoading

        Loading ->
            appState

        InitLoading ->
            appState


dismissError : AppState e -> AppState e
dismissError appState =
    case appState of
        Loaded (Just _) ->
            -- this is the only way case where we can dismiss error
            Loaded Nothing

        LoadingError _ ->
            -- this is the fullscreen error of initial loading
            -- we cannot dismiss error, if we do, we get blank page ???
            -- we can only click retry for this state
            appState

        Loaded _ ->
            appState

        InitLoading ->
            appState

        Loading ->
            appState
