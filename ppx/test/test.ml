let make ?(name = "") =
  ([ (div ~children:[React.string ("Hello " ^ name)] () [@JSX])
  ; (Hello.createElement ~one:"1" ~children:[React.string ("Hello " ^ name)] () 
    [@JSX]) ] [@JSX])
  [@@react.component]
