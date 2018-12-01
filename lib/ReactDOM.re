open Js_of_ocaml;

type element;

class type react = {
  pub createElement:
    (string, Js.t(element), Js.t({.})) => Js.meth(Js.t(Dom_html.element));
};

[@bs.val] [@bs.module "react-dom"]
external render : (React.reactElement, Dom.element) => unit = "render";

[@bs.val] [@bs.return nullable]
external _getElementById : string => option(Dom.element) =
"document.getElementById";

let renderToElementWithId = (reactElement, id) =>
  switch (_getElementById(id)) {
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

let react: Js.t(react) = Js.Unsafe.global##.react;
