(** Provides bindings to React.js
     {{:https://reactjs.org/docs/react-api.html}[react]} package, also known as React top-level API. *)

(** {1 Types} *)

(** The type that represents {{:https://reactjs.org/docs/glossary.html#elements}React elements}. React elements are not to be confounded with
DOM elements. React elements are just JavaScript objects that define what needs to be rendered 
on screen.

React.js docs glossary entry for {{:https://reactjs.org/docs/glossary.html#elements}elements}.

For more information, read {{:https://reactjs.org/blog/2015/12/18/react-components-elements-and-instances.html}React Components, Elements, and Instances}.

*)
type element

(** The type of possibly [null] values. *)
type 'a js_nullable = 'a Js_of_ocaml.Js.Opt.t

(** A helper type for functions that have component-like shape. *)
type ('props, 'return) componentLike = 'props -> 'return

(** The type of components. *)
type 'props component = ('props, element) componentLike

(** The type for callbacks passed to [useCallback*] effects. *)
type ('input, 'output) callback = 'input -> 'output

(** {1 Converters for [gen_js_api]} *)

(** These functions convert values from / to JavaScript and are useful in case {{:https://github.com/LexiFi/gen_js_api}gen_js_api}
is used.
*)

val element_of_js : Ojs.t -> element

val element_to_js : element -> Ojs.t

val js_nullable_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value js_nullable

val js_nullable_to_js : ('value -> Ojs.t) -> 'value js_nullable -> Ojs.t

val component_of_js : (Ojs.t -> 'props) -> Ojs.t -> 'props component

val component_to_js : ('props -> Ojs.t) -> 'props component -> Ojs.t

(** {1 Coercion to React elements} *)

val null : element
(** Creates an empty React element.
*)

val string : string -> element
(** Converts a string into a React element.
*)

val int : int -> element
(** Converts an integer into a React element.
*)

val float : float -> element
(** Converts a float into a React element.
*)

val list : element list -> element
(** Converts a list of elements into a React element.
*)

(** {1 Elements creation and cloning} *)

val createElement : 'props component -> 'props -> element
(** OCaml syntax: [createElement component props].

    Reason syntax: [createElement(component, props)].
    
    Create and return a new React element by calling the [component] [make] function with the given [props].

    If you are using [jsoo-react] {{!page:ppx}ppx}, you will not need to call [createElement] directly. This
    function will be called behind the scenes for components with zero or one child (see {!createElementVariadic}, which
    is called for elements with more than 1 child).

    React.js docs for {{:https://reactjs.org/docs/react-api.html#createelement}[React.createElement]}.
*)

val createElementVariadic :
  'props component -> 'props -> (element list[@js.variadic]) -> element
(** OCaml syntax: [createElementVariadic component props child1 child2 child3].

    Reason syntax: [createElementVariadic(component, props, child1, child2, child3)].
    
    Create and return a new React element by calling the [component] [make] function with the given [props] and children
    ([child1], [child2], [child3] in the example, but there can be any number).

    If you are using [jsoo-react] {{!page:ppx}ppx}, you will not need to call [createElementVariadic] directly. This
    function will be called behind the scenes for components with zero or one child (see {!createElement}, which
    is called for elements with 0 and 1 child).

    React.js docs for {{:https://reactjs.org/docs/react-api.html#createelement}[React.createElement]}.
*)

val cloneElement : element -> 'props -> element
(** OCaml syntax: [cloneElement element props].

    Reason syntax: [cloneElement(element, props)].
    
    Clone and return a new React element using [element] as the starting point.
    The resulting element will have the original element’s props with the new [props] merged in shallowly. 
    New children will replace existing children. [key] and [ref] from the original element will be preserved.

    React.js docs for {{:https://reactjs.org/docs/react-api.html#cloneelement}[React.cloneElement]}.
*)

(** {1 Hooks} *)

(** {2 [useEffect]} *)

val useEffect : (unit -> (unit -> unit) option) -> unit
(** OCaml syntax: [useEffect didUpdate].

    Reason syntax: [useEffect(didUpdate)].
    
    The function [didUpdate] will run after every render is committed to the screen.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect0 : (unit -> (unit -> unit) option) -> unit
(** OCaml syntax: [useEffect0 didUpdate].

    Reason syntax: [useEffect0(didUpdate)].
    
    The function [didUpdate] will run just once, after the first render is committed to the screen.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect1 : (unit -> (unit -> unit) option) -> 'a array -> unit
(** OCaml syntax: [useEffect1 didUpdate [|dependency|]].

    Reason syntax: [useEffect1(didUpdate, [|dependency|])].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of [dependency] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect2 : (unit -> (unit -> unit) option) -> 'a * 'b -> unit
(** OCaml syntax: [useEffect2 didUpdate dependencies].

    Reason syntax: [useEffect2(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of any of the 2 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect3 : (unit -> (unit -> unit) option) -> 'a * 'b * 'c -> unit
(** OCaml syntax: [useEffect3 didUpdate dependencies].

    Reason syntax: [useEffect3(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of any of the 3 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect4 : (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd -> unit
(** OCaml syntax: [useEffect4 didUpdate dependencies].

    Reason syntax: [useEffect4(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of any of the 4 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect5 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd * 'e -> unit
(** OCaml syntax: [useEffect5 didUpdate dependencies].

    Reason syntax: [useEffect5(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of any of the 5 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect6 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd * 'e * 'f -> unit
(** OCaml syntax: [useEffect6 didUpdate dependencies].

    Reason syntax: [useEffect6(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of any of the 6 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

val useEffect7 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> unit
(** OCaml syntax: [useEffect7 didUpdate dependencies].

    Reason syntax: [useEffect7(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally after the first render is committed to the screen,
    if the value of any of the 7 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useeffect}[React.useEffect]}.
*)

(** {2 [useLayoutEffect]} *)

val useLayoutEffect : (unit -> (unit -> unit) option) -> unit
(** OCaml syntax: [useLayoutEffect didUpdate].

    Reason syntax: [useLayoutEffect(didUpdate)].
    
    The function [didUpdate] will run before every render is committed to the screen.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect0 : (unit -> (unit -> unit) option) -> unit
(** OCaml syntax: [useLayoutEffect0 didUpdate].

    Reason syntax: [useLayoutEffect0(didUpdate)].
    
    The function [didUpdate] will run just once, before the first render is committed to the screen.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect1 : (unit -> (unit -> unit) option) -> 'a array -> unit
(** OCaml syntax: [useLayoutEffect1 didUpdate [|dependency|]].

    Reason syntax: [useLayoutEffect1(didUpdate, [|dependency|])].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of [dependency] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect2 : (unit -> (unit -> unit) option) -> 'a * 'b -> unit
(** OCaml syntax: [useLayoutEffect2 didUpdate dependencies].

    Reason syntax: [useLayoutEffect2(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of any of the 2 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect3 : (unit -> (unit -> unit) option) -> 'a * 'b * 'c -> unit
(** OCaml syntax: [useLayoutEffect3 didUpdate dependencies].

    Reason syntax: [useLayoutEffect3(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of any of the 3 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect4 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd -> unit
(** OCaml syntax: [useLayoutEffect4 didUpdate dependencies].

    Reason syntax: [useLayoutEffect4(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of any of the 4 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect5 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd * 'e -> unit
(** OCaml syntax: [useLayoutEffect5 didUpdate dependencies].

    Reason syntax: [useLayoutEffect5(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of any of the 5 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect6 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd * 'e * 'f -> unit
(** OCaml syntax: [useLayoutEffect6 didUpdate dependencies].

    Reason syntax: [useLayoutEffect6(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of any of the 6 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

val useLayoutEffect7 :
  (unit -> (unit -> unit) option) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> unit
(** OCaml syntax: [useLayoutEffect7 didUpdate dependencies].

    Reason syntax: [useLayoutEffect7(didUpdate, dependencies)].
    
    The function [didUpdate] will run conditionally before the first render is committed to the screen,
    if the value of any of the 7 [dependencies] has changed.

    [didUpdate] can optionally return a callback. If it does, the callback will be called before executing the next effect.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#uselayouteffect}[React.useLayoutEffect]}.
*)

(** {2 [useCallback]} *)

val useCallback0 : ('input, 'output) callback -> ('input, 'output) callback
(** OCaml syntax: [useCallback0 cb].

    Reason syntax: [useCallback0(cb)].
    
    Pass an inline callback [cb]. [useCallback0] will return
    a memoized version of the callback that never changes.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback1 :
  ('input, 'output) callback -> 'a array -> ('input, 'output) callback
(** OCaml syntax: [useCallback1 cb [|dependency|]].

    Reason syntax: [useCallback1(cb, [|dependency|])].
    
    Pass an inline callback [cb]. [useCallback1] will return
    a memoized version of the callback that only changes if the value of [dependency] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback2 :
  ('input, 'output) callback -> 'a * 'b -> ('input, 'output) callback
(** OCaml syntax: [useCallback2 cb dependencies].

    Reason syntax: [useCallback2(cb, dependencies)].
    
    Pass an inline callback [cb]. [useCallback2] will return
    a memoized version of the callback that only changes if the value of any of the 2 [dependencies] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback3 :
  ('input, 'output) callback -> 'a * 'b * 'c -> ('input, 'output) callback
(** OCaml syntax: [useCallback3 cb dependencies].

    Reason syntax: [useCallback3(cb, dependencies)].
    
    Pass an inline callback [cb]. [useCallback3] will return
    a memoized version of the callback that only changes if the value of any of the 3 [dependencies] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback4 :
  ('input, 'output) callback -> 'a * 'b * 'c * 'd -> ('input, 'output) callback
(** OCaml syntax: [useCallback4 cb dependencies].

    Reason syntax: [useCallback4(cb, dependencies)].
    
    Pass an inline callback [cb]. [useCallback4] will return
    a memoized version of the callback that only changes if the value of any of the 4 [dependencies] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback5 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e
  -> ('input, 'output) callback
(** OCaml syntax: [useCallback5 cb dependencies].

    Reason syntax: [useCallback5(cb, dependencies)].
    
    Pass an inline callback [cb]. [useCallback5] will return
    a memoized version of the callback that only changes if the value of any of the 5 [dependencies] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback6 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f
  -> ('input, 'output) callback
(** OCaml syntax: [useCallback6 cb dependencies].

    Reason syntax: [useCallback6(cb, dependencies)].
    
    Pass an inline callback [cb]. [useCallback6] will return
    a memoized version of the callback that only changes if the value of any of the 6 [dependencies] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

val useCallback7 :
     ('input, 'output) callback
  -> 'a * 'b * 'c * 'd * 'e * 'f * 'g
  -> ('input, 'output) callback
(** OCaml syntax: [useCallback7 cb dependencies].

    Reason syntax: [useCallback7(cb, dependencies)].
    
    Pass an inline callback [cb]. [useCallback7] will return
    a memoized version of the callback that only changes if the value of any of the 7 [dependencies] has changed.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usecallback}[React.useCallback]}.
*)

(** {2 [useMemo]} *)

val useMemo0 : (unit -> 'value) -> 'value
(** OCaml syntax: [useMemo0 create].

    Reason syntax: [useMemo0(create)].
    
    Pass a [create] function. [useMemo] will only recompute
    the memoized value once.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo1 : (unit -> 'value) -> 'a array -> 'value
(** OCaml syntax: [useMemo1 create [|dependency|]].

    Reason syntax: [useMemo1(create, [|dependency|])].
    
    Pass a [create] function. [useMemo1] will only recompute
    the memoized value when [dependency] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo2 : (unit -> 'value) -> 'a * 'b -> 'value
(** OCaml syntax: [useMemo2 create dependencies].

    Reason syntax: [useMemo2(create, dependencies)].
    
    Pass a [create] function. [useMemo2] will only recompute
    the memoized value when any of the 2 [dependencies] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo3 : (unit -> 'value) -> 'a * 'b * 'c -> 'value
(** OCaml syntax: [useMemo3 create dependencies].

    Reason syntax: [useMemo3(create, dependencies)].
    
    Pass a [create] function. [useMemo3] will only recompute
    the memoized value when any of the 3 [dependencies] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo4 : (unit -> 'value) -> 'a * 'b * 'c * 'd -> 'value
(** OCaml syntax: [useMemo4 create dependencies].

    Reason syntax: [useMemo4(create, dependencies)].
    
    Pass a [create] function. [useMemo4] will only recompute
    the memoized value when any of the 4 [dependencies] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo5 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e -> 'value
(** OCaml syntax: [useMemo5 create dependencies].

    Reason syntax: [useMemo5(create, dependencies)].
    
    Pass a [create] function. [useMemo5] will only recompute
    the memoized value when any of the 5 [dependencies] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo6 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f -> 'value
(** OCaml syntax: [useMemo6 create dependencies].

    Reason syntax: [useMemo6(create, dependencies)].
    
    Pass a [create] function. [useMemo6] will only recompute
    the memoized value when any of the 6 [dependencies] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

val useMemo7 : (unit -> 'value) -> 'a * 'b * 'c * 'd * 'e * 'f * 'g -> 'value
(** OCaml syntax: [useMemo7 create dependencies].

    Reason syntax: [useMemo7(create, dependencies)].
    
    Pass a [create] function. [useMemo7] will only recompute
    the memoized value when any of the 7 [dependencies] has changed.

    This optimization helps to avoid expensive calculations on every render.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usememo}[React.useMemo]}.
*)

(** {2 [useState]} *)

val useState : (unit -> 'state) -> 'state * (('state -> 'state) -> unit)
(** OCaml syntax: [useState initialState].

    Reason syntax: [useState(initialState)].
    
    Returns a stateful value, and a function to update it.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usestate}[React.useState]}.
*)

(** {2 [useReducer]} *)

val useReducer :
  ('state -> 'action -> 'state) -> 'state -> 'state * ('action -> unit)
(** OCaml syntax: [useReducer reducer initialState].

    Reason syntax: [useReducer(reducer, initialState)].
    
    An alternative to {!useState}. Accepts a [reducer] and some [initialState],
    and returns the current state paired with a dispatch method.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#usereducer}[React.useReducer]}.
*)

val useReducerWithMapState :
     ('state -> 'action -> 'state)
  -> 'initialState
  -> ('initialState -> 'state)
  -> 'state * ('action -> unit)
(** OCaml syntax: [useReducerWithMapState reducer initialState map].

    Reason syntax: [useReducerWithMapState(reducer, initialState, map)].
    
    Like {!useReducer}, accepts a reducer and some initialState, and returns the
    current state paired with a dispatch method. But [useReducerWithMapState]
    takes a third param [map] that will allow to initiate the state lazily.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#lazy-initialization}[React.useReducer lazy initialization]}.
*)

(** {1 Refs} *)

(** Contains types and functions to interact with references.
One can think of React references in the same terms as OCaml
{{:https://ocaml.org/learn/tutorials/pointers.html}pointers},
which are objects with a single field [current] that gets mutated.
*)
module Ref : sig
  (** The type that represents references. *)
  type 'value t

  val t_of_js : (Ojs.t -> 'value) -> Ojs.t -> 'value t
  (** Convert reference values from JavaScript. Useful to define bindings with {{:https://github.com/LexiFi/gen_js_api}gen_js_api}.
  *)

  val t_to_js : ('value -> Ojs.t) -> 'value t -> Ojs.t
  (** Convert reference values to JavaScript. Useful to define bindings with {{:https://github.com/LexiFi/gen_js_api}gen_js_api}.
  *)

  val current : 'value t -> 'value
  (** OCaml syntax: [current reference].

    Reason syntax: [current(reference)].
    
    Gets the current value of a given [reference].
  *)

  val setCurrent : 'value t -> 'value -> unit
  (** OCaml syntax: [setCurrent reference value].

    Reason syntax: [setCurrent(reference, value)].
    
    Sets the current value of a given [reference] to [value].
  *)
end

(** {2 [useRef]} *)

val useRef : 'value -> 'value Ref.t
(** OCaml syntax: [useRef value].

    Reason syntax: [useRef(value)].
    
    Returns a mutable ref object whose [current] property is initialized to the passed argument [value].
    The returned object will persist for the full lifetime of the component.

    React.js docs for {{:https://reactjs.org/docs/hooks-reference.html#useref}[React.useRef]}.
  *)

val createRef : unit -> 'a js_nullable Ref.t
(** Creates a reference that can be attached to React elements via the [ref] prop. 

    React.js docs for {{:https://reactjs.org/docs/react-api.html#reactcreateref}[React.createRef]}.
  *)

(** {1 Context} *)

(** Contains utilities to create React context provider components.

Example code for some context that contains a string:

In OCaml syntax:
{[
let context = React.createContext "foo"

module Provider = struct
  include React.Context
  let make = provider context
end

module Consumer = struct
  let make () =
    let value = React.useContext context in
    (div ~children:[value |> React.string] () [@JSX])
    [@@react.component]
end
]}

In Reason syntax:
{[
let context = React.createContext("foo");
module Provider = {
  include React.Context;
  let make = provider(context);
};
module Consumer = {
  [@react.component]
  let make = () => {
    let value = React.useContext(context);
    <div> {value |> React.string} </div>;
  };
};
]}

React.js docs for {{:https://reactjs.org/docs/context.html}context}.
*)
module Context : sig
  (** The type that represents a context object. *)
  type 'props t

  val makeProps :
       value:'props
    -> children:element
    -> unit
    -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
       Js_of_ocaml.Js.t
  (** This is a helper function that is shared across all context providers. 
    It is not supposed to be used explicitly, but rather brought into context inside
    the provider component module with a [include React.Context] statement.
  *)

  val provider :
       'props t
    -> < value: 'props ; children: element Js_of_ocaml.Js.readonly_prop >
       Js_of_ocaml.Js.t
       component
  (** OCaml syntax: [provider context].

    Reason syntax: [provider(context)].

    Allows to define the [make] function of a provider component, by using either
    [let make = provider context] in OCaml syntax, or [let make = provider(context)]
    in Reason syntax.

    React.js docs for {{:https://reactjs.org/docs/context.html#contextprovider}[Context.Provider]}.
  *)
end

val createContext : 'a -> 'a Context.t

(** {2 [useContext]} *)

val useContext : 'value Context.t -> 'value

(** {1 Children} *)

module Children : sig
  val map : element -> (element -> element) -> element

  val mapWithIndex : element -> (element -> int -> element) -> element

  val forEach : element -> (element -> unit) -> unit

  val forEachWithIndex : element -> (element -> int -> unit) -> unit

  val count : element -> int

  val only : element -> element

  val toArray : element -> element array
end

(** {1 Fragment} *)

module Fragment : sig
  val makeProps :
       children:element
    -> ?key:Js_of_ocaml.Js.js_string Js_of_ocaml.Js.t
    -> unit
    -> < children: element Js_of_ocaml.Js.readonly_prop > Js_of_ocaml.Js.t

  val make :
    < children: element Js_of_ocaml.Js.readonly_prop > Js_of_ocaml.Js.t
    component
end

val createFragment : element list -> element

(** {1 Memoization} *)

val memo : 'props component -> 'props component

val memoCustomCompareProps :
  'props component -> ('props -> 'props -> bool) -> 'props component

(** {1 Debugging} *)

val setDisplayName : 'props component -> string -> unit
