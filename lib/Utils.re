module Js = Js_of_ocaml.Js;

let optInj = (~f=?, prop, opt) =>
  switch (f, opt) {
  | (Some(f), Some(s)) => [|(prop, Js.Unsafe.inject(f(s)))|]
  | (None, Some(s)) => [|(prop, Js.Unsafe.inject(s))|]
  | _ => [||]
  };
