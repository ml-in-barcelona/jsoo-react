let make () =
  (div ~children:[React.string "Hello world from OCaml"] () [@JSX])
  [@@react.component]
