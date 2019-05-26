// <Greeting name="Joe"> "Hey " |> React.string </Greeting>
let greeting =
  React.createElement(
    Greeting.make,
    Greeting.makeProps(~children=[|"Hello " |> React.string|], ()),
  );

ReactDOM.renderToElementWithId(greeting, "app");
