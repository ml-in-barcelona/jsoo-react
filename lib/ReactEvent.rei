// Adapted from reason-react ReactEvent.re, commit 0f73a307
type synthetic('a);

module Synthetic: {
  type tag;
  type t = synthetic(tag);
  let bubbles: synthetic('a) => bool;
  let cancelable: synthetic('a) => bool;
  let currentTarget: synthetic('a) => Ojs.t;
  let defaultPrevented: synthetic('a) => bool;
  let eventPhase: synthetic('a) => int;
  let isTrusted: synthetic('a) => bool;
  let nativeEvent: synthetic('a) => Ojs.t;
  let preventDefault: synthetic('a) => unit;
  let isDefaultPrevented: synthetic('a) => bool;
  let stopPropagation: synthetic('a) => unit;
  let isPropagationStopped: synthetic('a) => bool;
  let target: synthetic('a) => Ojs.t;
  let timeStamp: synthetic('a) => float;
  let type_: synthetic('a) => string;
  let persist: synthetic('a) => unit;
};

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
let toSyntheticEvent: synthetic('a) => Synthetic.t;

module Clipboard: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let clipboardData: t => Ojs.t; /* Should return Dom.dataTransfer */
};

module Composition: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let data: t => string;
};

module Keyboard: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let altKey: t => bool;
  let charCode: t => int;
  let ctrlKey: t => bool;
  let getModifierState: (t, string) => bool;
  let key: t => string;
  let keyCode: t => int;
  let locale: t => string;
  let location: t => int;
  let metaKey: t => bool;
  let repeat: t => bool;
  let shiftKey: t => bool;
  let which: t => int;
};

module Focus: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let relatedTarget: t => option(Ojs.t); /* Should return Dom.eventTarget */
};

module Form: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
};

module Mouse: {
  type tag;
  type t = synthetic(tag);
  let t_of_js: Ojs.t => t;
  let t_to_js: t => Ojs.t;

  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let altKey: t => bool;
  let button: t => int;
  let buttons: t => int;
  let clientX: t => int;
  let clientY: t => int;
  let ctrlKey: t => bool;
  let getModifierState: (t, string) => bool;
  let metaKey: t => bool;
  let pageX: t => int;
  let pageY: t => int;
  let relatedTarget: t => option(Ojs.t); /* Should return Dom.eventTarget */
  let screenX: t => int;
  let screenY: t => int;
  let shiftKey: t => bool;
};

module Selection: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
};

module Touch: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let altKey: t => bool;
  let changedTouches: t => Ojs.t; /* Should return Dom.touchList */
  let ctrlKey: t => bool;
  let getModifierState: (t, string) => bool;
  let metaKey: t => bool;
  let shiftKey: t => bool;
  let targetTouches: t => Ojs.t; /* Should return Dom.touchList */
  let touches: t => Ojs.t; /* Should return Dom.touchList */
};

module UI: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let detail: t => int;
  let view: t => Js_of_ocaml.Dom_html.window; /* Should return DOMAbstractView/WindowProxy */
};

module Wheel: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let deltaMode: t => int;
  let deltaX: t => float;
  let deltaY: t => float;
  let deltaZ: t => float;
};

module Media: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
};

module Image: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
};

module Animation: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let animationName: t => string;
  let pseudoElement: t => string;
  let elapsedTime: t => float;
};

module Transition: {
  type tag;
  type t = synthetic(tag);
  let bubbles: t => bool;
  let cancelable: t => bool;
  let currentTarget: t => Ojs.t;
  let defaultPrevented: t => bool;
  let eventPhase: t => int;
  let isTrusted: t => bool;
  let nativeEvent: t => Ojs.t;
  let preventDefault: t => unit;
  let isDefaultPrevented: t => bool;
  let stopPropagation: t => unit;
  let isPropagationStopped: t => bool;
  let target: t => Ojs.t;
  let timeStamp: t => float;
  let type_: t => string;
  let persist: t => unit;
  let propertyName: t => string;
  let pseudoElement: t => string;
  let elapsedTime: t => float;
};
