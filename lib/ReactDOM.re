let react = Js.Unsafe.global##react##react;
let reactDOM = Js.Unsafe.global##react##reactDOM;

type props;

let render: (React.reactElement, Js.t(Dom_html.element)) => unit =
  (reactElement, domElement) =>
    Js.Unsafe.fun_call(
      reactDOM##createElement,
      [|Js.Unsafe.inject(reactElement), Js.Unsafe.inject(domElement)|],
    );

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

external injectArray: array('a) => array(Js.Unsafe.any) = "%identity";
let createElement:
  (string, ~props: props=?, array(React.reactElement)) => React.reactElement =
  (tag, ~props=?, children) => {
    let firstChunk =
      switch (props) {
      | Some(p) => [|
          Js.Unsafe.inject(Js.string(tag)),
          Js.Unsafe.inject(p),
        |]
      | None => [|Js.Unsafe.inject(Js.string(tag))|]
      };
    Js.Unsafe.fun_call(
      react##createElement,
      Array.append(firstChunk, injectArray(children)),
    );
  };