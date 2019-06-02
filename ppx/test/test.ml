let make ?(name= "")  =
  (([((div ~children:[React.string ("Hello " ^ name)] ())
    [@JSX ]);
    ((Hello.createElement ~one:"1" ~children:[React.string ("Hello " ^ name)]
        ())
    [@JSX ])])
  [@JSX ])[@@react.component ]
module ForwardRef =
  struct
    let make =
      React.forwardRef
        (fun theRef ->
           ((div ~ref:theRef ~children:["ForwardRef" |. React.string] ())
           [@JSX ]))[@@react.component ]
  end
