/* The `factory` method and the rest of the embedded JS
   is not here because jsoo doesn't support embedding raw JS.
   It can be found in the react.js file. */

class type factory = {
  pub factory:
    ('compConstructor, 'isValidElement, 'noopUpdateQueue, 'comp) =>
    Js.meth('createClass);
};

let react = Js.Unsafe.global##.React;
let factory: Js.t(factory) = Js.Unsafe.global##.Factory;

let reactComponent: 'a = react##.Component;

let reactIsValidElement = react##.isValidElement;

let newReactComponent: unit => {. "updater": 'a} =
  () => [%js new reactComponent](Js.undefined);

let reactNoopUpdateQueue = newReactComponent()##.updater;

let createClass = component =>
  factory##factory(
    reactComponent,
    reactIsValidElement,
    reactNoopUpdateQueue,
    component,
  );