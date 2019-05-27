/*
  This file exists to see clearly what's the input for the tests,
  but in reality the file that is fed to the testing binary is test.ml.
  This is due to ocaml-migrate-parsetree drivers only allowing OCaml syntax.
  See related: https://github.com/ocaml-ppx/ocaml-migrate-parsetree/issues/74.

  To regenerate test.ml from this file, run `esy test:regen`.
 */
[@react.component]
let make = (~name="") => {
  <div> {React.string("Hello " ++ name)} </div>;
};
