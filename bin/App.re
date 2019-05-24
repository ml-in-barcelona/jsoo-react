// <Greeting one="Joe"> "Hey " |> React.string </Greeting>
let greeting =
  React.createElementVariadic(
    Greeting.make,
    Greeting.makeProps(~one="Joe", ~children=[|"Hey " |> React.string|], ()),
    [|"Hey there " |> React.string|],
  );

ReactDOMRe.renderToElementWithId(greeting, "app");
