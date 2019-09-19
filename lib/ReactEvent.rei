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
