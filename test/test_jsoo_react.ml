open Webtest.Suite
module Js = Js_of_ocaml.Js
module Html = Js_of_ocaml.Dom_html
module Dom = Js_of_ocaml.Dom

let jsdom = Jsdom.make ~html:"<!doctype html><html><body></body></html>"

let doc = jsdom |> Jsdom.window |> Jsdom.document

let () = Js.Unsafe.global##.document := doc

let () = Js.Unsafe.global##.window := jsdom |> Jsdom.window

let with_container f =
  let container = Html.createDiv doc in
  Dom.appendChild doc##.body container ;
  let result = f container in
  ignore (ReactDOM.unmountComponentAtNode(container));
  Dom.removeChild doc##.body container ;
  result

let test_dom () =
  doc##.title := Js.string "Testing" ;
  let p = Html.createP doc in
  p##.innerHTML := Js.string "Loading graph..." ;
  Dom.appendChild doc##.body p ;
  assert_equal doc##.title (Js.string "Testing") ;
  assert_equal p##.innerHTML (Js.string "Loading graph...")

let test_react () =
  with_container (function container ->
      ReactDOMTestUtils.act (function () ->
          ReactDOM.render
            (div ~children:["Hello world!" |> React.string] () [@JSX])
            (Html.element container) ;
          assert_equal container##.textContent
            (Js.Opt.return (Js.string "Hello world!"))))

let basic = "basic" >::: ["test_dom" >:: test_dom; "test_react" >:: test_react]

let suite = "base_suite" >::: [basic]

let () = Webtest_js.Runner.run suite
