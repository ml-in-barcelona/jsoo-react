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

let debugContent = container =>
  print_endline(
    Js.to_string(
      Js.Opt.get(container##.textContent, () => Js.string("missing")),
    ),
  );

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

let testContext = () => {
  module DummyContext = {
    let context = React.createContext("foo");
    module Provider = {
      include React.Context;
      let make = provider(context);
    };
    module Consumer = {
      [@react.component]
      let make = () => {
        let value = React.useContext(context);
        <div> {value |> React.string} </div>;
      };
    };
  };
  withContainer(c => {
    act(() => {
      ReactDOM.render(
        <DummyContext.Provider value="bar">
          <DummyContext.Consumer />
        </DummyContext.Provider>,
        Html.element(c),
      )
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("bar")));
  });
};

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

let testUseCallback1 = () => {
  module UseCallback = {
    [@react.component]
    let make = (~a) => {
      let ((count, str), setCountStr) =
        React.useState(() => (0, "init and"));
      let f =
        React.useCallback1(input => {input ++ " " ++ a ++ " and"}, [|a|]);
      React.useEffect1(
        () => {
          setCountStr(((count, str)) => (count + 1, f(str)));
          None;
        },
        [|f|],
      );
      <div>
        {Printf.sprintf("`count` is %d, `str` is %s", count, str)
         |> React.string}
      </div>;
    };
  };
  withContainer(c => {
    let fooString = "foo"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    act(() => {
      ReactDOM.render(<UseCallback a=fooString />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`count` is 1, `str` is init and foo and")),
    );
    act(() => {
      ReactDOM.render(<UseCallback a=fooString />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`count` is 1, `str` is init and foo and")),
    );
    act(() => {ReactDOM.render(<UseCallback a="bar" />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 2, `str` is init and foo and bar and"),
      ),
    );
  });
};

let testUseCallback4 = () => {
  module UseCallback = {
    [@react.component]
    let make = (~a, ~b, ~d, ~e) => {
      let ((count, str), setCountStr) = React.useState(() => (0, "init"));
      let f =
        React.useCallback4(
          _input => {
            Printf.sprintf(
              "a: %s, b: %d, d: [%d], e: [|%d|]",
              a,
              b,
              List.nth(d, 0),
              e[0],
            )
          },
          (a, b, d, e),
        );
      React.useEffect1(
        () => {
          setCountStr(((count, str)) => (count + 1, f(str)));
          None;
        },
        [|f|],
      );
      <div>
        {Printf.sprintf("`count` is %d, `str` is %s", count, str)
         |> React.string}
      </div>;
    };
  };
  withContainer(c => {
    let a = "foo"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    let a2 = "bar"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    let b = 2;
    let d = [3];
    let e = [|4|];
    act(() => {ReactDOM.render(<UseCallback a b d e />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 1, `str` is a: foo, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {ReactDOM.render(<UseCallback a b d e />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 1, `str` is a: foo, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      ReactDOM.render(<UseCallback a=a2 b d e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 2, `str` is a: bar, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      ReactDOM.render(<UseCallback a=a2 b d e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 2, `str` is a: bar, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      ReactDOM.render(<UseCallback a=a2 b=3 d e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 3, `str` is a: bar, b: 3, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      ReactDOM.render(<UseCallback a=a2 b=3 d=[4] e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 4, `str` is a: bar, b: 3, d: [4], e: [|4|]"),
      ),
    );
  });
};

let testUseMemo1 = () => {
  module UseMemo = {
    [@react.component]
    let make = (~a) => {
      let (count, setCount) = React.useState(() => 0);
      let result = React.useMemo1(() => {a ++ "2"}, [|a|]);
      React.useEffect1(
        () => {
          setCount(count => count + 1);
          None;
        },
        [|result|],
      );
      <div> {Printf.sprintf("`count` is %d", count) |> React.string} </div>;
    };
  };
  withContainer(c => {
    let fooString = "foo"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    act(() => {ReactDOM.render(<UseMemo a=fooString />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {ReactDOM.render(<UseMemo a=fooString />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {ReactDOM.render(<UseMemo a="foo" />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 2")));
  });
};

let testCreateRef = () => {
  let reactRef = React.createRef();
  assert_equal(React.Ref.current(reactRef), Js_of_ocaml.Js.null);
  React.Ref.setCurrent(reactRef, Js_of_ocaml.Js.Opt.return(1));
  assert_equal(React.Ref.current(reactRef), Js_of_ocaml.Js.Opt.return(1));
};

let testUseRef = () => {
  module DummyComponentWithRefAndEffect = {
    [@react.component]
    let make = (~cb, ()) => {
      let myRef = React.useRef(1);
      React.useEffect0(() => {
        React.Ref.(setCurrent(myRef, current(myRef) + 1));
        cb(myRef);
        None;
      });
      <div />;
    };
  };
  withContainer(c => {
    let myRef = ref(None);
    let cb = reactRef => {
      myRef := Some(reactRef);
    };

    act(() => {
      ReactDOM.render(<DummyComponentWithRefAndEffect cb />, Html.element(c))
    });
    assert_equal(
      myRef.contents |> Option.map(item => {item |> React.Ref.current}),
      Some(2),
    );
  });
};

let basic = "basic" >::: ["testDom" >:: testDom, "testReact" >:: testReact];

let context = "context" >::: ["testContext" >:: testContext];

let useEffect =
  "useEffect"
  >::: [
    "testUseEffect" >:: testUseEffect,
    "testUseEffect2" >:: testUseEffect2,
    "testUseEffect3" >:: testUseEffect3,
  ];

let useCallback =
  "useCallback"
  >::: [
    "useCallback1" >:: testUseCallback1,
    "useCallback4" >:: testUseCallback4,
  ];

let useMemo = "useMemo" >::: ["useMemo1" >:: testUseMemo1];

let refs =
  "refs" >::: ["createRef" >:: testCreateRef, "useRef" >:: testUseRef];

let suite =
  "baseSuite" >::: [basic, context, useEffect, useCallback, useMemo, refs];

let () = Webtest_js.Runner.run(suite);
