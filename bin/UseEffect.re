[@react.component]
let make = (~count) => {
  React.useEffect1(() => {
    print_endline("useEffect: count state updated to " ++ string_of_int(count));
    Some(() => ());
  }, [|count|]);

  React.useLayoutEffect(() => {
    print_endline("useLayoutEffect: component updated")
    Some(() => ());
  });

  <div></div>
};