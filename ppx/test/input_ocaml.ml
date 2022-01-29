[@@@react.dom]

let%component make ?(name = "") = div [||] [React.string ("Hello " ^ name)]

let element = div [|id "foo"|] []

let element = a [|id "foo"; href "https://www.hello.com"|] [React.string "hello"]

let%component make ~children:(first, second) = div [|id "foo"|] [first; second]

let%component make ~children:kids = div [|id "foo"|] kids

let%component make ~children:(first, second) () = div [||] [first; second]

let%component make ?(name = "") = div [||] [name]

let%component make () = a [|href "https://opam.ocaml.org"|] []

external%component make : name:Js.js_string Js.t -> React.element
  = "require(\"my-react-library\").MyReactComponent"

external%component make : ?name:Js.js_string Js.t -> React.element
  = "require(\"my-react-library\").MyReactComponent"
