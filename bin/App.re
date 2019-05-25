// <Greeting one="Joe"> "Hey " |> React.string </Greeting>
let greeting =
  React.createElement(
    Greeting.make,
    Greeting.makeProps(~one="Joe", ~children=[|"Hello " |> React.string|], ()),
  );

ReactDOM.renderToElementWithId(greeting, "app");
