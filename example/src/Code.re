[@react.component]
let make = (~text) => {
  <pre> <code> {text |> React.string} </code> </pre>;
};
