(* Adapted from reason-react ReactEvent.re, commit 0f73a307type 'a synthetic *)
type 'a synthetic

module Synthetic : sig
  type tag

  type t = tag synthetic

  val bubbles : 'a synthetic -> bool

  val cancelable : 'a synthetic -> bool

  val currentTarget : 'a synthetic -> Ojs.t

  val defaultPrevented : 'a synthetic -> bool

  val eventPhase : 'a synthetic -> int

  val isTrusted : 'a synthetic -> bool

  val nativeEvent : 'a synthetic -> Ojs.t

  val preventDefault : 'a synthetic -> unit

  val isDefaultPrevented : 'a synthetic -> bool

  val stopPropagation : 'a synthetic -> unit

  val isPropagationStopped : 'a synthetic -> bool

  val target : 'a synthetic -> Ojs.t

  val timeStamp : 'a synthetic -> float

  val type_ : 'a synthetic -> string

  val persist : 'a synthetic -> unit
end

(* Cast any event type to the general synthetic type. This is safe, since synthetic is more general *)
val toSyntheticEvent : 'a synthetic -> Synthetic.t

module Clipboard : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val clipboardData : t -> Ojs.t
end

module Composition : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val data : t -> string
end

module Keyboard : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val altKey : t -> bool

  val charCode : t -> int

  val ctrlKey : t -> bool

  val getModifierState : t -> string -> bool

  val key : t -> string

  val keyCode : t -> int

  val locale : t -> string

  val location : t -> int

  val metaKey : t -> bool

  val repeat : t -> bool

  val shiftKey : t -> bool

  val which : t -> int
end

module Focus : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val relatedTarget : t -> Ojs.t option
end

module Form : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit
end

module Mouse : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val altKey : t -> bool

  val button : t -> int

  val buttons : t -> int

  val clientX : t -> int

  val clientY : t -> int

  val ctrlKey : t -> bool

  val getModifierState : t -> string -> bool

  val metaKey : t -> bool

  val pageX : t -> int

  val pageY : t -> int

  val relatedTarget : t -> Ojs.t option

  val screenX : t -> int

  val screenY : t -> int

  val shiftKey : t -> bool
end

module Selection : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit
end

module Touch : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val altKey : t -> bool

  val changedTouches : t -> Ojs.t

  val ctrlKey : t -> bool

  val getModifierState : t -> string -> bool

  val metaKey : t -> bool

  val shiftKey : t -> bool

  val targetTouches : t -> Ojs.t

  val touches : t -> Ojs.t
end

module Pointer : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t
end

module UI : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val detail : t -> int

  val view : t -> Js_of_ocaml.Dom_html.window
end

module Wheel : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val deltaMode : t -> int

  val deltaX : t -> float

  val deltaY : t -> float

  val deltaZ : t -> float
end

module Media : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit
end

module Image : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit
end

module Animation : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val animationName : t -> string

  val pseudoElement : t -> string

  val elapsedTime : t -> float
end

module Transition : sig
  type tag

  type t = tag synthetic

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val bubbles : t -> bool

  val cancelable : t -> bool

  val currentTarget : t -> Ojs.t

  val defaultPrevented : t -> bool

  val eventPhase : t -> int

  val isTrusted : t -> bool

  val nativeEvent : t -> Ojs.t

  val preventDefault : t -> unit

  val isDefaultPrevented : t -> bool

  val stopPropagation : t -> unit

  val isPropagationStopped : t -> bool

  val target : t -> Ojs.t

  val timeStamp : t -> float

  val type_ : t -> string

  val persist : t -> unit

  val propertyName : t -> string

  val pseudoElement : t -> string

  val elapsedTime : t -> float
end
