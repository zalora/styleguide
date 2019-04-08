module Page.NotFound exposing (view)

import Html exposing (Html, h1, main_, text)
import Html.Attributes exposing (class, id, tabindex)



-- VIEW


view : Html msg
view =
    main_ [ id "content", class "container--fluid", tabindex -1 ]
        [ h1 [] [ text "404" ] ]
