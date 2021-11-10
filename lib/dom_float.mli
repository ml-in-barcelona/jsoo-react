(* Printing floats compatible with what javascript does *)

open Js_of_ocaml

val to_js_string : float -> Js.js_string Js.t
val to_string : float -> string
