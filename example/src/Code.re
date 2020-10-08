[@react.component]
let make = (~text) => {
  let codeRef = React.useRef(Js_of_ocaml.Js.null);
  React.useEffect(() => {
    Js_of_ocaml.Firebug.console##log(codeRef);
    switch (codeRef |> React.Ref.current |> Js_of_ocaml.Js.Opt.to_option) {
    | Some(el) =>
      Js_of_ocaml.Firebug.console##log(el);
      Js_of_ocaml.Js.Unsafe.global##.Prism##highlightElement(el);
    | None => Js_of_ocaml.Firebug.console##log("None")
    };
    None;
  });
  <pre className="language-reason">
    <code ref={ReactDOM.Ref.domRef(codeRef)}> {text |> React.string} </code>
  </pre>;
};
