const React = require("react");

function Greeting({
  name
}) {
  return React.createElement("span", null, "Hey ", name);
}

exports.Greeting = Greeting;
