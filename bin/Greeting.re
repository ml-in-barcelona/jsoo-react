module Js = Js_of_ocaml.Js;

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
  (~one=?, ~children, ~key=?, _) => {
    React.Utils.(
      [|("one", Js.Unsafe.inject(one))|]
      |> Array.append([|("children", Js.Unsafe.inject(children))|])
      |> Array.append([|("key", Js.Unsafe.inject(key))|])
    )
    |> Js.Unsafe.obj;
  };

let make = props => {
  let one = Js.Opt.get(props##.one |> Js.Opt.option, () => "");
  let children = props##.children;

  ReactDOMRe.createDOMElementVariadic(
    "div",
    ~props=?None,
    Array.append(children, [|one |> React.string|]) |> Js.array,
  );
};
