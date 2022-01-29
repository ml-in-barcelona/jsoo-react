open React.Dom.Dsl
open Html
open Webtest.Suite
module Js = Js_of_ocaml.Js
module Html = Js_of_ocaml.Dom_html
module Dom = Js_of_ocaml.Dom

let act = ReactDOMTestUtils.act

let jsdom = Jsdom.make ~html:"<!doctype html><html><body></body></html>"

let doc = jsdom |> Jsdom.window |> Jsdom.document

let () = Js.Unsafe.global##.document := doc

let () = Js.Unsafe.global##.window := jsdom |> Jsdom.window

let printTextContent container =
  print_endline
    (Js.to_string
       (Js.Opt.get container##.textContent (fun () -> Js.string "missing")) )

let printInnerHTML (container : Html.divElement Js.t) =
  print_endline (Js.to_string container##.innerHTML)

let withContainer f =
  let container = Html.createDiv doc in
  Dom.appendChild doc##.body container ;
  let result = f container in
  ignore (React.Dom.unmountComponentAtNode container) ;
  Dom.removeChild doc##.body container ;
  result

let testDom () =
  doc##.title := Js.string "Testing" ;
  let p = Html.createP doc in
  p##.innerHTML := Js.string "Loading graph..." ;
  Dom.appendChild doc##.body p ;
  assert_equal doc##.title (Js.string "Testing") ;
  assert_equal p##.innerHTML (Js.string "Loading graph...")

let testReact () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (div [||] ["Hello world!" |> string])
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "Hello world!")) )

let testKeys () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (div [||]
               (List.map
                  (fun str -> div [|key str|] [str |> string])
                  ["a"; "b"] ) )
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string "<div><div>a</div><div>b</div></div>") )

let testOptionalPropsUppercase () =
  let module OptProps = struct
    let%component make ?(name = "joe") =
      div [||] [Printf.sprintf "`name` is %s" name |> string]
  end in
  withContainer (fun c ->
      act (fun () -> React.Dom.render (OptProps.make ()) (Html.element c)) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`name` is joe")) ;
      act (fun () ->
          React.Dom.render (OptProps.make ~name:"jane" ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`name` is jane")) )

let testOptionalPropsLowercase () =
  let module LinkWithMaybeHref = struct
    (* NOTE: collision caused by namespace pollution *)
    let%component make ~href = a [|maybe Prop.href href|] []
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (LinkWithMaybeHref.make ~href:None ())
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<a></a>") ;
      act (fun () ->
          React.Dom.render
            (LinkWithMaybeHref.make ~href:(Some "https://google.es") ())
            (Html.element c) ) ;
      printInnerHTML c ;
      assert_equal c##.innerHTML
        (Js.string {|<a href="https://google.es"></a>|}) )

let testContext () =
  let module DummyContext = struct
    let context = React.createContext "foo"

    module Provider = struct
      let make = Context.Provider.make context
    end

    module Consumer = struct
      let%component make () =
        let value = React.useContext context in
        div [||] [value |> string]
    end
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (DummyContext.Provider.make ~value:"bar"
               [DummyContext.Consumer.make ()] )
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "bar")) )

let testUseEffect () =
  let module UseEffect = struct
    let%component make () =
      let count, setCount = React.useState (fun () -> 0) in
      React.useEffect0 (fun () ->
          setCount (fun count -> count + 1) ;
          None ) ;
      div [||] [Printf.sprintf "`count` is %d" count |> string]
  end in
  withContainer (fun c ->
      act (fun () -> React.Dom.render (UseEffect.make ()) (Html.element c)) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 1")) )

let testUseEffect2 () =
  let module Add2 = struct
    let%component make ~a ~b =
      let count, setCount = React.useState (fun () -> 0) in
      React.useEffect2
        (fun () ->
          setCount (fun _ -> a + b) ;
          None )
        (a, b) ;
      div [||] [Printf.sprintf "`a + b` is %d" count |> string]
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render (Add2.make ~a:1 ~b:2 ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`a + b` is 3")) ;
      act (fun () ->
          React.Dom.render (Add2.make ~a:1 ~b:2 ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`a + b` is 3")) ;
      act (fun () ->
          React.Dom.render (Add2.make ~a:2 ~b:3 ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`a + b` is 5")) )

let testUseEffect3 () =
  let module Use3 = struct
    let%component make ~a ~b ~c =
      let count, setCount = React.useState (fun () -> 0) in
      React.useEffect3
        (fun () ->
          setCount (fun count -> count + 1) ;
          None )
        (a, b, c) ;
      div [||] [Printf.sprintf "`count` is %d" count |> string]
  end in
  withContainer (fun c ->
      let emptyList = [] in
      let fooString = "foo" in
      let barString = "bar" in
      act (fun () ->
          React.Dom.render
            (Use3.make ~a:1 ~b:fooString ~c:emptyList ())
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 1")) ;
      act (fun () ->
          React.Dom.render
            (Use3.make ~a:1 ~b:fooString ~c:emptyList ())
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 1")) ;
      act (fun () ->
          React.Dom.render
            (Use3.make ~a:2 ~b:fooString ~c:emptyList ())
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 2")) ;
      act (fun () ->
          React.Dom.render
            (Use3.make ~a:2 ~b:barString ~c:emptyList ())
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 3")) ;
      act (fun () ->
          React.Dom.render
            (Use3.make ~a:2 ~b:barString ~c:[2] ())
            (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 4")) )

let testUseCallback1 () =
  let module UseCallback = struct
    let%component make ~a =
      let (count, str), setCountStr =
        React.useState (fun () -> (0, "init and"))
      in
      let f =
        React.useCallback1 (fun input -> input ^ " " ^ a ^ " and") [|a|]
      in
      React.useEffect1
        (fun () ->
          setCountStr (fun (count, str) -> (count + 1, f str)) ;
          None )
        [|f|] ;
      div [||] [Printf.sprintf "`count` is %d, `str` is %s" count str |> string]
  end in
  withContainer (fun c ->
      let fooString = "foo" in
      act (fun () ->
          React.Dom.render (UseCallback.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`count` is 1, `str` is init and foo and")) ;
      act (fun () ->
          React.Dom.render (UseCallback.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`count` is 1, `str` is init and foo and")) ;
      act (fun () ->
          React.Dom.render (UseCallback.make ~a:"bar" ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 2, `str` is init and foo and bar and") ) )

let testUseCallback4 () =
  let module UseCallback = struct
    let%component make ~a ~b ~d ~e =
      let (count, str), setCountStr = React.useState (fun () -> (0, "init")) in
      let f =
        React.useCallback4
          (fun _input ->
            Printf.sprintf "a: %s, b: %d, d: [%d], e: [|%d|]" a b (List.nth d 0)
              e.(0) )
          (a, b, d, e)
      in
      React.useEffect1
        (fun () ->
          setCountStr (fun (count, str) -> (count + 1, f str)) ;
          None )
        [|f|] ;
      div [||] [Printf.sprintf "`count` is %d, `str` is %s" count str |> string]
  end in
  withContainer (fun c ->
      let a = "foo" in
      let a2 = "bar" in
      let b = 2 in
      let d = [3] in
      let e = [|4|] in
      act (fun () ->
          React.Dom.render (UseCallback.make ~a ~b ~d ~e ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 1, `str` is a: foo, b: 2, d: [3], e: [|4|]") ) ;
      act (fun () ->
          React.Dom.render (UseCallback.make ~a ~b ~d ~e ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 1, `str` is a: foo, b: 2, d: [3], e: [|4|]") ) ;
      act (fun () ->
          React.Dom.render (UseCallback.make ~a:a2 ~b ~d ~e ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 2, `str` is a: bar, b: 2, d: [3], e: [|4|]") ) ;
      act (fun () ->
          React.Dom.render (UseCallback.make ~a:a2 ~b ~d ~e ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 2, `str` is a: bar, b: 2, d: [3], e: [|4|]") ) ;
      act (fun () ->
          React.Dom.render
            (UseCallback.make ~a:a2 ~b:3 ~d ~e ())
            (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 3, `str` is a: bar, b: 3, d: [3], e: [|4|]") ) ;
      act (fun () ->
          React.Dom.render
            (UseCallback.make ~a:a2 ~b:3 ~d:[4] ~e ())
            (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return
           (Js.string "`count` is 4, `str` is a: bar, b: 3, d: [4], e: [|4|]") ) )

let testUseState () =
  let module DummyStateComponent = struct
    let%component make ?(initialValue = 0) () =
      let counter, setCounter = React.useState (fun () -> initialValue) in
      fragment
        [ div [|className "value"|] [React.int counter]
        ; button
            [|onClick (fun _ -> setCounter (fun counter -> counter + 1))|]
            [string "Increment"]
        ; button
            [|onClick (fun _ -> setCounter (fun counter -> counter - 1))|]
            [string "Decrement"] ]
  end in
  withContainer (fun c ->
      let open ReactDOMTestUtils in
      act (fun () ->
          React.Dom.render (DummyStateComponent.make ()) (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">0</div><button>Increment</button><button>Decrement</button>" ) ;
      let button =
        DOM.findBySelectorAndPartialTextContent (unsafe_to_element c) "button"
          "Increment"
      in
      act (fun () -> Simulate.click button) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">1</div><button>Increment</button><button>Decrement</button>" ) ;
      let button =
        DOM.findBySelectorAndPartialTextContent (unsafe_to_element c) "button"
          "Decrement"
      in
      act (fun () -> Simulate.click button) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">0</div><button>Increment</button><button>Decrement</button>" ) )

let testUseStateUpdaterReference () =
  let module UseState = struct
    let prevSetCount = ref None

    let%component make () =
      let _count, setCount = React.useState (fun () -> 0) in
      let equal =
        match (setCount, !prevSetCount) with
        | r1, Some r2 when r1 == r2 ->
            "true"
        | _ ->
            "false"
      in
      prevSetCount := Some setCount ;
      div [||] [equal |> string]
  end in
  withContainer (fun c ->
      act (fun () -> React.Dom.render (UseState.make ()) (Html.element c)) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "false")) ;
      act (fun () -> React.Dom.render (UseState.make ()) (Html.element c)) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "true")) )

let testUseReducer () =
  let module DummyReducerComponent = struct
    type action = Increment | Decrement

    let%component make ?(initialValue = 0) () =
      let state, send =
        React.useReducer
          (fun state action ->
            match action with Increment -> state + 1 | Decrement -> state - 1 )
          initialValue
      in
      fragment
        [ div [|className "value"|] [int state]
        ; button [|onClick (fun _ -> send Increment)|] [string "Increment"]
        ; button [|onClick (fun _ -> send Decrement)|] [string "Decrement"] ]
  end in
  withContainer (fun c ->
      let open ReactDOMTestUtils in
      act (fun () ->
          React.Dom.render (DummyReducerComponent.make ()) (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">0</div><button>Increment</button><button>Decrement</button>" ) ;
      let button =
        DOM.findBySelectorAndPartialTextContent (unsafe_to_element c) "button"
          "Increment"
      in
      act (fun () -> Simulate.click button) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">1</div><button>Increment</button><button>Decrement</button>" ) ;
      let button =
        DOM.findBySelectorAndPartialTextContent (unsafe_to_element c) "button"
          "Decrement"
      in
      act (fun () -> Simulate.click button) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">0</div><button>Increment</button><button>Decrement</button>" ) )

let testUseReducerWithMapState () =
  let module DummyReducerWithMapStateComponent = struct
    type action = Increment | Decrement

    let%component make ?(initialValue = 0) () =
      let state, send =
        React.useReducerWithMapState
          (fun state action ->
            match action with Increment -> state + 1 | Decrement -> state - 1 )
          initialValue
          (fun initialValue -> initialValue + 1)
      in
      fragment
        [ div [|className "value"|] [int state]
        ; button [|onClick (fun _ -> send Increment)|] [string "Increment"]
        ; button [|onClick (fun _ -> send Decrement)|] [string "Decrement"] ]
  end in
  withContainer (fun c ->
      let open ReactDOMTestUtils in
      act (fun () ->
          React.Dom.render
            (DummyReducerWithMapStateComponent.make ())
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">1</div><button>Increment</button><button>Decrement</button>" ) ;
      let button =
        DOM.findBySelectorAndPartialTextContent (unsafe_to_element c) "button"
          "Increment"
      in
      act (fun () -> Simulate.click button) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">2</div><button>Increment</button><button>Decrement</button>" ) ;
      let button =
        DOM.findBySelectorAndPartialTextContent (unsafe_to_element c) "button"
          "Decrement"
      in
      act (fun () -> Simulate.click button) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div \
            class=\"value\">1</div><button>Increment</button><button>Decrement</button>" ) )

let testUseReducerDispatchReference () =
  let module UseReducer = struct
    let prevDispatch = ref None

    let%component make () =
      let _, dispatch = React.useReducer (fun _ _ -> 2) 2 in
      let equal =
        match (dispatch, !prevDispatch) with
        | r1, Some r2 when r1 == r2 ->
            "true"
        | _ ->
            "false"
      in
      prevDispatch := Some dispatch ;
      div [||] [equal |> string]
  end in
  withContainer (fun c ->
      act (fun () -> React.Dom.render (UseReducer.make ()) (Html.element c)) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "false")) ;
      act (fun () -> React.Dom.render (UseReducer.make ()) (Html.element c)) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "true")) )

let testUseMemo1 () =
  let module UseMemo = struct
    let%component make ~a =
      let count, setCount = React.useState (fun () -> 0) in
      let result = React.useMemo1 (fun () -> a ^ "2") [|a|] in
      React.useEffect1
        (fun () ->
          setCount (fun count -> count + 1) ;
          None )
        [|result|] ;
      div [||] [Printf.sprintf "`count` is %d" count |> string]
  end in
  withContainer (fun c ->
      let fooString = "foo" in
      act (fun () ->
          React.Dom.render (UseMemo.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 1")) ;
      act (fun () ->
          React.Dom.render (UseMemo.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 1")) ;
      act (fun () ->
          React.Dom.render (UseMemo.make ~a:"foo" ()) (Html.element c) ) ;
      assert_equal c##.textContent (Js.Opt.return (Js.string "`count` is 2")) )

let testMemo () =
  let numRenders = ref 0 in
  let module Memoized = struct
    let%component make =
      React.memo (fun ~a ->
          numRenders := !numRenders + 1 ;
          div [||]
            [ Printf.sprintf "`a` is %s, `numRenders` is %d" a !numRenders
              |> string ] )
  end in
  withContainer (fun c ->
      let fooString = "foo" in
      act (fun () ->
          React.Dom.render (Memoized.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`a` is foo, `numRenders` is 1")) ;
      act (fun () ->
          React.Dom.render (Memoized.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`a` is foo, `numRenders` is 1")) ;
      act (fun () ->
          React.Dom.render (Memoized.make ~a:"bar" ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`a` is bar, `numRenders` is 2")) )

let testMemoCustomCompareProps () =
  let numRenders = ref 0 in
  let module Memoized = struct
    let%component make =
      React.memoCustomCompareProps
        (fun ~a ->
          numRenders := !numRenders + 1 ;
          div [||]
            [ Printf.sprintf "`a` is %s, `numRenders` is %d" a !numRenders
              |> string ] )
        (fun _prevPros _nextProps -> true)
  end in
  withContainer (fun c ->
      let fooString = "foo" in
      act (fun () ->
          React.Dom.render (Memoized.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`a` is foo, `numRenders` is 1")) ;
      act (fun () ->
          React.Dom.render (Memoized.make ~a:fooString ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`a` is foo, `numRenders` is 1")) ;
      act (fun () ->
          React.Dom.render (Memoized.make ~a:"bar" ()) (Html.element c) ) ;
      assert_equal c##.textContent
        (Js.Opt.return (Js.string "`a` is foo, `numRenders` is 1")) )

let testCreateRef () =
  let reactRef = React.createRef () in
  assert_equal (React.Ref.current reactRef) Js_of_ocaml.Js.null ;
  React.Ref.setCurrent reactRef (Js_of_ocaml.Js.Opt.return 1) ;
  assert_equal (React.Ref.current reactRef) (Js_of_ocaml.Js.Opt.return 1)

let testForwardRef () =
  let module FancyButton = struct
    let make ~ref children =
      div [||]
        [ button [|ref_ ref; className "FancyButton"|] children
        ; button [|ref_ ref; className "FancyButton"|] children ]
  end in
  withContainer (fun c ->
      let count = ref 0 in
      let buttonRef =
        React.Dom.Ref.callbackDomRef (fun _ref -> count := !count + 1)
      in
      act (fun () ->
          React.Dom.render
            (FancyButton.make ~ref:buttonRef [div [||] []])
            (Html.element c) ) ;
      assert_equal !count 2 )

let testUseRef () =
  let module DummyComponentWithRefAndEffect = struct
    let%component make ~cb () =
      let myRef = React.useRef 1 in
      React.useEffect0 (fun () ->
          let open React.Ref in
          setCurrent myRef (current myRef + 1) ;
          cb myRef ;
          None ) ;
      div [||] []
  end in
  withContainer (fun c ->
      let myRef = ref None in
      let cb reactRef = myRef := Some reactRef in
      act (fun () ->
          React.Dom.render
            (DummyComponentWithRefAndEffect.make ~cb ())
            (Html.element c) ) ;
      assert_equal
        (myRef.contents |> Option.map (fun item -> item |> React.Ref.current))
        (Some 2) )

let testChildrenMapWithIndex () =
  let module DummyComponentThatMapsChildren = struct
    let%component make ~children () =
      div [||]
        [ React.Children.mapWithIndex children (fun element index ->
              React.cloneElement element
                (let open Js_of_ocaml.Js.Unsafe in
                obj [|("key", inject index); ("data-index", inject index)|]) )
        ]
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (DummyComponentThatMapsChildren.make
               ~children:[div [||] [int 1]; div [||] [int 2]; div [||] [int 3]]
               () )
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string
           "<div><div data-index=\"0\">1</div><div \
            data-index=\"1\">2</div><div data-index=\"2\">3</div></div>" ) )

let testFragment () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (fragment [div [||] [string "Hello"]; div [||] [string "World"]])
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div>Hello</div><div>World</div>") )

let testNonListChildren () =
  let module NonListChildrenComponent = struct
    let%component make ~children:(first, second) () = div [||] [first; second]
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (NonListChildrenComponent.make
               ~children:(div [||] [int 1], div [||] [int 3])
               () )
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string "<div><div>1</div><div>3</div></div>") )

let testDangerouslySetInnerHTML () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (div
               [| dangerouslySetInnerHTML
                    (React.Dom.makeHtml ~__html:"<lol></lol>") |]
               [] )
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div><lol></lol></div>") )

let testExternals () =
  let module JsComp = struct
    external%component make : name:Js.js_string Js.t -> React.element
      = "require(\"./external\").Greeting"
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (JsComp.make ~name:(Js.string "John") ())
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<span>Hey John</span>") )

let testExternalChildren () =
  let module JsComp = struct
    external%component make :
      children:React.element Js.js_array Js.t -> React.element
      = "require(\"./external\").GreetingChildren"
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (JsComp.make
               ~children:(Js.array [|em [||] [React.string "John"]|])
               () )
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<span>Hey <em>John</em></span>") )

let testExternalNonFunction () =
  let module JsComp = struct
    external%component make : name:Js.js_string Js.t -> React.element
      = "require(\"./external\").NonFunctionGreeting"
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (JsComp.make ~name:(Js.string "John") ())
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<span>Hey John</span>") )

let testAliasedChildren () =
  let module AliasedChildrenComponent = struct
    let%component make ~children:kids () = div [||] kids
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (AliasedChildrenComponent.make
               ~children:[div [||] [int 1]; div [||] [int 3]]
               () )
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string "<div><div>1</div><div>3</div></div>") )

let testWithId () =
  let module WithTestId = struct
    let%component make ~id ~children () =
      React.Children.map children (fun child ->
          React.cloneElement child
            (Js.Unsafe.obj
               [|("data-testid", Js.Unsafe.inject (Js.string id))|] ) )
  end in
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (WithTestId.make ~id:"feed-toggle" ~children:[div [||] []] ())
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string "<div data-testid=\"feed-toggle\"></div>") )

let testPropMaybeNone () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render (div [|maybe className None|] []) (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div></div>") )

let testPropMaybeSome () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (div [|maybe className (Some "foo")|] [])
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div class=\"foo\"></div>") )

let testPropCustomString () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render (div [|Prop.string "foo" "bar"|] []) (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div foo=\"bar\"></div>") )

let testPropCustomBool () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (div [|Prop.bool "disabled" true|] [])
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div disabled=\"\"></div>") )

let testPropCustomInt () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render (div [|Prop.int "foo" 42|] []) (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div foo=\"42\"></div>") )

let testPropCustomFloat () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render (div [|Prop.float "foo" 42.5|] []) (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div foo=\"42.5\"></div>") )

let testPropCustomAny () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (div [|Prop.any "foo" (Js.array [|"bar"; "baz"|])|] [])
            (Html.element c) ) ;
      assert_equal c##.innerHTML (Js.string "<div foo=\"bar,baz\"></div>") )

let testCustomElement () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            (h "cool-element"
               [|Prop.string "coolness" "max"|]
               [h "chill" [|Prop.bool "data-out" true|] []] )
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string
           "<cool-element coolness=\"max\"><chill \
            data-out=\"true\"></chill></cool-element>" ) )

let testSvg () =
  withContainer (fun c ->
      act (fun () ->
          React.Dom.render
            Svg.(
              svg
                [|width "100"; height "100"|]
                [ circle
                    [| cx "50"
                     ; cy "50"
                     ; strokeWidth "2"
                     ; stroke "magenta"
                     ; fill "pink" |]
                    [] ])
            (Html.element c) ) ;
      assert_equal c##.innerHTML
        (Js.string
           "<svg width=\"100\" height=\"100\"><circle cx=\"50\" cy=\"50\" \
            stroke-width=\"2\" stroke=\"magenta\" \
            fill=\"pink\"></circle></svg>" ) )

let basic =
  "basic"
  >::: [ "testDom" >:: testDom
       ; "testReact" >:: testReact
       ; "testKey" >:: testKeys
       ; "testOptionalPropsUppercase" >:: testOptionalPropsUppercase
       ; "testOptionalPropsLowercase" >:: testOptionalPropsLowercase ]

let context = "context" >::: ["testContext" >:: testContext]

let useEffect =
  "useEffect"
  >::: [ "useEffect" >:: testUseEffect
       ; "useEffect2" >:: testUseEffect2
       ; "useEffect3" >:: testUseEffect3 ]

let useCallback =
  "useCallback"
  >::: ["useCallback1" >:: testUseCallback1; "useCallback4" >:: testUseCallback4]

let useState =
  "useState"
  >::: [ "useState" >:: testUseState
       ; "useStateUpdaterReference" >:: testUseStateUpdaterReference ]

let useReducer =
  "useReducer"
  >::: [ "useReducer" >:: testUseReducer
       ; "useReducerWithMapState" >:: testUseReducerWithMapState
       ; "useReducerDispatchReference" >:: testUseReducerDispatchReference ]

let memoization =
  "memo"
  >::: [ "useMemo1" >:: testUseMemo1
       ; "memo" >:: testMemo
       ; "memoCustomCompareProps" >:: testMemoCustomCompareProps ]

let refs =
  "refs"
  >::: [ "createRef" >:: testCreateRef
       ; "forwardRef" >:: testForwardRef
       ; "useRef" >:: testUseRef ]

let children =
  "children"
  >::: [ "mapWithIndex" >:: testChildrenMapWithIndex
       ; "nonListChildren" >:: testNonListChildren
       ; "aliasedChildren" >:: testAliasedChildren
       ; "testWithId" >:: testWithId ]

let fragments = "fragments" >::: ["basic" >:: testFragment]

let dangerouslySetInnerHTML =
  "dangerouslySetInnerHTML" >::: ["basic" >:: testDangerouslySetInnerHTML]

let externals =
  "externals"
  >::: [ "basic" >:: testExternals
       ; "children" >:: testExternalChildren
       ; "non-function" >:: testExternalNonFunction ]

let props =
  "props"
  >::: [ "maybe-none" >:: testPropMaybeNone
       ; "maybe-some" >:: testPropMaybeSome
       ; "custom-string" >:: testPropCustomString
       ; "custom-bool" >:: testPropCustomBool
       ; "custom-int" >:: testPropCustomInt
       ; "custom-float" >:: testPropCustomFloat
       ; "custom-any" >:: testPropCustomAny ]

let elements = "elements" >::: ["custom" >:: testCustomElement]

let svg = "svg" >::: ["basic" >:: testSvg]

let suite =
  "ocaml"
  >::: [ basic
       ; context
       ; useEffect
       ; useCallback
       ; useState
       ; useReducer
       ; memoization
       ; refs
       ; children
       ; fragments
       ; dangerouslySetInnerHTML
       ; externals
       ; props
       ; elements
       ; svg ]
