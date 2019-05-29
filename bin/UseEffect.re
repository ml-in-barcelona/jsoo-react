[@react.component]
let make = (~count) => {
  print_endline(string_of_int(count));
  open Js_of_ocaml_lwt;
  React.useEffect1(
    () => {
      let x = Lwt_js.sleep(1.);
      Lwt.bind(
        x,
        () => {
          print_endline(
            "count changed 1 sec ago! Last value was: " ++ string_of_int(count),
          );
          Lwt.return();
        },
      )
      |> ignore;
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
    {"UseEffect: printing delayed counts on the console since 2019 :)" |> React.string}
  </div>;
};
