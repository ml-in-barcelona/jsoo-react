const React = require("react");

function Greeting({
  name
}) {
  return React.createElement("span", null, "Hey ", name);
}

exports.Greeting = Greeting;

function GreetingChildren({
  children
}) {
  return React.createElement("span", null, "Hey ", children);
}

exports.GreetingChildren = GreetingChildren;
