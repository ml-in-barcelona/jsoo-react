let test = <GreetingOCaml name="Hanna" />;

let greeting = <GreetingReason name="Bill"> test </GreetingReason>;

ReactDOM.renderToElementWithId(greeting, "app");
