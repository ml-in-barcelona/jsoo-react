module Fragment = struct
  include Core.Fragment

  let make children = make ~children ()
end

module Html = struct
  let make_element name props children =
    Dom.createDOMElementVariadic name
      ~props:(Js_of_ocaml.Js.Unsafe.obj props)
      children

  let a = make_element "a"

  let div = make_element "div"

  let footer = make_element "footer"

  let i = make_element "i"

  let span = make_element "span"

  let text = Core.string

  module Props = struct
    let string_prop key value =
      (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value))

    let href = string_prop "href"

    let target = string_prop "target"

    let className = string_prop "className"
  end
end
