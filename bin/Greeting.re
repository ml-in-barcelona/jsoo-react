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
    ReactDOM.react##.createElement(
      "div",
      ()
    );*/
//   <div onClick=handleClick></div>;
// };

let makeProps:
  (~name: 'name=?, ~children: 'children, ~key: string=?, unit) =>
  {
    .
    "name": Js.readonly_prop(option('name)),
    "children": Js.readonly_prop('children),
  } =
  (~name=?, ~children, ~key=?, _) => {
    React.Utils.(
      [|("name", Js.Unsafe.inject(name))|]
      |> Array.append([|("children", Js.Unsafe.inject(children))|])
      |> Array.append([|("key", Js.Unsafe.inject(key))|])
    )
    |> Js.Unsafe.obj;
  };

let make = props => {
  let name = Js.Opt.get(props##.name |> Js.Opt.option, () => "");
  let _children = props##.children;

  let (count, setCount) = React.useState(() => 0);

  ReactDOM.createDOMElementVariadic(
    "div",
    ~props=?None,
    [|
      ReactDOM.createDOMElementVariadic(
        "p",
        ~props=?None,
        [|"Hello " ++ name |> React.string|],
      ),
      ReactDOM.createDOMElementVariadic(
        "button",
        ~props=?
          Some(
            ReactDOM.domProps(
              ~onClick=?Some(_ => setCount(c => c + 1)),
              (),
            ),
          ),
        [|"Count: " ++ string_of_int(count) |> React.string|],
      ),
    |],
  );
};
