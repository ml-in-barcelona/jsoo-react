let caml = <GreetingOCaml name="Hanna" />;

let div = <div key="first" />;
let reason =
  <GreetingReason name="Bill">
    <> div <div key="second" /> </>
  </GreetingReason>;

let s = React.string;

let main =
  <div className="medium-container">
    <h1 className="hello"> {"OCaml component" |> s} </h1>
    caml
    <h1> {"Reason component" |> s} </h1>
    reason
    <h1> {"Refs" |> s} </h1>
    <Refs />
    <h1 key="h1"> {"Interface files" |> s} </h1>
    <Interface key="inter" title="Hi from a component with an interface file">
      React.null
    </Interface>
    <h1 key="h1"> {"Integration with ppxs" |> s} </h1>
    <p>
      {"The following code is being read from one of the files in the project: "
       |> s}
      <code> {"Interface.re" |> s} </code>
      {"." |> s}
    </p>
    <p>
      {"It gets rendered via " |> s}
      <a href="https://github.com/johnwhitington/ppx_blob" target="_blank">
        {"ppx_blob" |> s}
      </a>
      {" by calling " |> s}
      <code> {"<Code text=[%blob \"Interface.re\"] />" |> s} </code>
      {":" |> s}
    </p>
    <Code text=[%blob "Interface.re"] />
  </div>;

ReactDOM.renderToElementWithId(main, "app");
