let caml = <GreetingOCaml name="Hanna" />;

let div = <div key="first" />;
let reason = <GreetingReason name="Bill"> <> div <div key="second"/> </> </GreetingReason>;

let main =
  <div>
    <h1 className="hello"> {"OCaml component" |> React.string} </h1>
    caml
    <h1> {"Reason component" |> React.string} </h1>
    reason
    <h1> {"Refs" |> React.string} </h1>
    <Refs />
    <h1 key="h1"> {"Interface files" |> React.string} </h1>
    <Interface key="inter" title="Hey"> React.null </Interface>
  </div>;

ReactDOM.renderToElementWithId(main, "app");
