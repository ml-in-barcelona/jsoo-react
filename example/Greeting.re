let component = React.statelessComponent("Greeting");

/* underscores before names indicate unused variables. We name them for clarity */
let make = (~name, _children) => {
  ...component,
  render: _self =>
    ReactDOM.createElement(
      "div",
      ~props=ReactDOM.props(~alt="alt", ()),
      [|React.string(name)|],
    ),
};