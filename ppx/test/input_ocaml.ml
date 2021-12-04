[@@@react.dom]

let make ?(name = "") = div ~children:[React.string ("Hello " ^ name)] ()
  [@@react.component]

let element = div ~id:"foo" ~children:[] ()

let element =
  a ~id:"foo" ~href:"https://www.hello.com" ~children:[React.string "hello"] ()

let make ~children:(first, second) = div ~id:"foo" ~children:[first; second] ()
  [@@react.component]

let make ~children:kids = div ~id:"foo" ~children:kids () [@@react.component]

let make ~children:(first, second) () = div ~children:[first; second] ()
  [@@react.component]
