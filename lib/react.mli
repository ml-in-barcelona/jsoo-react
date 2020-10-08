type element = private Ojs.t

val element_of_js : Ojs.t -> element

val element_to_js : element -> Ojs.t

val null : element [@@js.custom let null = Ojs.null]

val string : string -> element [@@js.cast]

val int : int -> element [@@js.cast]

val float : float -> element [@@js.cast]

val list : element list -> element [@@js.cast]

[@@@js.stop]

type 'a option_undefined = 'a option

type 'a js_nullable = 'a Js_of_ocaml.Js.Opt.t

val js_nullable_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value js_nullable

val js_nullable_to_js : ('value -> Ojs.t) -> 'value js_nullable -> Ojs.t

type ('props, 'return) componentLike = 'props -> 'return

type 'props component = ('props, element) componentLike

type ('input, 'output) callback = 'input -> 'output

[@@@js.start]

[@@@js.implem
type 'a option_undefined = 'a option

type 'a js_nullable = 'a Js_of_ocaml.Js.Opt.t

external equals : Ojs.t -> Ojs.t -> bool = "caml_js_equals"

let undefined = Ojs.variable "undefined"

let option_undefined_of_js f x = if equals x undefined then None else Some (f x)

let option_undefined_to_js f = function Some x -> f x | None -> undefined

external js_nullable_of_ojs : Ojs.t -> 'value js_nullable = "%identity"

external js_nullable_to_js : 'value js_nullable -> Ojs.t = "%identity"

let js_nullable_of_js _f x = js_nullable_of_ojs x

let js_nullable_to_js _f x = js_nullable_to_js x

type ('props, 'return) componentLike = 'props -> 'return

type 'props component = ('props, element) componentLike

let component_to_js cb = cb

let component_of_js js = js

type ('input, 'output) callback = 'input -> 'output

let callback_to_js _ cb = cb

let callback_of_js _ js = js]

val createElement : 'props component -> 'props -> element
  [@@js.global "__LIB__react.createElement"]

val createElementVariadic :
  'props component -> 'props -> (element list[@js.variadic]) -> element
  [@@js.global "__LIB__react.createElement"]

val cloneElement : 'props component -> 'props -> element
  [@@js.global "__LIB__react.cloneElement"]

val useEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useEffectInternal :
      (unit -> (unit -> unit) option_undefined) -> Ojs.t array -> unit
      [@@js.global "__LIB__react.useEffect"]

    let useEffect0 effect = useEffectInternal effect [||]]

val useEffect1 : (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect2 : (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.global "__LIB__react.useEffect"]

val useLayoutEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useLayoutEffectInternal :
      (unit -> (unit -> unit) option_undefined) -> Ojs.t array -> unit
      [@@js.global "__LIB__react.useLayoutEffect"]

    let useLayoutEffect0 effect = useLayoutEffectInternal effect [||]]

val useLayoutEffect1 :
  (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect2 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useLayoutEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.global "__LIB__react.useLayoutEffect"]

val useCallback : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom
    val useCallbackInternal :
         ('input, 'output) callback
      -> 'a array option_undefined
         (* Important: we don't want to use an arrow type to represent returning callback (i.e. (Ojs.t -> Ojs.t)) as the callback
            would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
      -> ('input, 'output) callback
      [@@js.global "__LIB__react.useCallback"]

    let useCallback cb = useCallbackInternal cb None]

val useCallback0 : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom let useCallback0 f = useCallbackInternal f (Some [||])]

val useCallback1 :
  ('input, 'output) callback -> 'a array -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useCallback2 :
  ('input, 'output) callback -> 'a * 'b -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useCallback3 :
  ('input, 'output) callback -> 'a * 'b * 'c -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useCallback4 :
  ('input, 'output) callback -> 'a * 'b * 'c * 'd -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useCallback5 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e
  -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useCallback6 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useCallback7 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> ('input, 'output) callback
  [@@js.global "__LIB__react.useCallback"]

val useMemo : (unit -> 'value) -> 'value
  [@@js.custom
    val useMemoInternal :
      (unit -> 'value) -> 'any array option_undefined -> 'value
      [@@js.global "__LIB__react.useMemo"]

    let useMemo f = useMemoInternal f None]

val useMemo0 : (unit -> 'value) -> 'value
  [@@js.custom let useMemo0 f = useMemoInternal f (Some [||])]

val useMemo1 : (unit -> 'value) -> 'a array -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useMemo2 : (unit -> 'value) -> 'a * 'b -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useMemo3 : (unit -> 'value) -> 'a * 'b * 'c -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useMemo4 : (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useMemo5 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useMemo6 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useMemo7 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'value
  [@@js.global "__LIB__react.useMemo"]

val useState : (unit -> 'state) -> 'state * (('state -> 'state) -> unit)
  [@@js.global "__LIB__react.useState"]

val useReducer :
  ('state -> 'action -> 'state) -> 'state -> 'state * ('action -> unit)
  [@@js.global "__LIB__react.useReducer"]

module Ref : sig
  type 'value t

  [@@@js.stop]

  val t_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value t

  val t_to_js : ('value -> Ojs.t) -> 'value t -> Ojs.t

  [@@@js.start]

  val current : 'value t -> 'value [@@js.get "current"]

  val setCurrent : 'value t -> 'value -> unit [@@js.set "current"]
end

val useRef : 'value -> 'value Ref.t [@@js.global "__LIB__react.useRef"]

val createRef : unit -> 'a js_nullable Ref.t
  [@@js.global "__LIB__react.createRef"]

(* TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
 Although Reason parser doesn't support it so that's a requirement before adding it here *)
val createFragment : element list -> element
  [@@js.custom
    val createFragmentInternal : Ojs.t -> Ojs.t -> element list -> element
      [@@js.global "__LIB__react.createElement"]

    val fragmentInternal : Ojs.t [@@js.global "__LIB__react.Fragment"]

    let createFragment l = createFragmentInternal fragmentInternal Ojs.null l]

module Context : sig
  type 'props t

  val makeProps :
       value:'props
    -> children:element
    -> unit
    -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
       Js_of_ocaml.Js.t
    [@@js.custom
      let makeProps ~value ~children () =
        Js_of_ocaml.Js.Unsafe.(
          obj [|("value", inject value); ("children", inject children)|])]

  val provider :
       'props t
    -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
       Js_of_ocaml.Js.t
       component
    [@@js.custom
      external of_ojs :
           Ojs.t
        -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
           Js_of_ocaml.Js.t
           component = "%identity"

      val providerInternal : 'props t -> Ojs.t [@@js.get "Provider"]

      let provider c = of_ojs (providerInternal c)]
end

val createContext : 'a -> 'a Context.t
  [@@js.global "__LIB__react.createContext"]

val useContext : 'value Context.t -> 'value
  [@@js.global "__LIB__react.useContext"]

(*
 module Children = {
   external map: (element, element => element) => element = "Children_map";
   external forEach: (element, element => unit) => unit = "Children_forEach";
   external count: element => int = "Children_count";
   external only: element => element = "Children_only";
   external toArray: element => array(element) = "Children_toArray";
 };

 [@bs.module "react"]
 external memo: component('props) => component('props) = "";

 [@bs.module "react"]
 external memoCustomCompareProps:
   (component('props), [@bs.uncurry] (('props, 'props) => bool)) =>
   component('props) =
   "memo";

 module Fragment = {
   [@bs.obj]
   external makeProps:
     (~children: element, ~key: 'key=?, unit) => {. "children": element} =
     "";
   [@bs.module "react"]
   external make: component({. "children": element}) = "Fragment";
 };

 module Suspense = {
   [@bs.obj]
   external makeProps:
     (
       ~children: element=?,
       ~fallback: element=?,
       ~maxDuration: int=?,
       ~key: 'key=?,
       unit
     ) =>
     {
       .
       "children": option(element),
       "fallback": option(element),
       "maxDuration": option(int),
     } =
     "";
   [@bs.module "react"]
   external make:
     component({
       .
       "children": option(element),
       "fallback": option(element),
       "maxDuration": option(int),
     }) =
     "Suspense";
 };
*)

(* HOOKS *)

(* [@js.global "__LIB__react"] 
let useState: (unit => 'state) => ('state, ('state => 'state) => unit);

[@js.global "__LIB__react"] 
let useReducer: (('state, 'action) => 'state, 'state) => ('state, 'action => unit);


 [@bs.module "react"]
 external useReducerWithMapState:
   (
     [@bs.uncurry] (('state, 'action) => 'state),
     'initialState,
     'initialState => 'state
   ) =>
   ('state, 'action => unit) =
   "useReducer";

 [@bs.module "react"]
 external useImperativeHandle0:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     [@bs.as {json|[]|json}] _
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle1:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     array('a)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle2:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     ('a, 'b)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle3:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     ('a, 'b, 'c)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle4:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     ('a, 'b, 'c, 'd)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle5:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     ('a, 'b, 'c, 'd, 'e)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle6:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     ('a, 'b, 'c, 'd, 'e, 'f)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.module "react"]
 external useImperativeHandle7:
   (
     Js.Nullable.t(Ref.t('value)),
     [@bs.uncurry] (unit => 'value),
     ('a, 'b, 'c, 'd, 'e, 'f, 'g)
   ) =>
   unit =
   "useImperativeHandle";

 [@bs.set]
 external setDisplayName: (component('props), string) => unit = "displayName";
*)
