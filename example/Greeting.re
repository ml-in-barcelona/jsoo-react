let component = React.statelessComponent("Greeting");

/* underscores before names indicate unused variables. We name them for clarity */
let make = (~name, _children) => {
  ...component,
  render: (_self) => <button> {React.string("Hello " ++ name ++ "!")} </button>
};