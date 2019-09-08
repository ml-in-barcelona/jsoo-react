let make ?(name = "") =
  (div ~children:[React.string ("Hello from GreetingOCaml " ^ name)] () [@JSX])
  [@@react.component]
