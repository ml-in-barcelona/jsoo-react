type element;

let null: element;
let string: string => element;
let array: array(element) => element;

type component('props) = 'props => element;

let createElement: (component('props), 'props) => element;
let cloneElement: (component('props), 'props) => element;
let createElementVariadic:
  (component('props), 'props, array(element)) => element;

module Ref: {
  type t('value);
  let current: t('value) => 'value;
  let setCurrent: (t('value), 'value) => unit;
};

let createRef: unit => Ref.t(option('a));
let forwardRef:
  (('props, option(Ref.t('a))) => element) => component('props);

let useState: (unit => 'state) => ('state, ('state => 'state) => unit);
let useReducer:
  (('state, 'action) => 'state, 'state) => ('state, 'action => unit);

let useEffect: (unit => option(unit => unit)) => unit;
let useEffect0: (unit => option(unit => unit), array(unit)) => unit;
let useEffect1: (unit => option(unit => unit), array('a)) => unit;
let useEffect2: (unit => option(unit => unit), ('a, 'b)) => unit;
let useEffect3: (unit => option(unit => unit), ('a, 'b, 'c)) => unit;
let useEffect4: (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit;
let useEffect5:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit;
let useEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit;
let useEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit;

let useLayoutEffect: (unit => option(unit => unit)) => unit;
let useLayoutEffect0:
  (unit => option(unit => unit), array(unit)) => unit;
let useLayoutEffect1: (unit => option(unit => unit), array('a)) => unit;
let useLayoutEffect2: (unit => option(unit => unit), ('a, 'b)) => unit;
let useLayoutEffect3:
  (unit => option(unit => unit), ('a, 'b, 'c)) => unit;
let useLayoutEffect4:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd)) => unit;
let useLayoutEffect5:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e)) => unit;
let useLayoutEffect6:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f)) => unit;
let useLayoutEffect7:
  (unit => option(unit => unit), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => unit;

let useRef: 'value => Ref.t('value);
