[@react.component]
let make = (~count) => {
  open Js_of_ocaml_lwt;
  React.useEffect1(
    () => {
      open Lwt;
      open Lwt_js;
      sleep(1.)
      ->bind(() => {
          print_endline(
            "count changed 1 sec ago! Previous value was: "
            ++ string_of_int(count),
          );
          return();
        })
      ->ignore;
      Some(
        () =>
          print_endline(
            "unmounting previous effect for count: " ++ string_of_int(count),
          ),
      );
    },
    [|count|],
  );

  React.useLayoutEffect(() => {
    print_endline("useLayoutEffect: component updated");
    None;
  });

  <div>
    {"UseEffect: printing delayed counts on the console since 2019 :)"
     |> React.string}
  </div>;
};
