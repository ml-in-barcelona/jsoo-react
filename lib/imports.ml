type react = Ojs.t

type reactDom = Ojs.t

let react_to_js v = v

let reactDom_to_js v = v

let react : react = Js_of_ocaml.Js.Unsafe.js_expr {|require("react")|}

let reactDom : reactDom = Js_of_ocaml.Js.Unsafe.js_expr {|require("react-dom")|}
