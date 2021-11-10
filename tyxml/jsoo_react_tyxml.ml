open Js_of_ocaml
open React
open Tyxml_f

module type XML =
  Xml_sigs.T
  with type uri = string
   and type event_handler = Dom_html.event Js.t -> unit
   and type mouse_event_handler = Dom_html.mouseEvent Js.t -> unit
   and type touch_event_handler = Dom_html.touchEvent Js.t -> unit
   and type keyboard_event_handler = Dom_html.keyboardEvent Js.t -> unit
   and type elt = element

module Xml = struct
  module W = Xml_wrap.NoWrap

  type 'a wrap = 'a
  type 'a list_wrap = 'a list
  type uri = string

  let uri_of_string s = s
  let string_of_uri s = s

  type aname = string
  type event_handler = Dom_html.event Js.t -> unit
  type mouse_event_handler = Dom_html.mouseEvent Js.t -> unit
  type touch_event_handler = Dom_html.touchEvent Js.t -> unit
  type keyboard_event_handler = Dom_html.keyboardEvent Js.t -> unit
  type attrib = Attr.t

  let attr name value =
    match name with
    | "value" | "checked" | "selected" ->
      Attr.property name (Js.Unsafe.inject (Js.string value))
    | name -> Attr.create name value
  ;;

  let attr_ev name cvt_to_vdom_event =
    let f e =
      Effect.Expert.handle e (cvt_to_vdom_event e);
      Js._true
    in
    Attr.property name (Js.Unsafe.inject (Dom.handler f))
  ;;

  let float_attrib name value : attrib = attr name (string_of_float value)
  let int_attrib name value = attr name (string_of_int value)
  let string_attrib name value = attr name value
  let space_sep_attrib name values = attr name (String.concat " " values)
  let comma_sep_attrib name values = attr name (String.concat "," values)
  let event_handler_attrib name (value : event_handler) = attr_ev name value
  let mouse_event_handler_attrib name (value : mouse_event_handler) = attr_ev name value
  let touch_event_handler_attrib name (value : touch_event_handler) = attr_ev name value

  let keyboard_event_handler_attrib name (value : keyboard_event_handler) =
    attr_ev name value
  ;;

  let uri_attrib name value = attr name value
  let uris_attrib name values = attr name (String.concat " " values)

  (** Element *)

  type elt = Vdom.Node.t
  type ename = string

  let make_a x = x

  let empty () = assert false
  let comment _c = assert false
  let pcdata s = Vdom.Node.text s
  let encodedpcdata s = Vdom.Node.text s

  let entity e =
    let entity = Dom_html.decode_html_entities (Js.string ("&" ^ e ^ ";")) in
    Vdom.Node.text (Js.to_string entity)
  ;;

  let leaf ?(a = []) name =
    Vdom.Node.create name ~attr:(Vdom.Attr.many_without_merge (make_a a)) []
  ;;

  let node ?(a = []) name children =
    Vdom.Node.create name ~attr:(Vdom.Attr.many_without_merge (make_a a)) children
  ;;

  let cdata s = pcdata s
  let cdata_script s = cdata s
  let cdata_style s = cdata s
end

module Xml_Svg = struct
  include Xml

  let leaf ?(a = []) name =
    Vdom.Node.create_svg name ~attr:(Vdom.Attr.many_without_merge (make_a a)) []
  ;;

  let node ?(a = []) name children =
    Vdom.Node.create_svg name ~attr:(Vdom.Attr.many_without_merge (make_a a)) children
  ;;
end

module Svg = Svg_f.Make (Xml_Svg)
module Html = Html_f.Make (Xml) (Svg)
