type domRef

(* module Ref : sig
  type t = domRef
  type currentDomRef = Dom_html.element option React.Ref.t
  type callbackDomRef = Dom_html.element option -> unit
  external domRef : currentDomRef -> domRef = "%identity"
  external callbackDomRef : callbackDomRef -> domRef = "%identity"
end *)

type domProps = private Ojs.t

val domProps :
  ?key:string ->
  ?ref:domRef ->
  ?alt:string ->
  ?async:bool ->
  ?className:string ->
  ?href:string ->
  ?onClick:(ReactEvent.Mouse.t -> unit) ->
  unit -> domProps
  [@@js.builder]

val createDOMElementVariadic : string -> ?props: domProps -> (React.element list [@js.variadic]) -> React.element [@@js.global
                                                           "__LIB__reactDOM.createElement"
                                                             ]

val forwardRef : ('props -> domRef option -> React.element) -> 'props React.component
[@@js.custom
  val forwardRefInternal : (Ojs.t -> domRef option -> React.element) -> Ojs.t -> React.element [@@js.global "__LIB__reactDOM.forwardRef"]
  let forwardRef = Obj.magic forwardRefInternal (* TODO: Is there a way to avoid magic? *)
]

(* 
// module Js = Js_of_ocaml.Js;
// module Dom_html = Js_of_ocaml.Dom_html;

// external render: (React.element, Js.t(Dom_html.element)) => unit = "render";

// let renderToElementWithId = (reactElement, id) =>
//   render(reactElement, Dom_html.getElementById_exn(id));


// external createDOMElementVariadic:
//   (string, ~props: domProps=?, array(React.element)) => React.element =
//   "createDOMElementVariadic";

// // TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
// // Although Reason parser doesn't support it so that's a requirement before adding it here
// external createFragment: array(React.element) => React.element =
//   "createFragment";
*)
