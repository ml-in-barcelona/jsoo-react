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

[@react.component]
let make = (~name="") => {
  <div> {React.string("Hello " ++ name)} </div>;
};

let makeProps:
  (~name: 'name=?, ~children: 'children, ~key: string=?, unit) =>
  {
    .
    "name": Js.readonly_prop(option('name)),
    "children": Js.readonly_prop('children),
  } =
  (~name=?, ~children, ~key=?, _) => {
    [|("name", Js.Unsafe.inject(name))|]
    |> Array.append([|("children", Js.Unsafe.inject(children))|])
    |> Array.append([|("key", Js.Unsafe.inject(key))|])
    |> Js.Unsafe.obj;
  };

type action =
  | Increment
  | Decrement;

let reducer = (state, action) =>
  switch (action) {
  | Increment => state + 1
  | Decrement => state - 1
  };

let greeting = props => {
  let name = Js.Opt.get(props##.name |> Js.Opt.option, () => "Billy");
  let _children = props##.children;

  let (count, setCount) = React.useState(() => 0);
  let (state, dispatch) = React.useReducer(reducer, 0);

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
            ReactDOM.domProps(~onClick=?Some(_ => setCount(c => c + 1)), ()),
          ),
        [|"Count: " ++ string_of_int(count) |> React.string|],
      ),
      ReactDOM.createDOMElementVariadic(
        "button",
        ~props=?
          Some(
            ReactDOM.domProps(
              ~onClick=?Some(_ => dispatch @@ Decrement),
              (),
            ),
          ),
        [|"Dec" |> React.string|],
      ),
      ReactDOM.createDOMElementVariadic(
        "span",
        ~props=?None,
        [|string_of_int(state) |> React.string|],
      ),
      ReactDOM.createDOMElementVariadic(
        "button",
        ~props=?
          Some(
            ReactDOM.domProps(
              ~onClick=?Some(_ => dispatch @@ Increment),
              (),
            ),
          ),
        [|"Inc" |> React.string|],
      ),
    |],
  );
};

let make = greeting;
