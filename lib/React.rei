type element = pri Ojs.t;

[@js.custom let null = None;]
let null: element;

[@js.cast]
let string: string => element;

[@js.cast]
let array: array(element) => element;

type componentLike('props, 'return) = 'props => 'return;

type component('props) = componentLike('props, element);

[@js.cast]
let array: array(element) => element;

[@js.global "__LIB__react"] 
let createElement: (component('props), 'props) => element;

[@js.global "__LIB__react"] 
let cloneElement: (component('props), 'props) => element;

[@js.global "__LIB__react"]
let createElementVariadic: (
  component('props),
  'props,
  [@js.variadic] array(element)
) => element;

// module Ref = {
//   type t('value);

//   external current: t('value) => 'value = "Ref_current";
//   external setCurrent: (t('value), 'value) => unit = "Ref_setCurrent";
// };

// external createRef: unit => Ref.t(option('a)) = "createRef";

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

[@js.global "__LIB__react"] 
let useState: (unit => 'state) => ('state, ('state => 'state) => unit);

[@js.global "__LIB__react"] 
let useReducer: (('state, 'action) => 'state, 'state) => ('state, 'action => unit);

[@js.global "__LIB__react"] 
let useEffect: (unit => option(unit => unit)) => unit;

[@js.implem
module Array: {
  type t('a) = array('a);
  let t_to_js: ('a => Ojs.t, t('a)) => Ojs.t;
  let t_of_js: (Ojs.t => 'a, Ojs.t) => t('a);
} = {
  type t('a) = array('a);
  let t_to_js = (ml2js, l) => {
    let o = Ojs.empty_obj();
    Array.iter(((k, v)) => Ojs.set(o, k, ml2js(v)), l);
    o;
  };
  let t_of_js = (js2ml, o) => {
    let l = ref([]);
    Ojs.iter_properties(o, k => l := [(k, js2ml(Ojs.get(o, k))), ...l^]);
    l^;
  };
};]

[@js.global "__LIB__react"] [@js.cast] 
let useEffect1: (unit => option(unit => unit), Array.t('a) ) => unit;

[@js.custom let useEffect0 = cb => useEffect1(cb, [||]);]
let useEffect0: (unit => option(unit => unit)) => unit;

// external useEffect2: (unit => option(unit => unit), ('a, 'b)) => unit =
//   "useEffect";

// external useEffect3: (unit => option(unit => unit), ('a, 'b, 'c)) => unit =
//   "useEffect";

// external useEffect4: (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit =
//   "useEffect";
// external useEffect5:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit =
//   "useEffect";

// external useEffect6:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
//   "useEffect";

// external useEffect7:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit =
//   "useEffect";

// external useLayoutEffect: (unit => option(unit => unit)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect0:
//   (unit => option(unit => unit), array(unit)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect1: (unit => option(unit => unit), array('a)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect2: (unit => option(unit => unit), ('a, 'b)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect3:
//   (unit => option(unit => unit), ('a, 'b, 'c)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect4:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit =
//   "useLayoutEffect";
// external useLayoutEffect5:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect6:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
//   "useLayoutEffect";

// external useLayoutEffect7:
//   (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit =
//   "useLayoutEffect";

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

// external useRef: 'value => Ref.t('value) = "useRef";

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
