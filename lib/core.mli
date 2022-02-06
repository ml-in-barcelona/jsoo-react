type element = private Ojs.t

val element_of_js : Ojs.t -> element

val element_to_js : element -> Ojs.t

val null : element [@@js.custom let null = Ojs.null]

val string : string -> element [@@js.cast]

val int : int -> element [@@js.cast]

val float : float -> element [@@js.cast]

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

val create_element : 'props component -> 'props -> element
  [@@js.custom
    val create_element_internal : Imports.react -> 'a component -> 'a -> element
      [@@js.call "createElement"]

    let create_element component props =
      create_element_internal Imports.react component props]

val create_element_variadic :
  'props component -> 'props -> element list -> element
  [@@js.custom
    val create_element_variadic_internal :
         Imports.react
      -> 'props component
      -> 'props
      -> (element list[@js.variadic])
      -> element
      [@@js.call "createElement"]

    let create_element_variadic component props elements =
      create_element_variadic_internal Imports.react component props elements]

val clone_element : element -> 'props -> element
  [@@js.custom
    val clone_element_internal : Imports.react -> element -> 'a -> element
      [@@js.call "cloneElement"]

    let clone_element element props =
      clone_element_internal Imports.react element props]

val use_effect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val use_effect_internal :
      Imports.react -> (unit -> (unit -> unit) option_undefined) -> unit
      [@@js.call "useEffect"]

    let use_effect callback = use_effect_internal Imports.react callback]

val use_effect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val use_effect0_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> Ojs.t array
      -> unit
      [@@js.call "useEffect"]

    let use_effect0 callback = use_effect0_internal Imports.react callback [||]]

val use_effect1 : (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.custom
    val use_effect1_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a array
      -> unit
      [@@js.call "useEffect"]

    let use_effect1 callback watchlist =
      use_effect1_internal Imports.react callback watchlist]

val use_effect2 : (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    val use_effect2_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b
      -> unit
      [@@js.call "useEffect"]

    let use_effect2 callback watchlist =
      use_effect2_internal Imports.react callback watchlist]

val use_effect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    val use_effect3_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c
      -> unit
      [@@js.call "useEffect"]

    let use_effect3 callback watchlist =
      use_effect3_internal Imports.react callback watchlist]

val use_effect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    val use_effect4_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd
      -> unit
      [@@js.call "useEffect"]

    let use_effect4 callback watchlist =
      use_effect4_internal Imports.react callback watchlist]

val use_effect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    val use_effect5_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e
      -> unit
      [@@js.call "useEffect"]

    let use_effect5 callback watchlist =
      use_effect5_internal Imports.react callback watchlist]

val use_effect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    val use_effect6_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f
      -> unit
      [@@js.call "useEffect"]

    let use_effect6 callback watchlist =
      use_effect6_internal Imports.react callback watchlist]

val use_effect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    val use_effect7_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> unit
      [@@js.call "useEffect"]

    let use_effect7 callback watchlist =
      use_effect7_internal Imports.react callback watchlist]

val use_layout_effect : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val use_layout_effect_internal :
      Imports.react -> (unit -> (unit -> unit) option_undefined) -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect callback =
      use_layout_effect_internal Imports.react callback]

val use_layout_effect0 : (unit -> (unit -> unit) option_undefined) -> unit
  [@@js.custom
    val use_layout_effect0_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> Ojs.t array
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect0 callback =
      use_layout_effect0_internal Imports.react callback [||]]

val use_layout_effect1 :
  (unit -> (unit -> unit) option_undefined) -> 'a array -> unit
  [@@js.custom
    val use_layout_effect1_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a array
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect1 callback watchlist =
      use_layout_effect1_internal Imports.react callback watchlist]

val use_layout_effect2 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b -> unit
  [@@js.custom
    val use_layout_effect2_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect2 callback watchlist =
      use_layout_effect2_internal Imports.react callback watchlist]

val use_layout_effect3 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c -> unit
  [@@js.custom
    val use_layout_effect3_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect3 callback watchlist =
      use_layout_effect3_internal Imports.react callback watchlist]

val use_layout_effect4 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd -> unit
  [@@js.custom
    val use_layout_effect4_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect4 callback watchlist =
      use_layout_effect4_internal Imports.react callback watchlist]

val use_layout_effect5 :
  (unit -> (unit -> unit) option_undefined) -> 'a * 'b * 'c * 'd * 'e -> unit
  [@@js.custom
    val use_layout_effect5_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect5 callback watchlist =
      use_layout_effect5_internal Imports.react callback watchlist]

val use_layout_effect6 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> unit
  [@@js.custom
    val use_layout_effect6_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect6 callback watchlist =
      use_layout_effect6_internal Imports.react callback watchlist]

val use_layout_effect7 :
     (unit -> (unit -> unit) option_undefined)
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> unit
  [@@js.custom
    val use_layout_effect7_internal :
         Imports.react
      -> (unit -> (unit -> unit) option_undefined)
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> unit
      [@@js.call "useLayoutEffect"]

    let use_layout_effect7 callback watchlist =
      use_layout_effect7_internal Imports.react callback watchlist]

val use_callback : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom
    val use_callback_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a array option_undefined
         (* Important: we don't want to use an arrow type to represent returning callback (i.e. (Ojs.t -> Ojs.t)) as the callback
            would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback cb = use_callback_internal Imports.react cb None]

val use_callback0 : ('input, 'output) callback -> ('input, 'output) callback
  [@@js.custom
    let use_callback0 f = use_callback_internal Imports.react f (Some [||])]

val use_callback1 :
  ('input, 'output) callback -> 'a array -> ('input, 'output) callback
  [@@js.custom
    val use_callback1_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a array
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback1 callback watchlist =
      use_callback1_internal Imports.react callback watchlist]

val use_callback2 :
  ('input, 'output) callback -> 'a * 'b -> ('input, 'output) callback
  [@@js.custom
    val use_callback2_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback2 callback watchlist =
      use_callback2_internal Imports.react callback watchlist]

val use_callback3 :
  ('input, 'output) callback -> 'a * 'b * 'c -> ('input, 'output) callback
  [@@js.custom
    val use_callback3_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback3 callback watchlist =
      use_callback3_internal Imports.react callback watchlist]

val use_callback4 :
  ('input, 'output) callback -> 'a * 'b * 'c * 'd -> ('input, 'output) callback
  [@@js.custom
    val use_callback4_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback4 callback watchlist =
      use_callback4_internal Imports.react callback watchlist]

val use_callback5 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e
  -> ('input, 'output) callback
  [@@js.custom
    val use_callback5_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd * 'e
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback5 callback watchlist =
      use_callback5_internal Imports.react callback watchlist]

val use_callback6 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> ('input, 'output) callback
  [@@js.custom
    val use_callback6_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd * 'e * 'f
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback6 callback watchlist =
      use_callback6_internal Imports.react callback watchlist]

val use_callback7 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> ('input, 'output) callback
  [@@js.custom
    val use_callback7_internal :
         Imports.react
      -> ('input, 'output) callback
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> ('input, 'output) callback
      [@@js.call "useCallback"]

    let use_callback7 callback watchlist =
      use_callback7_internal Imports.react callback watchlist]

val use_memo : (unit -> 'value) -> 'value
  [@@js.custom
    val use_memo_internal :
      Imports.react -> (unit -> 'value) -> 'any array option_undefined -> 'value
      [@@js.call "useMemo"]

    let use_memo f = use_memo_internal Imports.react f None]

val use_memo0 : (unit -> 'value) -> 'value
  [@@js.custom let use_memo0 f = use_memo_internal Imports.react f (Some [||])]

val use_memo1 : (unit -> 'value) -> 'a array -> 'value
  [@@js.custom
    val use_memo1_internal :
      Imports.react -> (unit -> 'value) -> 'a array -> 'value
      [@@js.call "useMemo"]

    let use_memo1 callback watchlist =
      use_memo1_internal Imports.react callback watchlist]

val use_memo2 : (unit -> 'value) -> 'a * 'b -> 'value
  [@@js.custom
    val use_memo2_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b -> 'value
      [@@js.call "useMemo"]

    let use_memo2 callback watchlist =
      use_memo2_internal Imports.react callback watchlist]

val use_memo3 : (unit -> 'value) -> 'a * 'b * 'c -> 'value
  [@@js.custom
    val use_memo3_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c -> 'value
      [@@js.call "useMemo"]

    let use_memo3 callback watchlist =
      use_memo3_internal Imports.react callback watchlist]

val use_memo4 : (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
  [@@js.custom
    val use_memo4_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
      [@@js.call "useMemo"]

    let use_memo4 callback watchlist =
      use_memo4_internal Imports.react callback watchlist]

val use_memo5 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
  [@@js.custom
    val use_memo5_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
      [@@js.call "useMemo"]

    let use_memo5 callback watchlist =
      use_memo5_internal Imports.react callback watchlist]

val use_memo6 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
  [@@js.custom
    val use_memo6_internal :
      Imports.react -> (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
      [@@js.call "useMemo"]

    let use_memo6 callback watchlist =
      use_memo6_internal Imports.react callback watchlist]

val use_memo7 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'value
  [@@js.custom
    val use_memo7_internal :
         Imports.react
      -> (unit -> 'value)
      -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
      -> 'value
      [@@js.call "useMemo"]

    let use_memo7 callback watchlist =
      use_memo7_internal Imports.react callback watchlist]

val use_state : (unit -> 'state) -> 'state * (('state -> 'state) -> unit)
  [@@js.custom
    let (use_state_internal :
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

    let use_state initial = use_state_internal Imports.react initial]

val use_reducer :
  ('state -> 'action -> 'state) -> 'state -> 'state * ('action -> unit)
  [@@js.custom
    let (use_reducer_internal :
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

    let use_reducer reducer initial =
      use_reducer_internal Imports.react reducer initial]

val use_reducer_with_map_state :
     ('state -> 'action -> 'state)
  -> 'initialState
  -> ('initialState -> 'state)
  -> 'state * ('action -> unit)
  [@@js.custom
    let (use_reducer_with_map_state_internal :
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

    let use_reducer_with_map_state reducer initial mapper =
      use_reducer_with_map_state_internal Imports.react reducer initial mapper]

module Ref : sig
  type 'value t

  [@@@js.stop]

  val t_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value t

  val t_to_js : ('value -> Ojs.t) -> 'value t -> Ojs.t

  [@@@js.start]

  val current : 'value t -> 'value [@@js.get "current"]

  val set_current : 'value t -> 'value -> unit [@@js.set "current"]
end

val use_ref : 'value -> 'value Ref.t
  [@@js.custom
    val use_ref_internal : Imports.react -> 'value -> 'value Ref.t
      [@@js.call "useRef"]

    let use_ref value = use_ref_internal Imports.react value]

val create_ref : unit -> 'a js_nullable Ref.t
  [@@js.custom
    val create_ref_internal : Imports.react -> unit -> 'a js_nullable Ref.t
      [@@js.call "createRef"]

    let create_ref () = create_ref_internal Imports.react ()]

module Context : sig
  type 'props t

  val provider : 'props t -> 'props component [@@js.get "Provider"]

  module Provider : sig
    val make :
      'props t -> value:'props -> children:element list -> unit -> element
      [@@js.custom
        let makeProps value =
          Js_of_ocaml.Js.Unsafe.(obj [|("value", inject value)|])

        let make context ~value ~children () =
          create_element_variadic (provider context) (makeProps value) children]
  end
end

val create_context : 'a -> 'a Context.t
  [@@js.custom
    val create_context_internal : Imports.react -> 'a -> 'a Context.t
      [@@js.call "createContext"]

    let create_context value = create_context_internal Imports.react value]

val use_context : 'value Context.t -> 'value
  [@@js.custom
    val use_context_internal : Imports.react -> 'a Context.t -> 'a
      [@@js.call "useContext"]

    let use_context ctx = use_context_internal Imports.react ctx]

module Children : sig
  [@@@js.implem
  val children_internal' : Imports.react -> Ojs.t [@@js.get "Children"]

  let children_internal = children_internal' Imports.react]

  val map : element list -> (element -> element) -> element
    [@@js.custom
      val map_internal :
        Ojs.t -> element list -> (element -> element) -> element
        [@@js.call "map"]

      let map element mapper = map_internal children_internal element mapper]

  val mapWithIndex : element list -> (element -> int -> element) -> element
    [@@js.custom
      val mapWithIndex_internal :
        Ojs.t -> element list -> (element -> int -> element) -> element
        [@@js.call "map"]

      let mapWithIndex element mapper =
        mapWithIndex_internal children_internal element mapper]

  val forEach : element list -> (element -> unit) -> unit
    [@@js.custom
      val forEach_internal : Ojs.t -> element list -> (element -> unit) -> unit
        [@@js.call "forEach"]

      let forEach element iterator =
        forEach_internal children_internal element iterator]

  val forEachWithIndex : element list -> (element -> int -> unit) -> unit
    [@@js.custom
      val forEachWithIndex_internal :
        Ojs.t -> element list -> (element -> int -> unit) -> unit
        [@@js.call "forEach"]

      let forEachWithIndex element iterator =
        forEachWithIndex_internal children_internal element iterator]

  val count : element list -> int
    [@@js.custom
      val count_internal : Ojs.t -> element list -> int [@@js.call "count"]

      let count element = count_internal children_internal element]

  val only : element list -> element
    [@@js.custom
      val only_internal : Ojs.t -> element list -> element [@@js.call "only"]

      let only element = only_internal children_internal element]

  val toArray : element list -> element array
    [@@js.custom
      val toArray_internal : Ojs.t -> element list -> element array
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
        create_element_variadic
          (to_component fragment_internal)
          (makeProps ?key ()) children]
end

(* TODO: add key: https://reactjs.org/docs/fragments.html#keyed-fragments
   Although Reason parser doesn't support it so that's a requirement before adding it here *)
val create_fragment : element list -> element
  [@@js.custom
    val create_fragment_internal :
      Imports.react -> Ojs.t -> Ojs.t -> (element list[@js.variadic]) -> element
      [@@js.call "createElement"]

    let create_fragment l =
      create_fragment_internal Imports.react Fragment.fragment_internal Ojs.null
        l]

val memo : 'props component -> 'props component
  [@@js.custom
    val memo_internal : Imports.react -> 'props component -> 'props component
      [@@js.call "memo"]

    let memo component = memo_internal Imports.react component]

val memo_custom_compare_props :
  'props component -> ('props -> 'props -> bool) -> 'props component
  [@@js.custom
    val memo_custom_compare_props_internal :
         Imports.react
      -> 'props component
      -> ('props -> 'props -> bool)
      -> 'props component
      [@@js.call "memo"]

    let memo_custom_compare_props component compare =
      memo_custom_compare_props_internal Imports.react component compare]

val setDisplayName : 'props component -> string -> unit [@@js.set "displayName"]
