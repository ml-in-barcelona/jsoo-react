let log = a => Js_of_ocaml.Firebug.console##log(a);

module FancyLink = {
  [@react.component]
  let make =
    ReactDOM.forwardRef(ref =>
      <a ?ref href="https://github.com/jchavarri/rroo/" className="FancyLink">
        {"rroo GitHub repo" |> React.string}
      </a>
    );
};

[@react.component]
let make = () => {
  let (show, setShow) = React.useState(() => true);
  // You can now get a ref directly to the DOM button:
  let ref =
    ReactDOM.Ref.callbackDomRef(ref => {
      log(Js_of_ocaml.Js.string("Ref is:"));
      log(ref);
    });
  <>
    <button onClick={_ => setShow(s => !s)}>
      {"Toggle fancy link" |> React.string}
    </button>
    {show ? <FancyLink ref /> : React.null}
  </>;
};
