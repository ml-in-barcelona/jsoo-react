module Js = Js_of_ocaml.Js;
module Dom_html = Js_of_ocaml.Dom_html;

external render: (React.element, Js.t(Dom_html.element)) => unit = "render";

let renderToElementWithId = (reactElement, id) =>
  render(reactElement, Dom_html.getElementById_exn(id));

type domRef;
module Ref = {
  type t = domRef;
  type currentDomRef = React.Ref.t(option(Dom_html.element));
  type callbackDomRef = option(Dom_html.element) => unit;

  external domRef: currentDomRef => domRef = "domRef";
  external callbackDomRef: callbackDomRef => domRef = "callbackDomRef";
};

external forwardRef:
  (('props, option(domRef)) => React.element) => React.component('props) =
  "forwardRef";

type domProps;

/* Important: the order of these labelled arguments must match the order in which
   the params are listed in the ReactDOM.js external implementation of `domProps` */
external domProps:
  (
    ~key: string=?,
    ~ref: domRef=?,
    ~alt: string=?,
    ~async: bool=?,
    ~className: string=?,
    ~href: string=?,
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
