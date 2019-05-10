/* let greeting = <Greeting name=4 />; */

let greeting =
  React.createElement(Greeting.make, Greeting.makeProps(~name="Joe", ()));

/* ReactDOMRe.renderToElementWithId(greeting, "app"); */