module Fragment = struct
  include Core.Fragment

  let make children = make ~children ()
end

let string_prop key value = (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value))

let href = string_prop "href"

let target = string_prop "target"

let className = string_prop "className"

let make_props list : Dom.domProps =
  Js_of_ocaml.Js.Unsafe.obj (Array.of_list list)

let make_element name props children =
  Dom.createDOMElementVariadic name ~props:(make_props props) children

let a = make_element "a"

let div = make_element "div"

let footer = make_element "footer"

let i = make_element "i"

let span = make_element "span"
