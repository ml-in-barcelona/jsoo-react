let make ?(name= "")  =
  (([((div ~children:[React.string ("Hello " ^ name)] ())
    [@JSX ]);
    ((Hello.createElement ~one:"1" ~children:[React.string ("Hello " ^ name)]
        ())
    [@JSX ])])
  [@JSX ])[@@react.component ]
let make ~a  ~b  _ =
  Js.log "This function should be named `Test`";
  ((div ~children:[] ())
  [@JSX ])[@@react.component ]
module Bar =
  struct
    let make ~a  ~b  _ =
      Js.log "This function should be named `Test$Bar`";
      ((div ~children:[] ())
      [@JSX ])[@@react.component ]
    let component ~a  ~b  _ =
      Js.log "This function should be named `Test$Bar$component`";
      ((div ~children:[] ())
      [@JSX ])[@@react.component ]
  end
module type X_int  = sig val x : int end
module Func(M:X_int) =
  struct
    let x = M.x + 1
    let make ~a  ~b  _ =
      Js.log "This function should be named `Test$Func`" M.x;
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
let fragment foo = (([foo])[@JSX ])
let polyChildrenFragment foo bar = (([foo; bar])[@JSX ])
let nestedFragment foo bar baz = (([foo; (([bar; baz])[@JSX ])])[@JSX ])
