// Interfaces

module type Foo = {
  [@react.component]
  let make:
    (
      ~title: string=?,
      ~defaultTitle: string=?,
      ~meta: array(metaField)=?,
      ~htmlAttributes: array(htmlAttribute)=?,
      ~children: React.element
    ) =>
    React.element;
};

// Components

[@react.component]
let make = (~name="") => {
  <>
    <div> {React.string("Hello " ++ name)} </div>
    <Hello one="1"> {React.string("Hello " ++ name)} </Hello>
  </>;
};

[@react.component]
let make = (~a, ~b, _) => {
  print_endline("This function should be named `Test`");
  <div />;
};

module External = {
  [@react.component] [@otherAttribute "bla"]
  external component: (~a: int, ~b: string, _) => React.element;
};

module Bar = {
  [@react.component]
  let make = (~a, ~b, _) => {
    print_endline("This function should be named `Test$Bar`");
    <div />;
  };
  [@react.component]
  let component = (~a, ~b, _) => {
    print_endline("This function should be named `Test$Bar$component`");
    <div />;
  };
};

module type X_int = {let x: int;};

module Func = (M: X_int) => {
  let x = M.x + 1;
  [@react.component]
  let make = (~a, ~b, _) => {
    print_endline("This function should be named `Test$Func`", M.x);
    <div />;
  };
};

module ForwardRef = {
  [@react.component]
  let make =
    React.forwardRef(theRef =>
      <div ref=theRef> {React.string("ForwardRef")} </div>
    );
};

let fragment = foo => [@bla] <> foo </>;

let polyChildrenFragment = (foo, bar) => <> foo bar </>;

let nestedFragment = (foo, bar, baz) => <> foo <> bar baz </> </>;

let upper = <Upper />;

let upperWithProp = <Upper count />;

let upperWithChild = foo => <Upper> foo </Upper>;

let upperWithChildren = (foo, bar) => <Upper> foo bar </Upper>;

let lower = <lower />;

let lowerWithChildAndProps = foo => <lower a=1 b="1"> foo </lower>;

let lowerWithChildren = (foo, bar) => <lower> foo bar </lower>;

let lowerWithChildrenComplex =
  <div className="flex-container">
    <div className="sidebar">
      <h2 className="title"> {"jsoo-react" |> s} </h2>
      <nav className="menu">
        <ul>
          {examples
           |> List.map(e => {
                <li key={e.path}>
                  <a
                    href={e.path}
                    onClick={event => {
                      ReactEvent.Mouse.preventDefault(event);
                      ReactRouter.push(e.path);
                    }}>
                    {e.title |> s}
                  </a>
                </li>
              })
           |> React.list}
        </ul>
      </nav>
    </div>
  </div>;

let lowerWithChildrenComplex2 =
  <div className="content-wrapper">
    <div className="content">
      {let example =
         examples
         |> List.find_opt(e => {
              e.path
              == (List.nth_opt(url.path, 0) |> Option.value(~default=""))
            })
         |> Option.value(~default=firstExample);
       <div>
         <h2> {example.title |> s} </h2>
         <h4> {"Rendered component" |> s} </h4>
         {example.element}
         <h4> {"Code" |> s} </h4>
         {example.code}
       </div>}
    </div>
  </div>;

let nestedElement = <Foo.Bar a=1 b="1" />;

// TODO: fix this test (are these components deprecated??)
// let nestedElementCustomName = <Foo.component a=1 b="1" />;

// This throws exception (expected)
// let lowerSpread = value => <lower> ...value </lower>;
