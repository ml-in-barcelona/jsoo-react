type synthetic('a) = Ojs.t;

module CommonApi: {
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
  let persist: t => unit;
} =
  [%js];

module Synthetic = CommonApi;

module Mouse = {
  include CommonApi;
  include (
            [%js]: {
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
              let shiftKey: t => bool;
            }
          );
};
