open Js_of_ocaml

let to_js_string value = (Js.number_of_float value)##toString
let to_string value = to_js_string value |> Js.to_string
