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

let printTextContent = container =>
  print_endline(
    Js.to_string(
      Js.Opt.get(container##.textContent, () => Js.string("missing")),
    ),
  );
let printInnerHTML = (container: Js.t(Html.divElement)) =>
  print_endline(Js.to_string(container##.innerHTML));

let withContainer = f => {
  let container = Html.createDiv(doc);
  Dom.appendChild(doc##.body, container);
  let result = f(container);
  ignore(React.Dom.unmountComponentAtNode(container));
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
      React.Dom.render(
        <div> {"Hello world!" |> React.string} </div>,
        Html.element(c),
      )
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("Hello world!")));
  });

let testKeys = () =>
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <div>
          ...{List.map(
            str => <div key=str> {str |> React.string} </div>,
            ["a", "b"],
          )}
        </div>,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string("<div><div>a</div><div>b</div></div>"),
    );
  });

let testOptionalPropsUppercase = () => {
  module OptProps = {
    [@react.component]
    let make = (~name="joe") => {
      <div> {Printf.sprintf("`name` is %s", name) |> React.string} </div>;
    };
  };
  withContainer(c => {
    act(() => {React.Dom.render(<OptProps />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`name` is joe")),
    );
    act(() => {React.Dom.render(<OptProps name="jane" />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`name` is jane")),
    );
  });
};

let testOptionalPropsLowercase = () => {
  module LinkWithMaybeHref = {
    [@react.component]
    let make = (~href) => <a ?href />;
  };

  withContainer(c => {
    act(() =>
      React.Dom.render(<LinkWithMaybeHref href=None />, Html.element(c))
    );
    assert_equal(c##.innerHTML, Js.string("<a></a>"));
    act(() =>
      React.Dom.render(
        <LinkWithMaybeHref href={Some("https://google.es")} />,
        Html.element(c),
      )
    );
    assert_equal(
      c##.innerHTML,
      Js.string({|<a href="https://google.es"></a>|}),
    );
  });
};

let testContext = () => {
  module DummyContext = {
    let context = React.createContext("foo");
    module Provider = {
      let make = React.Context.provider(context);
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
      React.Dom.render(
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
    act(() => {React.Dom.render(<UseEffect />, Html.element(c))});
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
    act(() => {React.Dom.render(<Add2 a=1 b=2 />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`a + b` is 3")));
    act(() => {React.Dom.render(<Add2 a=1 b=2 />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`a + b` is 3")));
    act(() => {React.Dom.render(<Add2 a=2 b=3 />, Html.element(c))});
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
      React.Dom.render(<Use3 a=1 b=fooString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {
      React.Dom.render(<Use3 a=1 b=fooString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {
      React.Dom.render(<Use3 a=2 b=fooString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 2")));
    act(() => {
      React.Dom.render(<Use3 a=2 b=barString c=emptyList />, Html.element(c))
    });
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 3")));
    act(() => {
      React.Dom.render(<Use3 a=2 b=barString c=[2] />, Html.element(c))
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
      React.Dom.render(<UseCallback a=fooString />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`count` is 1, `str` is init and foo and")),
    );
    act(() => {
      React.Dom.render(<UseCallback a=fooString />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`count` is 1, `str` is init and foo and")),
    );
    act(() => {React.Dom.render(<UseCallback a="bar" />, Html.element(c))});
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
    act(() => {React.Dom.render(<UseCallback a b d e />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 1, `str` is a: foo, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {React.Dom.render(<UseCallback a b d e />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 1, `str` is a: foo, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      React.Dom.render(<UseCallback a=a2 b d e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 2, `str` is a: bar, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      React.Dom.render(<UseCallback a=a2 b d e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 2, `str` is a: bar, b: 2, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      React.Dom.render(<UseCallback a=a2 b=3 d e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 3, `str` is a: bar, b: 3, d: [3], e: [|4|]"),
      ),
    );
    act(() => {
      React.Dom.render(<UseCallback a=a2 b=3 d=[4] e />, Html.element(c))
    });
    assert_equal(
      c##.textContent,
      Js.Opt.return(
        Js.string("`count` is 4, `str` is a: bar, b: 3, d: [4], e: [|4|]"),
      ),
    );
  });
};

let testUseState = () => {
  module DummyStateComponent = {
    [@react.component]
    let make = (~initialValue=0, ()) => {
      let (counter, setCounter) = React.useState(() => initialValue);
      <>
        <div className="value"> {React.int(counter)} </div>
        <button onClick={_ => setCounter(counter => counter + 1)}>
          {React.string("Increment")}
        </button>
        <button onClick={_ => setCounter(counter => counter - 1)}>
          {React.string("Decrement")}
        </button>
      </>;
    };
  };
  withContainer(c => {
    open ReactDOMTestUtils;
    act(() => {React.Dom.render(<DummyStateComponent />, Html.element(c))});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">0</div><button>Increment</button><button>Decrement</button>",
      ),
    );
    let button =
      DOM.findBySelectorAndPartialTextContent(
        unsafe_to_element(c),
        "button",
        "Increment",
      );
    act(() => {Simulate.click(button)});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">1</div><button>Increment</button><button>Decrement</button>",
      ),
    );
    let button =
      DOM.findBySelectorAndPartialTextContent(
        unsafe_to_element(c),
        "button",
        "Decrement",
      );
    act(() => {Simulate.click(button)});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">0</div><button>Increment</button><button>Decrement</button>",
      ),
    );
  });
};

let testUseStateUpdaterReference = () => {
  module UseState = {
    let prevSetCount = ref(None);
    [@react.component]
    let make = () => {
      let (_count, setCount) = React.useState(() => 0);
      let equal =
        switch (setCount, prevSetCount^) {
        | (r1, Some(r2)) when r1 === r2 => "true"
        | _ => "false"
        };
      prevSetCount := Some(setCount);
      <div> {equal |> React.string} </div>;
    };
  };
  withContainer(c => {
    act(() => {React.Dom.render(<UseState />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("false")));
    act(() => {React.Dom.render(<UseState />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("true")));
  });
};

let testUseReducer = () => {
  module DummyReducerComponent = {
    type action =
      | Increment
      | Decrement;
    [@react.component]
    let make = (~initialValue=0, ()) => {
      let (state, send) =
        React.useReducer(
          (state, action) =>
            switch (action) {
            | Increment => state + 1
            | Decrement => state - 1
            },
          initialValue,
        );

      <>
        <div className="value"> {React.int(state)} </div>
        <button onClick={_ => send(Increment)}>
          {React.string("Increment")}
        </button>
        <button onClick={_ => send(Decrement)}>
          {React.string("Decrement")}
        </button>
      </>;
    };
  };
  withContainer(c => {
    open ReactDOMTestUtils;
    act(() => {
      React.Dom.render(<DummyReducerComponent />, Html.element(c))
    });
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">0</div><button>Increment</button><button>Decrement</button>",
      ),
    );
    let button =
      DOM.findBySelectorAndPartialTextContent(
        unsafe_to_element(c),
        "button",
        "Increment",
      );
    act(() => {Simulate.click(button)});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">1</div><button>Increment</button><button>Decrement</button>",
      ),
    );
    let button =
      DOM.findBySelectorAndPartialTextContent(
        unsafe_to_element(c),
        "button",
        "Decrement",
      );
    act(() => {Simulate.click(button)});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">0</div><button>Increment</button><button>Decrement</button>",
      ),
    );
  });
};

let testUseReducerWithMapState = () => {
  module DummyReducerWithMapStateComponent = {
    type action =
      | Increment
      | Decrement;
    [@react.component]
    let make = (~initialValue=0, ()) => {
      let (state, send) =
        React.useReducerWithMapState(
          (state, action) =>
            switch (action) {
            | Increment => state + 1
            | Decrement => state - 1
            },
          initialValue,
          initialValue => initialValue + 1,
        );

      <>
        <div className="value"> {React.int(state)} </div>
        <button onClick={_ => send(Increment)}>
          {React.string("Increment")}
        </button>
        <button onClick={_ => send(Decrement)}>
          {React.string("Decrement")}
        </button>
      </>;
    };
  };
  withContainer(c => {
    open ReactDOMTestUtils;
    act(() => {
      React.Dom.render(
        <DummyReducerWithMapStateComponent />,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">1</div><button>Increment</button><button>Decrement</button>",
      ),
    );
    let button =
      DOM.findBySelectorAndPartialTextContent(
        unsafe_to_element(c),
        "button",
        "Increment",
      );
    act(() => {Simulate.click(button)});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">2</div><button>Increment</button><button>Decrement</button>",
      ),
    );
    let button =
      DOM.findBySelectorAndPartialTextContent(
        unsafe_to_element(c),
        "button",
        "Decrement",
      );
    act(() => {Simulate.click(button)});
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div class=\"value\">1</div><button>Increment</button><button>Decrement</button>",
      ),
    );
  });
};

let testUseReducerDispatchReference = () => {
  module UseReducer = {
    let prevDispatch = ref(None);
    [@react.component]
    let make = () => {
      let (_, dispatch) = React.useReducer((_, _) => 2, 2);
      let equal =
        switch (dispatch, prevDispatch^) {
        | (r1, Some(r2)) when r1 === r2 => "true"
        | _ => "false"
        };
      prevDispatch := Some(dispatch);
      <div> {equal |> React.string} </div>;
    };
  };
  withContainer(c => {
    act(() => {React.Dom.render(<UseReducer />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("false")));
    act(() => {React.Dom.render(<UseReducer />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("true")));
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
    act(() => {React.Dom.render(<UseMemo a=fooString />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {React.Dom.render(<UseMemo a=fooString />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 1")));
    act(() => {React.Dom.render(<UseMemo a="foo" />, Html.element(c))});
    assert_equal(c##.textContent, Js.Opt.return(Js.string("`count` is 2")));
  });
};

let testMemo = () => {
  let numRenders = ref(0);
  module Memoized = {
    [@react.component]
    let make =
      React.memo((~a) => {
        numRenders := numRenders^ + 1;
        <div>
          {Printf.sprintf("`a` is %s, `numRenders` is %d", a, numRenders^)
           |> React.string}
        </div>;
      });
  };
  withContainer(c => {
    let fooString = "foo"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    act(() => {React.Dom.render(<Memoized a=fooString />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`a` is foo, `numRenders` is 1")),
    );
    act(() => {React.Dom.render(<Memoized a=fooString />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`a` is foo, `numRenders` is 1")),
    );
    act(() => {React.Dom.render(<Memoized a="bar" />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`a` is bar, `numRenders` is 2")),
    );
  });
};

let testMemoCustomCompareProps = () => {
  let numRenders = ref(0);
  module Memoized = {
    [@react.component]
    let make =
      React.memoCustomCompareProps(
        (~a) => {
          numRenders := numRenders^ + 1;
          <div>
            {Printf.sprintf("`a` is %s, `numRenders` is %d", a, numRenders^)
             |> React.string}
          </div>;
        },
        (_prevPros, _nextProps) => true,
      );
  };
  withContainer(c => {
    let fooString = "foo"; /* strings in OCaml are boxed, and we want to keep same reference across renders */
    act(() => {React.Dom.render(<Memoized a=fooString />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`a` is foo, `numRenders` is 1")),
    );
    act(() => {React.Dom.render(<Memoized a=fooString />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`a` is foo, `numRenders` is 1")),
    );
    act(() => {React.Dom.render(<Memoized a="bar" />, Html.element(c))});
    assert_equal(
      c##.textContent,
      Js.Opt.return(Js.string("`a` is foo, `numRenders` is 1")),
    );
  });
};

let testCreateRef = () => {
  let reactRef = React.createRef();
  assert_equal(React.Ref.current(reactRef), Js_of_ocaml.Js.null);
  React.Ref.setCurrent(reactRef, Js_of_ocaml.Js.Opt.return(1));
  assert_equal(React.Ref.current(reactRef), Js_of_ocaml.Js.Opt.return(1));
};

let testForwardRef = () => {
  module FancyButton = {
    [@react.component]
    let make =
      React.Dom.forwardRef((~children, ref) => {
        <button ref className="FancyButton"> ...children </button>
      });
  };

  withContainer(c => {
    let count = ref(0);
    let buttonRef =
      React.Dom.Ref.callbackDomRef(_ref => {count := count^ + 1});
    act(() => {
      React.Dom.render(
        <FancyButton ref=buttonRef> <div /> </FancyButton>,
        Html.element(c),
      )
    });
    assert_equal(count^, 1);
  });
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
      React.Dom.render(
        <DummyComponentWithRefAndEffect cb />,
        Html.element(c),
      )
    });
    assert_equal(
      myRef.contents |> Option.map(item => {item |> React.Ref.current}),
      Some(2),
    );
  });
};

let testChildrenMapWithIndex = () => {
  module DummyComponentThatMapsChildren = {
    [@react.component]
    let make = (~children, ()) => {
      <div>
        {React.Children.mapWithIndex(children, (element, index) => {
           React.cloneElement(
             element,
             Js_of_ocaml.Js.Unsafe.(
               obj([|
                 ("key", inject(index)),
                 ("data-index", inject(index)),
               |])
             ),
           )
         })}
      </div>;
    };
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <DummyComponentThatMapsChildren>
          <div> {React.int(1)} </div>
          <div> {React.int(2)} </div>
          <div> {React.int(3)} </div>
        </DummyComponentThatMapsChildren>,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string(
        "<div><div data-index=\"0\">1</div><div data-index=\"1\">2</div><div data-index=\"2\">3</div></div>",
      ),
    );
  });
};

let testFragmentModule = () => {
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <React.Fragment>
          <div> {React.string("Hello")} </div>
          <div> {React.string("World")} </div>
        </React.Fragment>,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string("<div>Hello</div><div>World</div>"),
    );
  });
};

let testFragmentSyntax = () => {
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <>
          <div> {React.string("Hello")} </div>
          <div> {React.string("World")} </div>
        </>,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string("<div>Hello</div><div>World</div>"),
    );
  });
};

let testNonListChildren = () => {
  module NonListChildrenComponent = {
    [@react.component]
    let make = (~children as (first, second), ()) => {
      <div> first second </div>;
    };
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <NonListChildrenComponent>
          ...(<div> {React.int(1)} </div>, <div> {React.int(3)} </div>)
        </NonListChildrenComponent>,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string("<div><div>1</div><div>3</div></div>"),
    );
  });
};

let testDangerouslySetInnerHTML = () => {
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <div
          dangerouslySetInnerHTML={React.Dom.makeInnerHtml(
            ~__html="<lol></lol>",
          )}
        />,
        Html.element(c),
      )
    });
    assert_equal(c##.innerHTML, Js.string("<div><lol></lol></div>"));
  });
};

let testExternals = () => {
  module JsComp = {
    [@react.component]
    external make: (~name: Js.t(Js.js_string)) => React.element =
      {|require("./external").Greeting|};
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(<JsComp name={Js.string("John")} />, Html.element(c))
    });
    assert_equal(c##.innerHTML, Js.string("<span>Hey John</span>"));
  });
};

let testExternalChildren = () => {
  module JsComp = {
    [@react.component]
    external make:
      (~children: Js.t(Js.js_array(React.element))) => React.element =
      {|require("./external").GreetingChildren|};
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <JsComp>
          ...{Js.array([|<em> {React.string("John")} </em>|])}
        </JsComp>,
        Html.element(c),
      )
    });
    assert_equal(c##.innerHTML, Js.string("<span>Hey <em>John</em></span>"));
  });
};

let testExternalNonFunction = () => {
  module JsComp = {
    [@react.component]
    external make: (~name: Js.t(Js.js_string)) => React.element =
      {|require("./external").NonFunctionGreeting|};
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(<JsComp name={Js.string("John")} />, Html.element(c))
    });
    assert_equal(c##.innerHTML, Js.string("<span>Hey John</span>"));
  });
};

let testExternalOptionalArg = () => {
  module JsComp = {
    [@react.component]
    external make: (~name: Js.t(Js.js_string)=?) => React.element =
      {|require("./external").Greeting|};
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(<JsComp name={Js.string("John")} />, Html.element(c))
    });
    assert_equal(c##.innerHTML, Js.string("<span>Hey John</span>"));
  });
};

let testAliasedChildren = () => {
  module AliasedChildrenComponent = {
    [@react.component]
    let make = (~children as kids, ()) => {
      <div> ...kids </div>;
    };
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(
        <AliasedChildrenComponent>
          <div> {React.int(1)} </div>
          <div> {React.int(3)} </div>
        </AliasedChildrenComponent>,
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string("<div><div>1</div><div>3</div></div>"),
    );
  });
};

let testWithId = () => {
  module WithTestId = {
    [@react.component]
    let make = (~id, ~children, ()) =>
      React.Children.map(children, child =>
        React.cloneElement(
          child,
          Js.Unsafe.obj([|
            ("data-testid", Js.Unsafe.inject(Js.string(id))),
          |]),
        )
      );
  };
  withContainer(c => {
    act(() => {
      React.Dom.render(
        WithTestId.make(~id="feed-toggle", ~children=[<div />], ()),
        Html.element(c),
      )
    });
    assert_equal(
      c##.innerHTML,
      Js.string("<div data-testid=\"feed-toggle\"></div>"),
    );
  });
};

let basic =
  "basic"
  >::: [
    "testDom" >:: testDom,
    "testReact" >:: testReact,
    "testKey" >:: testKeys,
    "testOptionalPropsUppercase" >:: testOptionalPropsUppercase,
    "testOptionalPropsLowercase" >:: testOptionalPropsLowercase,
  ];

let context = "context" >::: ["testContext" >:: testContext];

let useEffect =
  "useEffect"
  >::: [
    "useEffect" >:: testUseEffect,
    "useEffect2" >:: testUseEffect2,
    "useEffect3" >:: testUseEffect3,
  ];

let useCallback =
  "useCallback"
  >::: [
    "useCallback1" >:: testUseCallback1,
    "useCallback4" >:: testUseCallback4,
  ];

let useState =
  "useState"
  >::: [
    "useState" >:: testUseState,
    "useStateUpdaterReference" >:: testUseStateUpdaterReference,
  ];

let useReducer =
  "useReducer"
  >::: [
    "useReducer" >:: testUseReducer,
    "useReducerWithMapState" >:: testUseReducerWithMapState,
    "useReducerDispatchReference" >:: testUseReducerDispatchReference,
  ];

let memoization =
  "memo"
  >::: [
    "useMemo1" >:: testUseMemo1,
    "memo" >:: testMemo,
    "memoCustomCompareProps" >:: testMemoCustomCompareProps,
  ];

let refs =
  "refs"
  >::: [
    "createRef" >:: testCreateRef,
    "forwardRef" >:: testForwardRef,
    "useRef" >:: testUseRef,
  ];

let children =
  "children"
  >::: [
    "mapWithIndex" >:: testChildrenMapWithIndex,
    "nonListChildren" >:: testNonListChildren,
    "aliasedChildren" >:: testAliasedChildren,
    "testWithId" >:: testWithId,
  ];

let fragments =
  "fragments"
  >::: [
    "fragmentModule" >:: testFragmentModule,
    "fragmentSyntax" >:: testFragmentSyntax,
  ];

let dangerouslySetInnerHTML =
  "dangerouslySetInnerHTML" >::: ["basic" >:: testDangerouslySetInnerHTML];

let externals =
  "externals"
  >::: [
    "basic" >:: testExternals,
    "children" >:: testExternalChildren,
    "non-function" >:: testExternalNonFunction,
    "optional-arg" >:: testExternalOptionalArg,
  ];

let suite =
  "baseSuite"
  >::: [
    basic,
    context,
    useEffect,
    useCallback,
    useState,
    useReducer,
    memoization,
    refs,
    children,
    fragments,
    dangerouslySetInnerHTML,
    externals,
  ];

let () = Webtest_js.Runner.run(suite);
