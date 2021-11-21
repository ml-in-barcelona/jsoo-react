[@@@react.dom]

let element = div ~id:"foo" ~children:[] ()

let element =
  a ~id:"foo" ~href:"https://www.hello.com" ~children:[React.string "hello"] ()
