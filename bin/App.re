// <Greeting name="Joe"> "Hey " |> React.string </Greeting>
let greeting =
  React.createElement(
    GreetingReason.make,
    GreetingReason.makeProps(~children=[|"Hello " |> React.string|], ()),
  );

let test =
  React.createElement(
    GreetingOCaml.make,
    GreetingOCaml.makeProps(~name="Hello ", ()),
  );

// ReactDOM.renderToElementWithId(greeting, "app");
