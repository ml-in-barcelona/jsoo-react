module Helpers = struct
  let h name props children =
    Dom.createDOMElementVariadic name
      ~props:(Js_of_ocaml.Js.Unsafe.obj props)
      children
end

module PropHelpers = struct
  type t = string * Js_of_ocaml.Js.Unsafe.any

  let any key value = (key, Js_of_ocaml.Js.Unsafe.inject value)

  let string key value = any key (Js_of_ocaml.Js.string value)

  let bool key value = any key (Js_of_ocaml.Js.bool value)

  let int key (value : int) = any key value

  let float key (value : float) = any key value

  let event key (f : _ Event.synthetic -> unit) =
    any key (Js_of_ocaml.Js.wrap_callback f)

  let maybe prop = function Some value -> prop value | None -> any "" ""

  let key = string "key"
end

module Common = struct
  let fragment children = Core.Fragment.make ~children ()

  let string = Core.string

  let int = Core.int

  let float = Core.float
end
