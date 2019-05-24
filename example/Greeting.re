module Js = Js_of_ocaml.Js;
module Firebug = Js_of_ocaml.Firebug;
/* This is your familiar handleClick from ReactJS. This mandatorily takes the payload,
   then the `self` record, which contains state (none here), `handle`, `send`
   and other utilities */
let handleClick = _event => print_endline("clicked!");

/* Which desugars to
   `let make = ({name}) => ...` */
// [@react.component]
// let make = (~name, ()) => {
/*React.useEffect(() => {
    print_endline("Hey!");
    None;
  });
    ReactDOMRe.react##.createElement(
      "div",
      ()
    );*/
//   <div onClick=handleClick></div>;
// };

let makeProps:
  (~one: 'one=?, ~children: 'children, ~key: string=?, unit) =>
  {
    .
    "one": Js.readonly_prop(option('one)),
    "children": Js.readonly_prop('children),
  } =
  (~one=?, ~children, ~key=?, unit) =>
    React.Utils.(
      optInj("one", one)
      |> Array.append([|("children", Js.Unsafe.inject(children))|])
      |> Array.append(optInj("key", key))
    )
    |> Js.Unsafe.obj;

let make =
    (
      props: {
        .
        "one": Js.readonly_prop(option(string)),
        "children": Js.readonly_prop('children),
      },
    ) => {
  let one =
    switch (props##.one) {
    | Some(one) => one
    | None => ""
    };
  let children = props##.children;

  // ReactDOMRe.createDOMElementVariadic("div", ~props=?None, children);
};
