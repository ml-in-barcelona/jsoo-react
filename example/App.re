/* let greeting = <Greeting name=4 />; */

// let greeting =
//   React.createElement(
//     Greeting.make,
//     Greeting.makeProps(~one="Joe", ~children=[||], ()),
//   );

let bar = Greeting.makeProps(~one="Joe", ~children=[|2|], ());
let foo = React.createElement(_, bar);
/* ReactDOMRe.renderToElementWithId(greeting, "app"); */
