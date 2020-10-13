(* Adapted from reason-react ReactEvent.re, commit 0f73a307 *)
type 'a synthetic = Ojs.t

module CommonApi = struct
  include [%js:
  type tag = Ojs.t

  type t = Ojs.t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : Ojs.t -> bool [@@js.get]

  val cancelable : t -> bool [@@js.get]

  val currentTarget : t -> Ojs.t [@@js.get] (* Should return Dom.eventTarget *)

  val defaultPrevented : t -> bool [@@js.get]

  val eventPhase : t -> int [@@js.get]

  val isTrusted : t -> bool [@@js.get]

  val nativeEvent : t -> Ojs.t [@@js.get] (* Should return Dom.event *)

  val preventDefault : t -> unit [@@js.call]

  val isDefaultPrevented : t -> bool [@@js.call]

  val stopPropagation : t -> unit [@@js.call]

  val isPropagationStopped : t -> bool [@@js.call]

  val target : t -> Ojs.t [@@js.get] (* Should return Dom.eventTarget *)

  val timeStamp : t -> float [@@js.get]

  val type_ : t -> string [@@js.get "type"]

  val persist : t -> unit [@@js.call]]
end

module Synthetic = CommonApi

(* Cast any event type to the general synthetic type. This is safe, since synthetic is more general *)
external toSyntheticEvent : 'a synthetic -> Synthetic.t = "%identity"

module Clipboard = struct
  include CommonApi

  include [%js:
  val clipboardData : t -> Ojs.t [@@js.get]]

  (* Should return Dom.dataTransfer *)
end

module Composition = struct
  include CommonApi

  include [%js:
  val data : t -> string [@@js.get]]
end

module Keyboard = struct
  include CommonApi

  include [%js:
  val altKey : t -> bool [@@js.get]

  val charCode : t -> int [@@js.get]

  val ctrlKey : t -> bool [@@js.get]

  val getModifierState : t -> string -> bool [@@js.call]

  val key : t -> string [@@js.get]

  val keyCode : t -> int [@@js.get]

  val locale : t -> string [@@js.get]

  val location : t -> int [@@js.get]

  val metaKey : t -> bool [@@js.get]

  val repeat : t -> bool [@@js.get]

  val shiftKey : t -> bool [@@js.get]

  val which : t -> int [@@js.get]]
end

module Focus = struct
  include CommonApi

  include [%js:
  val relatedTarget : t -> Ojs.t option [@@js.get]]

  (* Should return Dom.eventTarget *)
end

module Form = struct
  include CommonApi
end

module Mouse = struct
  include CommonApi

  include [%js:
  val altKey : t -> bool [@@js.get]

  val button : t -> int [@@js.get]

  val buttons : t -> int [@@js.get]

  val clientX : t -> int [@@js.get]

  val clientY : t -> int [@@js.get]

  val ctrlKey : t -> bool [@@js.get]

  val getModifierState : t -> string -> bool [@@bs.send]

  val metaKey : t -> bool [@@js.get]

  val pageX : t -> int [@@js.get]

  val pageY : t -> int [@@js.get]

  val relatedTarget : t -> Ojs.t option [@@js.get]

  (* Should return Dom.eventTarget *)

  val screenX : t -> int [@@js.get]

  val screenY : t -> int [@@js.get]

  val shiftKey : t -> bool [@@js.get]]
end

module Selection = struct
  include CommonApi
end

module Touch = struct
  include CommonApi

  include [%js:
  val altKey : t -> bool [@@js.get]

  val changedTouches : t -> Ojs.t [@@js.get] (* Should return Dom.touchList *)

  val ctrlKey : t -> bool [@@js.get]

  val getModifierState : t -> string -> bool [@@js.call]

  val metaKey : t -> bool [@@js.get]

  val shiftKey : t -> bool [@@js.get]

  val targetTouches : t -> Ojs.t [@@js.get] (* Should return Dom.touchList *)

  val touches : t -> Ojs.t [@@js.get]]

  (* Should return Dom.touchList *)
end

type window = Js_of_ocaml.Dom_html.window

module UI = struct
  external window_of_js : Ojs.t -> Js_of_ocaml.Dom_html.window = "%identity"

  include CommonApi

  include [%js:
  val detail : t -> int [@@js.get]

  val view : t -> window [@@js.get]]

  (* Should return DOMAbstractView/WindowProxy *)
end

module Wheel = struct
  include CommonApi

  include [%js:
  val deltaMode : t -> int [@@js.get]

  val deltaX : t -> float [@@js.get]

  val deltaY : t -> float [@@js.get]

  val deltaZ : t -> float [@@js.get]]
end

module Media = struct
  include CommonApi
end

module Image = struct
  include CommonApi
end

module Animation = struct
  include CommonApi

  include [%js:
  val animationName : t -> string [@@js.get]

  val pseudoElement : t -> string [@@js.get]

  val elapsedTime : t -> float [@@js.get]]
end

module Transition = struct
  include CommonApi

  include [%js:
  val propertyName : t -> string [@@js.get]

  val pseudoElement : t -> string [@@js.get]

  val elapsedTime : t -> float [@@js.get]]
end
