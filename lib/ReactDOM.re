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
let domProps =
    (
      ~ref: option(domRef)=?,
      ~alt: option(string)=?,
      ~async: option(bool)=?,
      ~className: option(string)=?,
      ~onClick: option(ReactEvent.Mouse.t => unit)=?,
      (),
    )
    : domProps => {
  /* TODO: Add others */
  optInj("ref", ref)
  |> Array.append(optInj("alt", alt))
  |> Array.append(optInj("className", className))
  |> Array.append(optInj("async", async))
  |> Array.append(optInj(~f=Js.wrap_callback, "onClick", onClick))
  |> Js.Unsafe.obj;
};

external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createDOMElementVariadic";
