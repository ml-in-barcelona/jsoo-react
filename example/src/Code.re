[@react.component]
let make = (~text) => {
  let codeRef = React.useRef(None);
  React.useEffect(() => {
    switch (codeRef |> React.Ref.current) {
    | Some(el) => Js_of_ocaml.Js.Unsafe.global##.Prism##highlightElement(el)
    | None => ()
    };
    Some(() => ());
  });
  <pre className="language-reason">
    <code ref={ReactDOM.Ref.domRef(codeRef)}> {text |> React.string} </code>
  </pre>;
};
