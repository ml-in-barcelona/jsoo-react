open Js_of_ocaml;

[@react.component]
let make = (~text) => {
  let codeRef = React.useRef(Js.null);
  React.useEffect(() => {
    switch (codeRef |> React.Ref.current |> Js.Opt.to_option) {
    | Some(el) => Js.Unsafe.global##.Prism##highlightElement(el)
    | None => ()
    };
    None;
  });
  <pre className="language-reason">
    <code ref={React.Dom.Ref.domRef(codeRef)}> {text |> React.string} </code>
  </pre>;
};
