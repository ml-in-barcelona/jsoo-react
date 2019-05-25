// <Greeting name="Joe"> "Hey " |> React.string </Greeting>
let greeting =
  React.createElement(
    Greeting.make,
    Greeting.makeProps(~name="Joe", ~children=[|"Hello " |> React.string|], ()),
  );

ReactDOM.renderToElementWithId(greeting, "app");
