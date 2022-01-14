module Fragment = struct
  include Core.Fragment

  let make children = make ~children ()
end

let href str = ("href", str)

let target str = ("target", str)

let className str = ("className", str)

let make_props attrs : Dom.domProps =
  Js_of_ocaml.Js.Unsafe.obj
    ( attrs
    |> Array.map (fun (key, value) ->
           (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value)) )
    )

let make_element name props children =
  Dom.createDOMElementVariadic name ~props:(make_props props) children

let a = make_element "a"

let div = make_element "div"

let footer = make_element "footer"

let i = make_element "i"

let span = make_element "span"
