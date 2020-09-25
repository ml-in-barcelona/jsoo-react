open Webtest.Suite;
module Js = Js_of_ocaml.Js;
module Html = Js_of_ocaml.Dom_html;
module Dom = Js_of_ocaml.Dom;
let act = ReactDOMTestUtils.act;

let jsdom = Jsdom.make(~html="<!doctype html><html><body></body></html>");

let doc = jsdom |> Jsdom.window |> Jsdom.document;

// React.js reads from global `window` and `document`
let () = Js.Unsafe.global##.document := doc;

let () = Js.Unsafe.global##.window := jsdom |> Jsdom.window;

let withContainer = f => {
  let container = Html.createDiv(doc);
  Dom.appendChild(doc##.body, container);
  let result = f(container);
  ignore(ReactDOM.unmountComponentAtNode(container));
  Dom.removeChild(doc##.body, container);
  result;
};

let testDom = () => {
  doc##.title := Js.string("Testing");
  let p = Html.createP(doc);
  p##.innerHTML := Js.string("Loading graph...");
  Dom.appendChild(doc##.body, p);
  assert_equal(doc##.title, Js.string("Testing"));
  assert_equal(p##.innerHTML, Js.string("Loading graph..."));
};

let testReact = () =>
  withContainer(c => {
    act(() => {
      ReactDOM.render(
        <div> {"Hello world!" |> React.string} </div>,
        Html.element(c),
      )
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("Hello world!")));
  });

let testUseEffect = () => {
  module UseEffect = {
    [@react.component]
    let make = () => {
      let (count, setCount) = React.useState(() => 0);
      React.useEffect0(() => {
        setCount(count => count + 1);
        None;
      });
      <div> {Printf.sprintf("`count` is %d", count) |> React.string} </div>;
    };
  };
  withContainer(c => {
    act(() => {ReactDOM.render(<UseEffect />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
  });
};

let testUseEffect2 = () => {
  module Add2 = {
    [@react.component]
    let make = (~a, ~b) => {
      let (count, setCount) = React.useState(() => 0);
      React.useEffect2(
        () => {
          setCount(_ => a + b);
          None;
        },
        (a, b),
      );
      <div> {Printf.sprintf("`a + b` is %d", count) |> React.string} </div>;
    };
  };
  withContainer(c => {
    act(() => {ReactDOM.render(<Add2 a=1 b=2 />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`a + b` is 3")));
    act(() => {ReactDOM.render(<Add2 a=1 b=2 />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`a + b` is 3")));
    act(() => {ReactDOM.render(<Add2 a=2 b=3 />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`a + b` is 5")));
  });
};

let testUseEffect3 = () => {
  module Use3 = {
    [@react.component]
    let make = (~a, ~b, ~c) => {
      let (count, setCount) = React.useState(() => 0);
      React.useEffect3(
        () => {
          setCount(count => count + 1);
          None;
        },
        (a, b, c),
      );
      <div> {Printf.sprintf("`count` is %d", count) |> React.string} </div>;
    };
  };
  withContainer(c => {
    let emptyList = [];
    let fooString = "foo"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    let barString = "bar";
    act(() => {
      ReactDOM.render(<Use3 a=1 b=fooString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {
      ReactDOM.render(<Use3 a=1 b=fooString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {
      ReactDOM.render(<Use3 a=2 b=fooString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 2")));
    act(() => {
      ReactDOM.render(<Use3 a=2 b=barString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 3")));
    act(() => {
      ReactDOM.render(<Use3 a=2 b=barString c=[2] />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 4")));
  });
};
let basic = "basic" >::: ["testDom" >:: testDom, "testReact" >:: testReact];

let useEffect =
  "useEffect"
  >::: [
    "testUseEffect" >:: testUseEffect,
    "testUseEffect2" >:: testUseEffect2,
    "testUseEffect3" >:: testUseEffect3,
  ];

let suite = "baseSuite" >::: [basic, useEffect];

let () = Webtest_js.Runner.run(suite);
