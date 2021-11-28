[@@@react.dom]

let make () = div ~children:[React.string "Hello world from OCaml"] ()
  [@@react.component]
