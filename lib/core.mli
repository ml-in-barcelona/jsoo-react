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
  [@@js.custom
    val createElement_internal : Imports.react -> 'a component -> 'a -> element
      [@@js.call "createElement"]

    let createElement component props =
      createElement_internal Imports.react component props]

val createElementVariadic :
  'props component -> 'props -> element list -> element
  [@@js.custom
    val createElementVariadic_internal :
         Imports.react
      -> 'props component
      -> 'props
      -> (element list[@js.variadic])
      -> element
      [@@js.call "createElement"]

    let createElementVariadic component props elements =
      createElementVariadic_internal Imports.react component props elements]

val cloneElement : element -> 'props -> element
  [@@js.custom
    val cloneElement_internal : Imports.react -> element -> 'a -> element
      [@@js.call "cloneElement"]

    let cloneElement element props =
      cloneElement_internal Imports.react element props]

val useEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useEffect_internal :
      Imports.react -> (unit -> (unit -> unit) option_undefined) -> unit
      [@@js.call "useEffect"]

    let useEffect callback = useEffect_internal Imports.react callback]

val useEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useEffect0_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> Ojs.t array
      -> unit
      [@@js.call "useEffect"]

    let useEffect0 callback = useEffect0_internal Imports.react callback [||]]

val useEffect1 : (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.custom
    val useEffect1_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a array
      -> unit
      [@@js.call "useEffect"]

    let useEffect1 callback watchlist =
      useEffect1_internal Imports.react callback watchlist]

val useEffect2 : (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    val useEffect2_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b
      -> unit
      [@@js.call "useEffect"]

    let useEffect2 callback watchlist =
      useEffect2_internal Imports.react callback watchlist]

val useEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    val useEffect3_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c
      -> unit
      [@@js.call "useEffect"]

    let useEffect3 callback watchlist =
      useEffect3_internal Imports.react callback watchlist]

val useEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    val useEffect4_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd
      -> unit
      [@@js.call "useEffect"]

    let useEffect4 callback watchlist =
      useEffect4_internal Imports.react callback watchlist]

val useEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    val useEffect5_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e
      -> unit
      [@@js.call "useEffect"]

    let useEffect5 callback watchlist =
      useEffect5_internal Imports.react callback watchlist]

val useEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    val useEffect6_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f
      -> unit
      [@@js.call "useEffect"]

    let useEffect6 callback watchlist =
      useEffect6_internal Imports.react callback watchlist]

val useEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    val useEffect7_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> unit
      [@@js.call "useEffect"]

    let useEffect7 callback watchlist =
      useEffect7_internal Imports.react callback watchlist]

val useLayoutEffect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useLayoutEffect_internal :
      Imports.react -> (unit -> (unit -> unit) option_undefined) -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect callback =
      useLayoutEffect_internal Imports.react callback]

val useLayoutEffect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val useLayoutEffect0_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> Ojs.t array
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect0 callback =
      useLayoutEffect0_internal Imports.react callback [||]]

val useLayoutEffect1 :
  (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.custom
    val useLayoutEffect1_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a array
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect1 callback watchlist =
      useLayoutEffect1_internal Imports.react callback watchlist]

val useLayoutEffect2 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    val useLayoutEffect2_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect2 callback watchlist =
      useLayoutEffect2_internal Imports.react callback watchlist]

val useLayoutEffect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    val useLayoutEffect3_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect3 callback watchlist =
      useLayoutEffect3_internal Imports.react callback watchlist]

val useLayoutEffect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    val useLayoutEffect4_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect4 callback watchlist =
      useLayoutEffect4_internal Imports.react callback watchlist]

val useLayoutEffect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    val useLayoutEffect5_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect5 callback watchlist =
      useLayoutEffect5_internal Imports.react callback watchlist]

val useLayoutEffect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    val useLayoutEffect6_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect6 callback watchlist =
      useLayoutEffect6_internal Imports.react callback watchlist]

val useLayoutEffect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    val useLayoutEffect7_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> unit
      [@@js.call "useLayoutEffect"]

    let useLayoutEffect7 callback watchlist =
      useLayoutEffect7_internal Imports.react callback watchlist]

val useCallback : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom
    val useCallback_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a array option_undefined
         (* Important: we don't want to use an arrow type to represent returning callback (i.e. (Ojs.t -> Ojs.t)) as the callback
            would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback cb = useCallback_internal Imports.react cb None]

val useCallback0 : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom
    let useCallback0 f = useCallback_internal Imports.react f (Some [||])]

val useCallback1 :
  ('input, 'output) callback -> 'a array -> ('input, 'output) callback
  [@@js.custom
    val useCallback1_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a array
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback1 callback watchlist =
      useCallback1_internal Imports.react callback watchlist]

val useCallback2 :
  ('input, 'output) callback -> 'a * 'b -> ('input, 'output) callback
  [@@js.custom
    val useCallback2_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback2 callback watchlist =
      useCallback2_internal Imports.react callback watchlist]

val useCallback3 :
  ('input, 'output) callback -> 'a * 'b * 'c -> ('input, 'output) callback
  [@@js.custom
    val useCallback3_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback3 callback watchlist =
      useCallback3_internal Imports.react callback watchlist]

val useCallback4 :
  ('input, 'output) callback -> 'a * 'b * 'c * 'd -> ('input, 'output) callback
  [@@js.custom
    val useCallback4_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback4 callback watchlist =
      useCallback4_internal Imports.react callback watchlist]

val useCallback5 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e
  -> ('input, 'output) callback
  [@@js.custom
    val useCallback5_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd * 'e
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback5 callback watchlist =
      useCallback5_internal Imports.react callback watchlist]

val useCallback6 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> ('input, 'output) callback
  [@@js.custom
    val useCallback6_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd * 'e * 'f
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback6 callback watchlist =
      useCallback6_internal Imports.react callback watchlist]

val useCallback7 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> ('input, 'output) callback
  [@@js.custom
    val useCallback7_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let useCallback7 callback watchlist =
      useCallback7_internal Imports.react callback watchlist]

val useMemo : (unit -> 'value) -> 'value
  [@@js.custom
    val useMemo_internal :
      Imports.react -> (unit -> 'value) -> 'any array option_undefined -> 'value
      [@@js.call "useMemo"]

    let useMemo f = useMemo_internal Imports.react f None]

val useMemo0 : (unit -> 'value) -> 'value
  [@@js.custom let useMemo0 f = useMemo_internal Imports.react f (Some [||])]

val useMemo1 : (unit -> 'value) -> 'a array -> 'value
  [@@js.custom
    val useMemo1_internal :
      Imports.react -> (unit -> 'value) -> 'a array -> 'value
      [@@js.call "useMemo"]

    let useMemo1 callback watchlist =
      useMemo1_internal Imports.react callback watchlist]

val useMemo2 : (unit -> 'value) -> 'a * 'b -> 'value
  [@@js.custom
    val useMemo2_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b -> 'value
      [@@js.call "useMemo"]

    let useMemo2 callback watchlist =
      useMemo2_internal Imports.react callback watchlist]

val useMemo3 : (unit -> 'value) -> 'a * 'b * 'c -> 'value
  [@@js.custom
    val useMemo3_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c -> 'value
      [@@js.call "useMemo"]

    let useMemo3 callback watchlist =
      useMemo3_internal Imports.react callback watchlist]

val useMemo4 : (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
  [@@js.custom
    val useMemo4_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
      [@@js.call "useMemo"]

    let useMemo4 callback watchlist =
      useMemo4_internal Imports.react callback watchlist]

val useMemo5 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
  [@@js.custom
    val useMemo5_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
      [@@js.call "useMemo"]

    let useMemo5 callback watchlist =
      useMemo5_internal Imports.react callback watchlist]

val useMemo6 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
  [@@js.custom
    val useMemo6_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
      [@@js.call "useMemo"]

    let useMemo6 callback watchlist =
      useMemo6_internal Imports.react callback watchlist]

val useMemo7 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'value
  [@@js.custom
    val useMemo7_internal :
         Imports.react
      -> (unit -> 'value)
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> 'value
      [@@js.call "useMemo"]

    let useMemo7 callback watchlist =
      useMemo7_internal Imports.react callback watchlist]

val useState : (unit -> 'state) -> 'state * (('state -> 'state) -> unit)
  [@@js.custom
    let (useState_internal :
             Imports.react
          -> (unit -> 'state)
          -> 'state * (('state -> 'state) -> unit) ) =
     fun (react : Imports.react) (init : unit -> 'state) ->
      let result =
        Ojs.call
          (Imports.react_to_js react)
          "useState"
          [|Ojs.fun_to_js 1 (fun _ -> Obj.magic (init ()))|]
      in
      (Obj.magic (Ojs.array_get result 0), Obj.magic (Ojs.array_get result 1))

    let useState initial = useState_internal Imports.react initial]

val useReducer :
  ('state -> 'action -> 'state) -> 'state -> 'state * ('action -> unit)
  [@@js.custom
    let (useReducer_internal :
             Imports.react
          -> ('state -> 'action -> 'state)
          -> 'state
          -> 'state * ('action -> unit) ) =
     fun (react : Imports.react) (reducer : 'state -> 'action -> 'state)
         (init : 'state) ->
      let result =
        Ojs.call
          (Imports.react_to_js react)
          "useReducer"
          [| Ojs.fun_to_js 2 (fun (state : Ojs.t) (action : Ojs.t) ->
                 Obj.magic (reducer (Obj.magic state) (Obj.magic action)) )
           ; Obj.magic init |]
      in
      (Obj.magic (Ojs.array_get result 0), Obj.magic (Ojs.array_get result 1))

    let useReducer reducer initial =
      useReducer_internal Imports.react reducer initial]

val useReducerWithMapState :
     ('state -> 'action -> 'state)
  -> 'initialState
  -> ('initialState -> 'state)
  -> 'state * ('action -> unit)
  [@@js.custom
    let (useReducerWithMapState_internal :
             Imports.react
          -> ('state -> 'action -> 'state)
          -> 'initialState
          -> ('initialState -> 'state)
          -> 'state * ('action -> unit) ) =
     fun (react : Imports.react) (reducer : 'state -> 'action -> 'state)
         (init : 'initialState) (map_state : 'initialState -> 'state) ->
      let result =
        Ojs.call
          (Imports.react_to_js react)
          "useReducer"
          [| Ojs.fun_to_js 2 (fun (state : Ojs.t) (action : Ojs.t) ->
                 Obj.magic (reducer (Obj.magic state) (Obj.magic action)) )
           ; Obj.magic init
           ; Ojs.fun_to_js 1 (fun (state : Ojs.t) ->
                 Obj.magic (map_state (Obj.magic state)) ) |]
      in
      (Obj.magic (Ojs.array_get result 0), Obj.magic (Ojs.array_get result 1))

    let useReducerWithMapState reducer initial mapper =
      useReducerWithMapState_internal Imports.react reducer initial mapper]

module Ref : sig
  type 'value t

  [@@@js.stop]

  val t_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value t

  val t_to_js : ('value -> Ojs.t) -> 'value t -> Ojs.t

  [@@@js.start]

  val current : 'value t -> 'value [@@js.get "current"]

  val setCurrent : 'value t -> 'value -> unit [@@js.set "current"]
end

val useRef : 'value -> 'value Ref.t
  [@@js.custom
    val useRef_internal : Imports.react -> 'value -> 'value Ref.t
      [@@js.call "useRef"]

    let useRef value = useRef_internal Imports.react value]

val createRef : unit -> 'a js_nullable Ref.t
  [@@js.custom
    val createRef_internal : Imports.react -> unit -> 'a js_nullable Ref.t
      [@@js.call "createRef"]

    let createRef () = createRef_internal Imports.react ()]

module Context : sig
  type 'props t

  val provider :
    'props t -> value:'props -> children:element list -> unit -> element
    [@@js.custom
      external of_ojs :
           Ojs.t
        -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
           Js_of_ocaml.Js.t
           component = "%identity"

      val provider_internal : 'props t -> Ojs.t [@@js.get "Provider"]

      let makeProps ~value () =
        Js_of_ocaml.Js.Unsafe.(obj [|("value", inject value)|])

      let provider c ~value ~children () =
        createElementVariadic
          (of_ojs (provider_internal c))
          (makeProps ~value ()) children]
end

val createContext : 'a -> 'a Context.t
  [@@js.custom
    val createContext_internal : Imports.react -> 'a -> 'a Context.t
      [@@js.call "createContext"]

    let createContext value = createContext_internal Imports.react value]

val useContext : 'value Context.t -> 'value
  [@@js.custom
    val useContext_internal : Imports.react -> 'a Context.t -> 'a
      [@@js.call "useContext"]

    let useContext ctx = useContext_internal Imports.react ctx]

module Children : sig
  [@@@js.implem
  val children_internal' : Imports.react -> Ojs.t [@@js.get "Children"]

  let children_internal = children_internal' Imports.react]

  val map : element -> (element -> element) -> element
    [@@js.custom
      val map_internal : Ojs.t -> element -> (element -> element) -> element
        [@@js.call "map"]

      let map element mapper = map_internal children_internal element mapper]

  val mapWithIndex : element -> (element -> int -> element) -> element
    [@@js.custom
      val mapWithIndex_internal :
        Ojs.t -> element -> (element -> int -> element) -> element
        [@@js.call "map"]

      let mapWithIndex element mapper =
        mapWithIndex_internal children_internal element mapper]

  val forEach : element -> (element -> unit) -> unit
    [@@js.custom
      val forEach_internal : Ojs.t -> element -> (element -> unit) -> unit
        [@@js.call "forEach"]

      let forEach element iterator =
        forEach_internal children_internal element iterator]

  val forEachWithIndex : element -> (element -> int -> unit) -> unit
    [@@js.custom
      val forEachWithIndex_internal :
        Ojs.t -> element -> (element -> int -> unit) -> unit
        [@@js.call "forEach"]

      let forEachWithIndex element iterator =
        forEachWithIndex_internal children_internal element iterator]

  val count : element -> int
    [@@js.custom
      val count_internal : Ojs.t -> element -> int [@@js.call "count"]

      let count element = count_internal children_internal element]

  val only : element -> element
    [@@js.custom
      val only_internal : Ojs.t -> element -> element [@@js.call "only"]

      let only element = only_internal children_internal element]

  val toArray : element -> element array
    [@@js.custom
      val toArray_internal : Ojs.t -> element -> element array
        [@@js.call "toArray"]

      let toArray element = toArray_internal children_internal element]
end

module Fragment : sig
  val make : children:element list -> ?key:string -> unit -> element
    [@@js.custom
      external to_component :
           Ojs.t
        -> < children: element Js_of_ocaml.Js.readonly_prop > Js_of_ocaml.Js.t
           component = "%identity"

      val fragment_internal' : Imports.react -> Ojs.t [@@js.get "Fragment"]

      let fragment_internal = fragment_internal' Imports.react

      let makeProps ?key () =
        match key with
        | Some k ->
            Js_of_ocaml.Js.Unsafe.(obj [|("key", inject k)|])
        | None ->
            Js_of_ocaml.Js.Unsafe.(obj [||])

      let make ~children ?key () =
        createElementVariadic
          (to_component fragment_internal)
          (makeProps ?key ()) children]
end

(* TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
   Although Reason parser doesn't support it so that's a requirement before adding it here *)
val createFragment : element list -> element
  [@@js.custom
    val createFragment_internal :
      Imports.react -> Ojs.t -> Ojs.t -> (element list[@js.variadic]) -> element
      [@@js.call "createElement"]

    let createFragment l =
      createFragment_internal Imports.react Fragment.fragment_internal Ojs.null
        l]

val memo : 'props component -> 'props component
  [@@js.custom
    val memo_internal : Imports.react -> 'props component -> 'props component
      [@@js.call "memo"]

    let memo component = memo_internal Imports.react component]

val memoCustomCompareProps :
  'props component -> ('props -> 'props -> bool) -> 'props component
  [@@js.custom
    val memoCustomCompareProps_internal :
         Imports.react
      -> 'props component
      -> ('props -> 'props -> bool)
      -> 'props component
      [@@js.call "memo"]

    let memoCustomCompareProps component compare =
      memoCustomCompareProps_internal Imports.react component compare]

val setDisplayName : 'props component -> string -> unit [@@js.set "displayName"]
