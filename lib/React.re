open Js_of_ocaml;

class type react = {
  pub useState: Js.callback(unit => 'state) => Js.meth(Js.js_array('a));
  pub useReducer:
    (Js.callback(('state, 'action) => 'state), 'state) =>
    Js.meth(Js.js_array('a));
};

let react: Js.t(react) = Js.Unsafe.global##.React;

type element;

let null: element = Js.Unsafe.js_expr("null");

external jsStringToElement: Js.t(Js.js_string) => element = "%identity";
let string = s => Js.string(s) |> jsStringToElement;

external array: array(element) => element = "%identity";

type component('props) = 'props => element;

external createElement: (component('props), 'props) => element =
  "createElement";

external cloneElement: (component('props), 'props) => element =
  "cloneElement";

external createElementVariadic:
  (component('props), 'props, array(element)) => element =
  "createElementVariadic";

module Ref = {
  type t('value);

  external current: t('value) => 'value = "Ref_current";
  external setCurrent: (t('value), 'value) => unit = "Ref_setCurrent";
};

external createRef: unit => Ref.t(option('a)) = "createRef";

external forwardRef:
  (('props, option(Ref.t('a))) => element) => component('props) =
  "forwardRef";

// module Children = {
//   external map: (element, element => element) => element = "Children_map";
//   external forEach: (element, element => unit) => unit = "Children_forEach";
//   external count: element => int = "Children_fffcount";
//   external only: element => element = "Children_only";
//   external toArray: element => array(element) = "Children_toArray";
// };

// module Context = {
//   type t('props);

//   [@bs.get]
//   external provider:
//     t('props) =>
//     component({
//       .
//       "value": 'props,
//       "children": element,
//     }) =
//     "Provider";
// };

// [@bs.module "react"] external createContext: 'a => Context.t('a) = "";

// [@bs.module "react"]
// external memo: component('props) => component('props) = "";

// [@bs.module "react"]
// external memoCustomCompareProps:
//   (component('props), [@bs.uncurry] (('props, 'props) => bool)) =>
//   component('props) =
//   "memo";

// module Fragment = {
//   [@bs.obj]
//   external makeProps:
//     (~children: element, ~key: 'key=?, unit) => {. "children": element} =
//     "";
//   [@bs.module "react"]
//   external make: component({. "children": element}) = "Fragment";
// };

// module Suspense = {
//   [@bs.obj]
//   external makeProps:
//     (
//       ~children: element=?,
//       ~fallback: element=?,
//       ~maxDuration: int=?,
//       ~key: 'key=?,
//       unit
//     ) =>
//     {
//       .
//       "children": option(element),
//       "fallback": option(element),
//       "maxDuration": option(int),
//     } =
//     "";
//   [@bs.module "react"]
//   external make:
//     component({
//       .
//       "children": option(element),
//       "fallback": option(element),
//       "maxDuration": option(int),
//     }) =
//     "Suspense";
// };

/* HOOKS */

let useState = initialState => {
  let callback = Js.wrap_callback(initialState);
  let tuple = react##useState(callback);
  let state: 'state = Js.Unsafe.get(tuple, 0);
  let setState: ('state => 'state) => unit = Js.Unsafe.get(tuple, 1);
  (state, setState);
};

let useReducer = (reducer, initialState) => {
  let jsReducer = Js.wrap_callback(reducer);
  let tuple = react##useReducer(jsReducer, initialState);
  let state: 'state = Js.Unsafe.get(tuple, 0);
  let dispatch: 'action => unit = Js.Unsafe.get(tuple, 1);
  (state, dispatch);
};

external useEffect: (unit => option(unit => unit)) => unit = "useEffect";

external useEffect0: (unit => option(unit => unit), array(unit)) => unit =
  "useEffect";

external useEffect1: (unit => option(unit => unit), array('a)) => unit =
  "useEffect";

external useEffect2: (unit => option(unit => unit), ('a, 'b)) => unit =
  "useEffect";

external useEffect3: (unit => option(unit => unit), ('a, 'b, 'c)) => unit =
  "useEffect";

external useEffect4: (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit =
  "useEffect";
external useEffect5:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useEffect";

external useEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
  "useEffect";

external useEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit =
  "useEffect";

external useLayoutEffect: (unit => option(unit => unit)) => unit =
  "useLayoutEffect";

external useLayoutEffect0:
  (unit => option(unit => unit), array(unit)) => unit =
  "useLayoutEffect";

external useLayoutEffect1: (unit => option(unit => unit), array('a)) => unit =
  "useLayoutEffect";

external useLayoutEffect2: (unit => option(unit => unit), ('a, 'b)) => unit =
  "useLayoutEffect";

external useLayoutEffect3:
  (unit => option(unit => unit), ('a, 'b, 'c)) => unit =
  "useLayoutEffect";

external useLayoutEffect4:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit =
  "useLayoutEffect";
external useLayoutEffect5:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useLayoutEffect";

external useLayoutEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
  "useLayoutEffect";

external useLayoutEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit =
  "useLayoutEffect";

// [@bs.module "react"]
// external useReducerWithMapState:
//   (
//     [@bs.uncurry] (('state, 'action) => 'state),
//     'initialState,
//     'initialState => 'state
//   ) =>
//   ('state, 'action => unit) =
//   "useReducer";

// [@bs.module "react"]
// external useMemo: ([@bs.uncurry] (unit => 'any)) => 'any = "useMemo";
// [@bs.module "react"]
// external useMemo0:
//   ([@bs.uncurry] (unit => 'any), [@bs.as {json|[]|json}] _) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo1: ([@bs.uncurry] (unit => 'any), array('a)) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo2: ([@bs.uncurry] (unit => 'any), ('a, 'b)) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo3: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c)) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo4: ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd)) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo5:
//   ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo6:
//   ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any =
//   "useMemo";
// [@bs.module "react"]
// external useMemo7:
//   ([@bs.uncurry] (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any =
//   "useMemo";

// /* This is used as return values  */
// type callback('input, 'output) = 'input => 'output;

// [@bs.module "react"]
// external useCallback:
//   ([@bs.uncurry] ('input => 'output)) => callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback0:
//   ([@bs.uncurry] ('input => 'output), [@bs.as {json|[]|json}] _) =>
//   callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback1:
//   ([@bs.uncurry] ('input => 'output), array('a)) => callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback2:
//   ([@bs.uncurry] ('input => 'output), ('a, 'b)) => callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback3:
//   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c)) =>
//   callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback4:
//   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd)) =>
//   callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback5:
//   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e)) =>
//   callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback6:
//   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f)) =>
//   callback('input, 'output) =
//   "useCallback";
// [@bs.module "react"]
// external useCallback7:
//   ([@bs.uncurry] ('input => 'output), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) =>
//   callback('input, 'output) =
//   "useCallback";

// [@bs.module "react"] external useContext: Context.t('any) => 'any = "";

external useRef: 'value => Ref.t('value) = "useRef";

// [@bs.module "react"]
// external useImperativeHandle0:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     [@bs.as {json|[]|json}] _
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle1:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     array('a)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle2:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     ('a, 'b)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle3:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     ('a, 'b, 'c)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle4:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     ('a, 'b, 'c, 'd)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle5:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     ('a, 'b, 'c, 'd, 'e)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle6:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     ('a, 'b, 'c, 'd, 'e, 'f)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.module "react"]
// external useImperativeHandle7:
//   (
//     Js.Nullable.t(Ref.t('value)),
//     [@bs.uncurry] (unit => 'value),
//     ('a, 'b, 'c, 'd, 'e, 'f, 'g)
//   ) =>
//   unit =
//   "useImperativeHandle";

// [@bs.set]
// external setDisplayName: (component('props), string) => unit = "displayName";
