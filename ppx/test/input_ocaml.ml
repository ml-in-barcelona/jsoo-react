[@@@react.dom]

let make ?(name = "") = div ~children:[React.string ("Hello " ^ name)] ()
  [@@react.component]

let element = div ~id:"foo" ~children:[] ()

let element =
  a ~id:"foo" ~href:"https://www.hello.com" ~children:[React.string "hello"] ()
