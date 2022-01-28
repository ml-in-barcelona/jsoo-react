const React = require("react");

function Greeting({
  name,
  strong,
}) {
  var name = strong === true
      ? React.createElement("strong", null, name)
      : name;

  return React.createElement("span", null, "Hey ", name);
}

exports.Greeting = Greeting;

function GreetingChildren({
  children
}) {
  return React.createElement("span", null, "Hey ", children);
}

exports.GreetingChildren = GreetingChildren;

// React.forwardRef is a non-function wrapper component, at least at time of writing
exports.NonFunctionGreeting = React.forwardRef(Greeting);
