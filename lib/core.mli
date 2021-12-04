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

val component_of_js : 'a -> 'a

val component_to_js : 'a -> 'a

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
  [@@js.global "React.createElement"]

val createElementVariadic :
  'props component -> 'props -> (element list[@js.variadic]) -> element
  [@@js.global "React.createElement"]

val cloneElement : element -> 'props -> element
  [@@js.global "React.cloneElement"]

val useEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.global "React.useEffect"]

val useEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useEffectInternal :
      (unit -> (unit -> unit) option_undefined) -> Ojs.t array -> unit
      [@@js.global "React.useEffect"]

    let useEffect0 effect = useEffectInternal effect [||]]

val useEffect1 : (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.global "React.useEffect"]

val useEffect2 : (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.global "React.useEffect"]

val useEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.global "React.useEffect"]

val useEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.global "React.useEffect"]

val useEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.global "React.useEffect"]

val useEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.global "React.useEffect"]

val useEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.global "React.useEffect"]

val useLayoutEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useLayoutEffectInternal :
      (unit -> (unit -> unit) option_undefined) -> Ojs.t array -> unit
      [@@js.global "React.useLayoutEffect"]

    let useLayoutEffect0 effect = useLayoutEffectInternal effect [||]]

val useLayoutEffect1 :
  (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect2 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.global "React.useLayoutEffect"]

val useLayoutEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.global "React.useLayoutEffect"]

val useCallback : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom
    val useCallbackInternal :
         ('input, 'output) callback
      -> 'a array option_undefined
         (* Important: we don't want to use an arrow type to represent returning callback (i.e. (Ojs.t -> Ojs.t)) as the callback
            would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
      -> ('input, 'output) callback
      [@@js.global "React.useCallback"]

    let useCallback cb = useCallbackInternal cb None]

val useCallback0 : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom let useCallback0 f = useCallbackInternal f (Some [||])]

val useCallback1 :
  ('input, 'output) callback -> 'a array -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useCallback2 :
  ('input, 'output) callback -> 'a * 'b -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useCallback3 :
  ('input, 'output) callback -> 'a * 'b * 'c -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useCallback4 :
  ('input, 'output) callback -> 'a * 'b * 'c * 'd -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useCallback5 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e
  -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useCallback6 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useCallback7 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> ('input, 'output) callback
  [@@js.global "React.useCallback"]

val useMemo : (unit -> 'value) -> 'value
  [@@js.custom
    val useMemoInternal :
      (unit -> 'value) -> 'any array option_undefined -> 'value
      [@@js.global "React.useMemo"]

    let useMemo f = useMemoInternal f None]

val useMemo0 : (unit -> 'value) -> 'value
  [@@js.custom let useMemo0 f = useMemoInternal f (Some [||])]

val useMemo1 : (unit -> 'value) -> 'a array -> 'value
  [@@js.global "React.useMemo"]

val useMemo2 : (unit -> 'value) -> 'a * 'b -> 'value
  [@@js.global "React.useMemo"]

val useMemo3 : (unit -> 'value) -> 'a * 'b * 'c -> 'value
  [@@js.global "React.useMemo"]

val useMemo4 : (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
  [@@js.global "React.useMemo"]

val useMemo5 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
  [@@js.global "React.useMemo"]

val useMemo6 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
  [@@js.global "React.useMemo"]

val useMemo7 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'value
  [@@js.global "React.useMemo"]

val useState : (unit -> 'state) -> 'state * (('state -> 'state) -> unit)
  [@@js.global "React.useState"]

val useReducer :
  ('state -> 'action -> 'state) -> 'state -> 'state * ('action -> unit)
  [@@js.global "React.useReducer"]

val useReducerWithMapState :
     ('state -> 'action -> 'state)
  -> 'initialState
  -> ('initialState -> 'state)
  -> 'state * ('action -> unit)
  [@@js.global "React.useReducer"]

module Ref : sig
  type 'value t

  [@@@js.stop]

  val t_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value t

  val t_to_js : ('value -> Ojs.t) -> 'value t -> Ojs.t

  [@@@js.start]

  val current : 'value t -> 'value [@@js.get "current"]

  val setCurrent : 'value t -> 'value -> unit [@@js.set "current"]
end

val useRef : 'value -> 'value Ref.t [@@js.global "React.useRef"]

val createRef : unit -> 'a js_nullable Ref.t [@@js.global "React.createRef"]

(* TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
   Although Reason parser doesn't support it so that's a requirement before adding it here *)
val createFragment : element list -> element
  [@@js.custom
    val createFragmentInternal :
      Ojs.t -> Ojs.t -> (element list[@js.variadic]) -> element
      [@@js.global "React.createElement"]

    val fragmentInternal : Ojs.t [@@js.global "React.Fragment"]

    let createFragment l = createFragmentInternal fragmentInternal Ojs.null l]

module Context : sig
  type 'props t

  val provider : 'props t -> value:'props -> children:element list -> unit -> element
    [@@js.custom
      external of_ojs :
           Ojs.t
        -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
           Js_of_ocaml.Js.t
           component = "%identity"

      val providerInternal : 'props t -> Ojs.t [@@js.get "Provider"]

      let makeProps ~value () =
        Js_of_ocaml.Js.Unsafe.(
          obj [|("value", inject value);|])

      let provider c ~value ~children () =
          createElementVariadic
            (of_ojs (providerInternal c))
            (makeProps ~value ()) children]
end

val createContext : 'a -> 'a Context.t [@@js.global "React.createContext"]

val useContext : 'value Context.t -> 'value [@@js.global "React.useContext"]

module Children : sig
  val map : element -> (element -> element) -> element
    [@@js.global "React.Children.map"]

  val mapWithIndex : element -> (element -> int -> element) -> element
    [@@js.global "React.Children.map"]

  val forEach : element -> (element -> unit) -> unit
    [@@js.global "React.Children.forEach"]

  val forEachWithIndex : element -> (element -> int -> unit) -> unit
    [@@js.global "React.Children.forEach"]

  val count : element -> int [@@js.global "React.Children.count"]

  val only : element -> element [@@js.global "React.Children.only"]

  val toArray : element -> element array [@@js.global "React.Children.toArray"]
end

module Fragment : sig
  val make : children:element list -> ?key:string -> unit -> element
    [@@js.custom
      external to_component :
           Ojs.t
        -> < children: element Js_of_ocaml.Js.readonly_prop > Js_of_ocaml.Js.t
           component = "%identity"

      val makeInternal : Ojs.t [@@js.global "React.Fragment"]

      let makeProps ?key () =
        match key with
        | Some k ->
            Js_of_ocaml.Js.Unsafe.(
              obj [|("key", inject k);|])
        | None ->
            Js_of_ocaml.Js.Unsafe.(obj [||])

      let make ~children ?key () =
        createElementVariadic
          (to_component makeInternal)
          (makeProps ?key ()) children]
end

val memo : 'props component -> 'props component [@@js.global "React.memo"]

val memoCustomCompareProps :
  'props component -> ('props -> 'props -> bool) -> 'props component
  [@@js.global "React.memo"]

val setDisplayName : 'props component -> string -> unit [@@js.set "displayName"]
