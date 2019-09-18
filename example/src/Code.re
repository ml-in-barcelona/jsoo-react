[@react.component]
let make = (~text) => {
  <pre className="language-reason">
    <code> {text |> React.string} </code>
  </pre>;
};
