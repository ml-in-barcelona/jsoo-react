/*
  This file exists to see clearly what's the input for the tests,
  but in reality the file that is fed to the testing binary is test.ml.
  This is due to ocaml-migrate-parsetree drivers only allowing OCaml syntax.
  See related: https://github.com/ocaml-ppx/ocaml-migrate-parsetree/issues/74.

  To regenerate test.ml from this file, run `esy test:regen`.
 */

[@react.component]
let make = (~name="") => {
  <>
    <div> {React.string("Hello " ++ name)} </div>
    <Hello one="1"> {React.string("Hello " ++ name)} </Hello>
  </>;
};

[@react.component]
let make = (~a, ~b, _) => {
  Js.log("This function should be named `Test`");
  <div />;
};

/* Not supported yet, how does RR do it without matching against `Pexp_field`??? */
/*
 module Foo = {
   [@react.component] [@bs.module "Foo"]
   external component: (~a: int, ~b: string, _) => React.element = "";
 };
 <Foo.component a=1 b="1" />;
 */

module Bar = {
  [@react.component]
  let make = (~a, ~b, _) => {
    Js.log("This function should be named `Test$Bar`");
    <div />;
  };
  [@react.component]
  let component = (~a, ~b, _) => {
    Js.log("This function should be named `Test$Bar$component`");
    <div />;
  };
};

module type X_int = {let x: int;};

module Func = (M: X_int) => {
  let x = M.x + 1;
  [@react.component]
  let make = (~a, ~b, _) => {
    Js.log("This function should be named `Test$Func`", M.x);
    <div />;
  };
};

module ForwardRef = {
  [@react.component]
  let make =
    React.forwardRef(theRef =>
      <div ref=theRef> "ForwardRef"->React.string </div>
    );
};

let fragment = foo => <> foo </>;
