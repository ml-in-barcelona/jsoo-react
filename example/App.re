let greeting = React.element(~key="one", Greeting.make(~name="Joe", [||]));

ReactDOM.renderToElementWithId(greeting, "app");