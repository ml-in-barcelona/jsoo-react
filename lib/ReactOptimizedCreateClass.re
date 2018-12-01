/* The `factory` method and the rest of the embedded JS
   is not here because jsoo doesn't support embedding raw JS.
   It can be found in the react.js file. */

let react = Js.Unsafe.global##.react##.react;
let factory = Js.Unsafe.global##.react##.factory;

let reactComponent: 'a = react##.Component;

let reactIsValidElement = react##.isValidElement;

let newReactComponent: unit => {. "updater": 'a} =
  () => [%js new reactComponent](Js.undefined);

let reactNoopUpdateQueue = newReactComponent()##.updater;

let createClass = component =>
  Js.Unsafe.fun_call(
    Js.Unsafe.fun_call(
      factory,
      [|reactComponent, reactIsValidElement, reactNoopUpdateQueue|],
    ),
    [|component|],
  );