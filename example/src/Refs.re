open Bindings;
open Js_of_ocaml;

module FancyLink = {
  [@react.component]
  let make =
    React.Dom.forwardRef((~href, ~repo, ref) =>
      <a ref href className="FancyLink"> {repo |> React.string} </a>
    );
};

[@react.component]
let make = () => {
  let (show, setShow) = React.useState(() => true);
  /* You can now get a ref directly to the DOM button: */
  let ref =
    React.Dom.Ref.callbackDomRef(ref => {
      Console.log(Js.string("Ref is:"));
      Console.log(ref);
    });
  <>
    <button
      key="toggle"
      onClick={_ => setShow(s => !s)}
      style={React.Dom.Style.make(~marginRight="15px", ())}>
      {"Toggle fancy link" |> React.string}
    </button>
    {show
       ? <FancyLink
           href="https://github.com/jchavarri/jsoo-react/"
           key="fancy-link"
           repo="jsoo-react GitHub repo"
           ref
         />
       : React.null}
    <p>
      {"Open the console to see the value of the ref changing." |> React.string}
    </p>
  </>;
};
