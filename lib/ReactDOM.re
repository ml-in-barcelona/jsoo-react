module Js = Js_of_ocaml.Js;
module Dom_html = Js_of_ocaml.Dom_html;

external render: (React.element, Js.t(Dom_html.element)) => unit = "render";

let renderToElementWithId = (reactElement, id) =>
  render(reactElement, Dom_html.getElementById_exn(id));

type domProps;
let domProps =
    (
      ~alt: option(string)=?,
      ~async: option(bool)=?,
      ~onClick: option(ReactEvent.Mouse.t => unit)=?,
      (),
    )
    : domProps => {
  /* TODO: Add others */
  Utils.(
    optInj("alt", alt)
    |> Array.append(optInj("async", async))
    |> Array.append(optInj(~f=Js.wrap_callback, "onClick", onClick))
  )
  |> Js.Unsafe.obj;
};

external createDOMElementVariadic:
  (string, ~props: domProps=?, array(React.element)) => React.element =
  "createDOMElementVariadic";
