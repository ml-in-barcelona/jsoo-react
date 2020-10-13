// Adapted from reason-react ReactEvent.re, commit 0f73a307
type synthetic('a) = Ojs.t;

module CommonApi = {
  include [%js:
            type tag = Ojs.t;
            type t = Ojs.t;
            let t_of_js: Ojs.t => t;
            let t_to_js: t => Ojs.t;
            [@js.get]
            let bubbles: Ojs.t => bool;
            [@js.get]
            let cancelable: t => bool;
            [@js.get]
            let currentTarget: t => Ojs.t; /* Should return Dom.eventTarget */
            [@js.get]
            let defaultPrevented: t => bool;
            [@js.get]
            let eventPhase: t => int;
            [@js.get]
            let isTrusted: t => bool;
            [@js.get]
            let nativeEvent: t => Ojs.t; /* Should return Dom.event */
            [@js.call]
            let preventDefault: t => unit;
            [@js.call]
            let isDefaultPrevented: t => bool;
            [@js.call]
            let stopPropagation: t => unit;
            [@js.call]
            let isPropagationStopped: t => bool;
            [@js.get]
            let target: t => Ojs.t; /* Should return Dom.eventTarget */
            [@js.get]
            let timeStamp: t => float;
            [@js.get "type"]
            let type_: t => string;
            [@js.call]
            let persist: t => unit
          ];
};

module Synthetic = CommonApi;

/* Cast any event type to the general synthetic type. This is safe, since synthetic is more general */
external toSyntheticEvent: synthetic('a) => Synthetic.t = "%identity";

module Clipboard = {
  include CommonApi;
  include [%js:
            [@js.get]
            let clipboardData: t => Ojs.t /* Should return Dom.dataTransfer */
          ];
};

module Composition = {
  include CommonApi;
  include [%js:
            [@js.get]
            let data: t => string
          ];
};

module Keyboard = {
  include CommonApi;
  include [%js:
            [@js.get]
            let altKey: t => bool;
            [@js.get]
            let charCode: t => int;
            [@js.get]
            let ctrlKey: t => bool;
            [@js.call]
            let getModifierState: (t, string) => bool;
            [@js.get]
            let key: t => string;
            [@js.get]
            let keyCode: t => int;
            [@js.get]
            let locale: t => string;
            [@js.get]
            let location: t => int;
            [@js.get]
            let metaKey: t => bool;
            [@js.get]
            let repeat: t => bool;
            [@js.get]
            let shiftKey: t => bool;
            [@js.get]
            let which: t => int
          ];
};

module Focus = {
  include CommonApi;
  include [%js:
            [@js.get]
            let relatedTarget: t => option(Ojs.t) /* Should return Dom.eventTarget */
          ];
};

module Form = {
  include CommonApi;
};

module Mouse = {
  include CommonApi;
  include [%js:
            [@js.get]
            let altKey: t => bool;
            [@js.get]
            let button: t => int;
            [@js.get]
            let buttons: t => int;
            [@js.get]
            let clientX: t => int;
            [@js.get]
            let clientY: t => int;
            [@js.get]
            let ctrlKey: t => bool;
            [@bs.send]
            let getModifierState: (t, string) => bool;
            [@js.get]
            let metaKey: t => bool;
            [@js.get]
            let pageX: t => int;
            [@js.get]
            let pageY: t => int;
            [@js.get]
            let relatedTarget: t => option(Ojs.t); /* Should return Dom.eventTarget */
            [@js.get]
            let screenX: t => int;
            [@js.get]
            let screenY: t => int;
            [@js.get]
            let shiftKey: t => bool
          ];
};

module Selection = {
  include CommonApi;
};

module Touch = {
  include CommonApi;
  include [%js:
            [@js.get]
            let altKey: t => bool;
            [@js.get]
            let changedTouches: t => Ojs.t; /* Should return Dom.touchList */
            [@js.get]
            let ctrlKey: t => bool;
            [@js.call]
            let getModifierState: (t, string) => bool;
            [@js.get]
            let metaKey: t => bool;
            [@js.get]
            let shiftKey: t => bool;
            [@js.get]
            let targetTouches: t => Ojs.t; /* Should return Dom.touchList */
            [@js.get]
            let touches: t => Ojs.t /* Should return Dom.touchList */
          ];
};

type window = Js_of_ocaml.Dom_html.window;

module UI = {
  external window_of_js: Ojs.t => Js_of_ocaml.Dom_html.window = "%identity";
  include CommonApi;
  include [%js:
            [@js.get]
            let detail: t => int;
            [@js.get]
            let view: t => window /* Should return DOMAbstractView/WindowProxy */
          ];
};

module Wheel = {
  include CommonApi;
  include [%js:
            [@js.get]
            let deltaMode: t => int;
            [@js.get]
            let deltaX: t => float;
            [@js.get]
            let deltaY: t => float;
            [@js.get]
            let deltaZ: t => float
          ];
};

module Media = {
  include CommonApi;
};

module Image = {
  include CommonApi;
};

module Animation = {
  include CommonApi;
  include [%js:
            [@js.get]
            let animationName: t => string;
            [@js.get]
            let pseudoElement: t => string;
            [@js.get]
            let elapsedTime: t => float
          ];
};

module Transition = {
  include CommonApi;
  include [%js:
            [@js.get]
            let propertyName: t => string;
            [@js.get]
            let pseudoElement: t => string;
            [@js.get]
            let elapsedTime: t => float
          ];
};
