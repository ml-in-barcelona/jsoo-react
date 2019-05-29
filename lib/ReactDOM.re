module Js = Js_of_ocaml.Js;
module Dom_html = Js_of_ocaml.Dom_html;

external render: (React.element, Js.t(Dom_html.element)) => unit = "render";

let renderToElementWithId = (reactElement, id) =>
  render(reactElement, Dom_html.getElementById_exn(id));

let optInj = (~f=?, prop, opt) =>
  switch (f, opt) {
  | (Some(f), Some(s)) => [|(prop, Js.Unsafe.inject(f(s)))|]
  | (None, Some(s)) => [|(prop, Js.Unsafe.inject(s))|]
  | _ => [||]
  };

type domRef;
module Ref = {
  type t = domRef;
  type currentDomRef = React.Ref.t(Js.opt(Dom_html.element));
  type callbackDomRef = Js.opt(Dom_html.element) => unit;

  external domRef: currentDomRef => domRef = "%identity";
  external callbackDomRef: callbackDomRef => domRef = "%identity";
};

type domProps;
external domProps:
  (
    ~key: string=?,
    ~ref: domRef=?,
    ~alt: string=?,
    ~async: bool=?,
    ~className: string=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
    unit
  ) =>
  domProps =
  "domProps";

external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createDOMElementVariadic";

// TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
// Although Reason parser doesn't support it so that's a requirement before adding it here
external createFragment: array(React.element) => React.element =
  "createFragment";
