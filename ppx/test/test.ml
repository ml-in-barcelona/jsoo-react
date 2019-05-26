let make ?(name = "") =
  (div ~children:[React.string ("Hello " ^ name)] () [@JSX])
  [@@react.component]
