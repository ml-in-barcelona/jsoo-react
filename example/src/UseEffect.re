open Bindings;

[@react.component]
let make = (~count) => {
  open Js_of_ocaml_lwt;
  React.useEffect1(
    () => {
      open Lwt;
      open Lwt_js;
      bind(
        sleep(1.),
        () => {
          Console.log(
            "count changed 1 sec ago! Value is: " ++ string_of_int(count),
          );
          return();
        },
      )
      |> ignore;
      Some(
        () =>
          Console.log(
            "Unmounting effect for value: " ++ string_of_int(count),
          ),
      );
    },
    [|count|],
  );

  React.useLayoutEffect(() => {
    Console.log("useLayoutEffect: component updated");
    None;
  });

  <div>
    {"UseEffect: printing delayed counts on the console since 2019 :)"
     |> React.string}
  </div>;
};
