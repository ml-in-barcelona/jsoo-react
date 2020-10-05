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

let undefined = Ojs.variable "undefined"

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
    external unsafe_cast_arr : 'a array -> Ojs.t array = "%identity"

    let useEffect1 effect dep = useEffectInternal effect (unsafe_cast_arr dep)]

val useEffect2 : (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafeCastTup2 : 'a * 'b -> Ojs.t array = "%identity"

    let useEffect2 effect dep = useEffectInternal effect (unsafeCastTup2 dep)]

val useEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafeCastTup3 : 'a * 'b * 'c -> Ojs.t array = "%identity"

    let useEffect3 effect dep = useEffectInternal effect (unsafeCastTup3 dep)]

val useEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafeCastTup4 : 'a * 'b * 'c * 'd -> Ojs.t array = "%identity"

    let useEffect4 effect dep = useEffectInternal effect (unsafeCastTup4 dep)]

val useEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafeCastTup5 : 'a * 'b * 'c * 'd * 'e -> Ojs.t array
      = "%identity"

    let useEffect5 effect dep = useEffectInternal effect (unsafeCastTup5 dep)]

val useEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafeCastTup6 : 'a * 'b * 'c * 'd * 'e * 'f -> Ojs.t array
      = "%identity"

    let useEffect6 effect dep = useEffectInternal effect (unsafeCastTup6 dep)]

val useEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    (* relies on tuples and arrays having the same runtime representation *)
    external unsafeCastTup7 : 'a * 'b * 'c * 'd * 'e * 'f * 'g -> Ojs.t array
      = "%identity"

    let useEffect7 effect dep = useEffectInternal effect (unsafeCastTup7 dep)]

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
    let useLayoutEffect1 effect dep =
      useLayoutEffectInternal effect (unsafe_cast_arr dep)]

val useLayoutEffect2 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    let useLayoutEffect2 effect dep =
      useLayoutEffectInternal effect (unsafeCastTup2 dep)]

val useLayoutEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    let useLayoutEffect3 effect dep =
      useLayoutEffectInternal effect (unsafeCastTup3 dep)]

val useLayoutEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    let useLayoutEffect4 effect dep =
      useLayoutEffectInternal effect (unsafeCastTup4 dep)]

val useLayoutEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    let useLayoutEffect5 effect dep =
      useLayoutEffectInternal effect (unsafeCastTup5 dep)]

val useLayoutEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    let useLayoutEffect6 effect dep =
      useLayoutEffectInternal effect (unsafeCastTup6 dep)]

val useLayoutEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    let useLayoutEffect7 effect dep =
      useLayoutEffectInternal effect (unsafeCastTup7 dep)]

val useCallback : ('input -> 'output) -> 'input -> 'output
  [@@js.custom
    val useCallbackInternal :
         (Ojs.t -> Ojs.t)
      -> Ojs.t array option_undefined
         (* Important: we don't want to use an arrow type to represent returning callback (i.e. (Ojs.t -> Ojs.t)) as the callback
            would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
      -> Ojs.t
      [@@js.global "__LIB__react.useCallback"]

    external unsafe_cast_cb : ('input -> 'output) -> 'a = "%identity"

    external unsafeCastResCb : Ojs.t -> 'a = "%identity"

    let useCallback cb =
      unsafeCastResCb (useCallbackInternal (unsafe_cast_cb cb) None)]

val useCallback0 : ('input -> 'output) -> 'input -> 'output
  [@@js.custom
    let useCallback0 f =
      unsafeCastResCb (useCallbackInternal (unsafe_cast_cb f) (Some [||]))]

val useCallback1 : ('input -> 'output) -> 'a array -> 'input -> 'output
  [@@js.custom
    let useCallback1 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafe_cast_arr dep)))]

val useCallback2 : ('input -> 'output) -> 'a * 'b -> 'input -> 'output
  [@@js.custom
    let useCallback2 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafeCastTup2 dep)))]

val useCallback3 : ('input -> 'output) -> 'a * 'b * 'c -> 'input -> 'output
  [@@js.custom
    let useCallback3 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafeCastTup3 dep)))]

val useCallback4 : ('input -> 'output) -> 'a * 'b * 'c * 'd -> 'input -> 'output
  [@@js.custom
    let useCallback4 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafeCastTup4 dep)))]

val useCallback5 :
  ('input -> 'output) -> 'a * 'b * 'c * 'd * 'e -> 'input -> 'output
  [@@js.custom
    let useCallback5 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafeCastTup5 dep)))]

val useCallback6 :
  ('input -> 'output) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'input -> 'output
  [@@js.custom
    let useCallback6 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafeCastTup6 dep)))]

val useCallback7 :
  ('input -> 'output) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'input -> 'output
  [@@js.custom
    let useCallback7 f dep =
      unsafeCastResCb
        (useCallbackInternal (unsafe_cast_cb f) (Some (unsafeCastTup7 dep)))]

val useMemo : (unit -> 'value) -> 'value
  [@@js.custom
    val useMemoInternal :
      (unit -> Ojs.t) -> Ojs.t array option_undefined -> Ojs.t
      [@@js.global "__LIB__react.useMemo"]

    external unsafe_cast_f : (unit -> 'value) -> 'a = "%identity"

    external unsafe_cast_res : Ojs.t -> 'value = "%identity"

    let useMemo f = unsafe_cast_res (useMemoInternal (unsafe_cast_f f) None)]

val useMemo0 : (unit -> 'value) -> 'value
  [@@js.custom
    let useMemo0 f =
      unsafe_cast_res (useMemoInternal (unsafe_cast_f f) (Some [||]))]

val useMemo1 : (unit -> 'value) -> 'a array -> 'value
  [@@js.custom
    let useMemo1 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafe_cast_arr dep)))]

val useMemo2 : (unit -> 'value) -> 'a * 'b -> 'value
  [@@js.custom
    let useMemo2 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafeCastTup2 dep)))]

val useMemo3 : (unit -> 'value) -> 'a * 'b * 'c -> 'value
  [@@js.custom
    let useMemo3 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafeCastTup3 dep)))]

val useMemo4 : (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
  [@@js.custom
    let useMemo4 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafeCastTup4 dep)))]

val useMemo5 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
  [@@js.custom
    let useMemo5 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafeCastTup5 dep)))]

val useMemo6 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
  [@@js.custom
    let useMemo6 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafeCastTup6 dep)))]

val useMemo7 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'value
  [@@js.custom
    let useMemo7 f dep =
      unsafe_cast_res
        (useMemoInternal (unsafe_cast_f f) (Some (unsafeCastTup7 dep)))]

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

module Context : sig
  [@@@js.stop]

  type 'props t

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

  val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

  [@@@js.start]

  [@@@js.implem
  include [%js:
  type untyped = private Ojs.t

  val untyped_of_js : Ojs.t -> untyped

  val untyped_to_js : untyped -> Ojs.t]

  type 'props t = untyped

  let t_of_js _ x = untyped_of_js x

  let t_to_js _ x = untyped_to_js x]

  val makeProps :
       value:'props
    -> children:element
    -> unit
    -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
       Js_of_ocaml.Js.t
    [@@js.custom
      let makePropsInternal ~value ~children () =
        let obj = Ojs.empty_obj () in
        Ojs.set obj "value" value ;
        Ojs.set obj "children" (element_to_js children) ;
        obj

      let makeProps = Obj.magic makePropsInternal

      (* TODO: Is there a way to avoid magic? *)]

  val provider :
       'props t
    -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
       Js_of_ocaml.Js.t
       component
    [@@js.custom
      val providerInternal : Ojs.t -> Ojs.t [@@js.get "Provider"]

      let provider = Obj.magic providerInternal

      (* TODO: Is there a way to avoid magic? *)]
end

val createContext : 'a -> 'a Context.t
  [@@js.custom
    (* Important: we don't want to use an arrow type to represent components (i.e. (Ojs.t -> element)) as the component function
       would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
    val createContextInternal : Ojs.t -> Ojs.t
      [@@js.global "__LIB__react.createContext"]

    let createContext = Obj.magic createContextInternal

    (* TODO: Is there a way to avoid magic? *)]

val useContext : 'value Context.t -> 'value
  [@@js.custom
    val useContextInternal : Ojs.t Context.t -> Ojs.t
      [@@js.global "__LIB__react.useContext"]

    let useContext = Obj.magic useContextInternal

    (* TODO: Is there a way to avoid magic? *)]

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
