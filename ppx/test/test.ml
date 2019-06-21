module type Foo  =
  sig
    val make :
      ?title:string ->
        ?defaultTitle:string ->
          ?meta:metaField array ->
            ?htmlAttributes:htmlAttribute array ->
              children:React.element -> React.element[@@react.component ]
  end
let make ?(name= "")  =
  (([((div ~children:[React.string ("Hello " ^ name)] ())
    [@JSX ]);
    ((Hello.createElement ~one:"1" ~children:[React.string ("Hello " ^ name)]
        ())
    [@JSX ])])
  [@JSX ])[@@react.component ]
let make ~a  ~b  _ =
  print_endline "This function should be named `Test`";
  ((div ~children:[] ())
  [@JSX ])[@@react.component ]
module External =
  struct
    external component : a:int -> b:string -> _ -> React.element = ""
    [@@react.component ][@@otherAttribute "bla"]
  end
module Bar =
  struct
    let make ~a  ~b  _ =
      print_endline "This function should be named `Test$Bar`";
      ((div ~children:[] ())
      [@JSX ])[@@react.component ]
    let component ~a  ~b  _ =
      print_endline "This function should be named `Test$Bar$component`";
      ((div ~children:[] ())
      [@JSX ])[@@react.component ]
  end
module type X_int  = sig val x : int end
module Func(M:X_int) =
  struct
    let x = M.x + 1
    let make ~a  ~b  _ =
      print_endline "This function should be named `Test$Func`" M.x;
      ((div ~children:[] ())
      [@JSX ])[@@react.component ]
  end
module ForwardRef =
  struct
    let make =
      React.forwardRef
        (fun theRef ->
           ((div ~ref:theRef ~children:["ForwardRef" |. React.string] ())
           [@JSX ]))[@@react.component ]
  end
let fragment foo = (([foo])[@bla ][@JSX ])
let polyChildrenFragment foo bar = (([foo; bar])[@JSX ])
let nestedFragment foo bar baz = (([foo; (([bar; baz])[@JSX ])])[@JSX ])
let upper = ((Upper.createElement ~children:[] ())[@JSX ])
let upperWithChild foo = ((Upper.createElement ~children:[foo] ())[@JSX ])
let upperWithChildren foo bar =
  ((Upper.createElement ~children:[foo; bar] ())[@JSX ])
let lower = ((lower ~children:[] ())[@JSX ])
let lowerWithChildAndProps foo = ((lower ~a:1 ~b:"1" ~children:[foo] ())
  [@JSX ])
let lowerWithChildren foo bar = ((lower ~children:[foo; bar] ())[@JSX ])
let nestedElement = ((Foo.Bar.createElement ~a:1 ~b:"1" ~children:[] ())
  [@JSX ])
let nestedElementCustomName =
  ((Foo.component.createElement ~a:1 ~b:"1" ~children:[] ())[@JSX ])
