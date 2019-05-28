let test = <GreetingOCaml name="Hanna" />;

let greeting =
  <GreetingReason name="Bill"> <> test <div /> </> </GreetingReason>;

ReactDOM.renderToElementWithId(greeting, "app");
