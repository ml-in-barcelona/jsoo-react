type props;

class type reactDOM = {
  pub render: (React.reactElement, Js.t(Dom_html.element)) => Js.meth(unit);
};
class type react = {
  pub createElement:
    (
      Js.t(Js.js_string),
      Js.Opt.t(props),
      Js.t(Js.js_array(React.reactElement))
    ) =>
    Js.meth(React.reactElement);
};

let react: Js.t(react) = Js.Unsafe.global##.React;
let reactDOM: Js.t(reactDOM) = Js.Unsafe.global##.ReactDOM;

let render: (React.reactElement, Js.t(Dom_html.element)) => unit =
  (reactElement, domElement) => reactDOM##render(reactElement, domElement);

[@bs.val]
external _getElementsByClassName: string => array(Dom.element) =
  "document.getElementsByClassName";

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

let props = (~alt: option(string)=?, ~async: option(bool)=?, ()): props => {
  let optIter = (x, f) =>
    switch (x) {
    | None => ()
    | Some(x) => f(x)
    };
  let obj = Js.Unsafe.obj([||]);
  optIter(alt, v => obj##.alt := Js.string(v));
  optIter(async, v => obj##.async := Js.bool(v));
  obj;
};

let createElement:
  (string, ~props: props=?, array(React.reactElement)) => React.reactElement =
  (string, ~props=?, children) =>
    react##createElement(
      Js.string(string),
      Js.Opt.option(props),
      Js.array(children),
    );