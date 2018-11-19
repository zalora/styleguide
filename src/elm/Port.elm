port module Port exposing (highlight, setPreview)


port highlight : String -> Cmd msg


port setPreview : String -> Cmd msg
