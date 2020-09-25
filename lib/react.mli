type element = private Ojs.t

val element_of_js : Ojs.t -> element

val element_to_js : element -> Ojs.t

val null : element [@@js.custom let null = Ojs.null]

val string : string -> element [@@js.cast]

val int : int -> element [@@js.cast]

val float : float -> element [@@js.cast]

val list : element list -> element [@@js.cast]

[@@@js.stop]

type ('props, 'return) componentLike = 'props -> 'return

[@@@js.start]

[@@@js.implem type ('props, 'return) componentLike = 'props -> 'return]

[@@@js.stop]

type 'props component = ('props, element) componentLike

[@@@js.start]

[@@@js.implem
type 'props component = ('props, element) componentLike

external unsafeCastComp : 'a component -> 'b = "%identity"

external unsafeCastProps : 'a -> 'b = "%identity"]

val createElement : 'props component -> 'props -> element
  [@@js.custom
    (* Important: we don't want to use an arrow type to represent components (i.e. (Ojs.t -> element)) as the component function
       would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
    val createElementInternal : Ojs.t -> Ojs.t -> element
      [@@js.global "__LIB__react.createElement"]

    let createElement x y =
      createElementInternal (unsafeCastComp x) (unsafeCastProps y)]

val createElementVariadic :
  'props component -> 'props -> element list -> element
  [@@js.custom
    (* Important: we don't want to use an arrow type to represent components (i.e. (Ojs.t -> element)) as the component function
       would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
    val createElementVariadicInternal :
      Ojs.t -> Ojs.t -> (element list[@js.variadic]) -> element
      [@@js.global "__LIB__react.createElement"]

    let createElementVariadic x y =
      createElementVariadicInternal (unsafeCastComp x) (unsafeCastProps y)]

[@@@js.stop]

type 'a option_undefined = 'a option

[@@@js.start]

[@@@js.implem
type 'a option_undefined = 'a option

external equals : Ojs.t -> Ojs.t -> bool = "caml_js_equals"

external pure_js_expr : string -> Ojs.t = "caml_pure_js_expr"

let undefined = pure_js_expr "undefined"

let option_undefined_of_js f x = if equals x undefined then None else Some (f x)

let option_undefined_to_js f = function Some x -> f x | None -> undefined]

val useEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.global "__LIB__react.useEffect"]

val useEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useEffectInternal :
      (unit -> (unit -> unit) option_undefined) -> Ojs.t array -> unit
      [@@js.global "__LIB__react.useEffect"]

    let useEffect0 effect = useEffectInternal effect [||]]

val useEffect1 : (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.custom
    external unsafe_cast : 'a array -> Ojs.t array = "%identity"

    let useEffect1 effect dep = useEffectInternal effect (unsafe_cast dep)]

val useEffect2 : (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b -> Ojs.t array = "%identity"

    let useEffect2 effect dep = useEffectInternal effect (unsafe_cast dep)]

val useEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c -> Ojs.t array = "%identity"

    let useEffect3 effect dep = useEffectInternal effect (unsafe_cast dep)]

val useEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd -> Ojs.t array = "%identity"

    let useEffect4 effect dep = useEffectInternal effect (unsafe_cast dep)]

val useEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd * 'e -> Ojs.t array = "%identity"

    let useEffect5 effect dep = useEffectInternal effect (unsafe_cast dep)]

val useEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd * 'e * 'f -> Ojs.t array
      = "%identity"

    let useEffect6 effect dep = useEffectInternal effect (unsafe_cast dep)]

val useEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd * 'e * 'f * 'g -> Ojs.t array
      = "%identity"

    let useEffect7 effect dep = useEffectInternal effect (unsafe_cast dep)]

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
  [@@js.custom
    external unsafe_cast : 'a array -> Ojs.t array = "%identity"

    let useLayoutEffect1 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useLayoutEffect2 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b -> Ojs.t array = "%identity"

    let useLayoutEffect2 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useLayoutEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c -> Ojs.t array = "%identity"

    let useLayoutEffect3 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useLayoutEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd -> Ojs.t array = "%identity"

    let useLayoutEffect4 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useLayoutEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd * 'e -> Ojs.t array = "%identity"

    let useLayoutEffect5 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useLayoutEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd * 'e * 'f -> Ojs.t array
      = "%identity"

    let useLayoutEffect6 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useLayoutEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafe_cast : 'a * 'b * 'c * 'd * 'e * 'f * 'g -> Ojs.t array
      = "%identity"

    let useLayoutEffect7 effect dep =
      useLayoutEffectInternal effect (unsafe_cast dep)]

val useState : (unit -> 'state) -> 'state * (('state -> 'state) -> unit)
  [@@js.custom
    val useStateInternal : (unit -> Ojs.t) -> Ojs.t * ((Ojs.t -> Ojs.t) -> unit)
      [@@js.global "__LIB__react.useState"]

    let useState = Obj.magic useStateInternal

    (* TODO: Is there a way to avoid magic? *)]

val useReducer :
  ('state -> 'action -> 'state) -> 'state -> 'state * ('action -> unit)
  [@@js.custom
    val useReducerInternal :
      (Ojs.t -> Ojs.t -> Ojs.t) -> Ojs.t -> Ojs.t * (Ojs.t -> unit)
      [@@js.global "__LIB__react.useReducer"]

    let useReducer = Obj.magic useReducerInternal

    (* TODO: Is there a way to avoid magic? *)]

module Ref : sig
  [@@@js.stop]

  type 'value t

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

  val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

  [@@@js.start]

  [@@@js.implem
  include (
    [%js] :
      sig
        type untyped = private Ojs.t

        val untyped_of_js : Ojs.t -> untyped

        val untyped_to_js : untyped -> Ojs.t
      end )

  type 'value t = untyped

  let t_of_js _ x = untyped_of_js x

  let t_to_js _ x = untyped_to_js x]

  val current : 'value t -> 'value
    [@@js.custom
      val currentInternal : Ojs.t -> Ojs.t [@@js.get "current"]

      let current = Obj.magic currentInternal

      (* TODO: Is there a way to avoid magic? *)]

  val setCurrent : 'value t -> 'value -> unit
    [@@js.custom
      type r = Ojs.t

      let r_of_js = Ojs.t_of_js

      let r_to_js = Ojs.t_to_js

      val setCurrentInternal : r -> Ojs.t -> unit [@@js.set "current"]

      let setCurrent = Obj.magic setCurrentInternal

      (* TODO: Is there a way to avoid magic? *)]
end

val useRef : 'value -> 'value Ref.t
  [@@js.custom
    val useRefInternal : Ojs.t -> Ojs.t Ref.t
      [@@js.global "__LIB__react.useRef"]

    let useRef = Obj.magic useRefInternal

    (* TODO: Is there a way to avoid magic? *)]

(* TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
 Although Reason parser doesn't support it so that's a requirement before adding it here *)
val createFragment : element list -> element
  [@@js.custom
    val createFragmentInternal : Ojs.t -> Ojs.t -> element list -> element
      [@@js.global "__LIB__react.createElement"]

    val fragmentInternal : Ojs.t [@@js.global "__LIB__react.Fragment"]

    let createFragment l = createFragmentInternal fragmentInternal Ojs.null l]

(* val createElement : 'props component -> 'props -> element[@@js.global
                                                           "__LIB__react"
                                                             ] *)
(* val cloneElement : 'props component -> 'props -> element[@@js.global
                                                          (("__LIB__react")
                                                            )] *)

(*

 external createRef: unit => Ref.t(option('a)) = "createRef";

 module Children = {
   external map: (element, element => element) => element = "Children_map";
   external forEach: (element, element => unit) => unit = "Children_forEach";
   external count: element => int = "Children_count";
   external only: element => element = "Children_only";
   external toArray: element => array(element) = "Children_toArray";
 };

 module Context = {
   type t('props);

   [@bs.get]
   external provider:
     t('props) =>
     component({
       .
       "value": 'props,
       "children": element,
     }) =
     "Provider";
 };

 [@bs.module "react"] external createContext: 'a => Context.t('a) = "";

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
 external useMemo: ([@bs.uncurry] (unit => 'any)) => 'any = "useMemo";
 [@bs.module "react"]
 external useMemo0:
   ([@bs.uncurry] (unit => 'any), [@bs.as {json|[]|json}] _) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo1: ([@bs.uncurry] (unit => 'any), array('a)) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo2: ([@bs.uncurry] (unit => 'any), ('a, 'b)) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo3: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c)) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo4: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd)) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo5:
   ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo6:
   ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any =
   "useMemo";
 [@bs.module "react"]
 external useMemo7:
   ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any =
   "useMemo";

 /* This is used as return values  */
 type callback('input, 'output) = 'input => 'output;

 [@bs.module "react"]
 external useCallback:
   ([@bs.uncurry] ('input => 'output)) => callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback0:
   ([@bs.uncurry] ('input => 'output), [@bs.as {json|[]|json}] _) =>
   callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback1:
   ([@bs.uncurry] ('input => 'output), array('a)) => callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback2:
   ([@bs.uncurry] ('input => 'output), ('a, 'b)) => callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback3:
   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c)) =>
   callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback4:
   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd)) =>
   callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback5:
   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e)) =>
   callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback6:
   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f)) =>
   callback('input, 'output) =
   "useCallback";
 [@bs.module "react"]
 external useCallback7:
   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) =>
   callback('input, 'output) =
   "useCallback";

 [@bs.module "react"] external useContext: Context.t('any) => 'any = "";

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
