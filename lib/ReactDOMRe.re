module Js = Js_of_ocaml.Js;
module Dom_html = Js_of_ocaml.Dom_html;
module Dom = Js_of_ocaml.Dom;

type props = Js.t({.});

class type reactDOM = {
  pub render: (React.element, Js.t(Dom_html.element)) => Js.meth(unit);
};
class type react = {
  pub createElement:
    (Js.t(Js.js_string), Js.Optdef.t(props), Js.t(Js.js_array(React.element))) =>
    Js.meth(React.element);
};

let react: Js.t(react) = Js.Unsafe.global##.React;
let reactDOM: Js.t(reactDOM) = Js.Unsafe.global##.ReactDOM;

let render: (React.element, Js.t(Dom_html.element)) => unit =
  (reactElement, domElement) => reactDOM##render(reactElement, domElement);

let renderToElementWithId = (reactElement, id) =>
  switch (Dom_html.getElementById_opt(id)) {
  | None =>
    raise(
      Invalid_argument(
        "ReactDOMRe.renderToElementWithId : no element of id "
        ++ id
        ++ " found in the HTML.",
      ),
    )
  | Some(element) => render(reactElement, element)
  };

/* TODO: Move somewhere else */
let optIter = (x, f) =>
  switch (x) {
  | None => ()
  | Some(x) => f(x)
  };

let props =
    (
      ~alt: option(string)=?,
      ~async: option(bool)=?,
      ~onClick: option(ReactEvent.Mouse.t => unit)=?,
      (),
    )
    : props => {
  let obj = Js.Unsafe.obj([||]);
  optIter(alt, v => obj##.alt := Js.string(v));
  optIter(async, v => obj##.async := Js.bool(v));
  optIter(onClick, v => obj##.onClick := Js.wrap_callback(v));
  /* TODO: Add others */
  obj;
};

let createElement:
  (string, ~props: props=?, array(React.element)) => React.element =
  (string, ~props=?, children) =>
    react##createElement(Js.string(string), Js.Optdef.option(props), Js.array(children));