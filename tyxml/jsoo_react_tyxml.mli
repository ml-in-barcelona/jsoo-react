open Tyxml_f
open Js_of_ocaml

module type XML =
  Xml_sigs.T
  with type uri = string
   and type event_handler = Dom_html.event Js.t -> unit
   and type mouse_event_handler = Dom_html.mouseEvent Js.t -> unit
   and type touch_event_handler = Dom_html.touchEvent Js.t -> unit
   and type keyboard_event_handler = Dom_html.keyboardEvent Js.t -> unit
   and type elt = React.element

module Xml : XML with module W = Xml_wrap.NoWrap
module Svg : Svg_sigs.Make(Xml).T with module Xml.W = Xml_wrap.NoWrap
module Html : Html_sigs.Make(Xml)(Svg).T with module Xml.W = Xml_wrap.NoWrap
