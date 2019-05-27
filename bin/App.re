let caml = <GreetingOCaml name="Hanna" />;

let reason = <GreetingReason name="Bill" />;

let main =
  <div>
    <h1> {"OCaml component" |> React.string} </h1>
    caml
    <h1> {"Reason component" |> React.string} </h1>
    reason
    <h1> {"Refs" |> React.string} </h1>
    <Refs />
  </div>;

ReactDOM.renderToElementWithId(main, "app");
