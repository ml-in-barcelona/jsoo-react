
[@@@js.stop]
type domElement = Js_of_ocaml.Dom_html.element
val domElement_to_js : domElement -> Ojs.t
val domElement_of_js : Ojs.t -> domElement
[@@@js.start]
[@@@js.implem
  type domElement = Js_of_ocaml.Dom_html.element
  external domElement_to_js : domElement -> Ojs.t = "%identity"
  external domElement_of_js : Ojs.t -> domElement = "%identity"
]

val render : React.element -> domElement -> unit [@@js.global "__LIB__reactDOM.render"]

val renderToElementWithId : React.element -> string -> unit
[@@js.custom

val getElementById: string -> domElement option [@@js.global "document.getElementById"]

let renderToElementWithId reactElement id =
  match getElementById id with
  | None  ->
      raise
        (Invalid_argument
            ("ReactDOM.renderToElementWithId : no element of id " ^
            id ^
            " found in the HTML.")
        )
  | Some element -> render reactElement element
]

type domRef = private Ojs.t

module Ref : sig
  type t = domRef
  type currentDomRef = domElement option React.Ref.t
  type callbackDomRef = domElement option -> unit
  
  val domRef : currentDomRef -> domRef
  [@@js.custom
    external domRef : currentDomRef -> domRef = "%identity"
  ]
  val callbackDomRef : callbackDomRef -> domRef
  [@@js.custom
    external callbackDomRef : callbackDomRef -> domRef = "%identity"
  ]
end

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

val createDOMElementVariadic :
  string ->
  ?props: domProps ->
  (React.element list [@js.variadic]) -> React.element
  [@@js.global "__LIB__react.createElement"]

val forwardRef : ('props -> domRef option -> React.element) -> 'props React.component
[@@js.custom
  val forwardRefInternal : (Ojs.t -> domRef option -> React.element) -> Ojs.t -> React.element [@@js.global "__LIB__reactDOM.forwardRef"]
  let forwardRef = Obj.magic forwardRefInternal (* TODO: Is there a way to avoid magic? *)
]

