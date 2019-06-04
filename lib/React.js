// Provides: React
var React = joo_global_object.React;

// Provides: nullElement
var nullElement = function() {
  return null;
};

// Provides: stringElement
// Requires: caml_js_from_string
var stringElement = caml_js_from_string;

// Provides: createElement
// Requires: React, updateJsPropFromOpt
var createElement = function(comp, props) {
  updateJsPropFromOpt(props, "key");
  return React.createElement(comp, props);
};

// Provides: cloneElement
// Requires: React
var cloneElement = React.cloneElement;

// Provides: createElementVariadic
// Requires: React, updateJsPropFromOpt
var createElementVariadic = function(component, props, children) {
  updateJsPropFromOpt(props, "key");
  return React.createElement.apply(this, [component, props].concat(children));
};

// Provides: useState
// Requires: React, caml_js_wrap_callback, caml_js_to_array
var useState = function(initialState) {
  var callback = caml_js_wrap_callback(initialState);
  var tuple = React.useState(callback);
  return caml_js_to_array(tuple);
};

// Provides: useReducer
// Requires: React, caml_js_wrap_callback, caml_js_to_array
var useReducer = function(reducer, initialState) {
  var jsReducer = caml_js_wrap_callback(reducer);
  var tuple = React.useReducer(jsReducer, initialState);
  return caml_js_to_array(tuple);
};

// Provides: useEffectFunction
// Requires: jsUndefinedFromOption, caml_js_from_array
var useEffectFunction = function(effectFunction) {
  return function(effect, dependencies) {
    // Dependencies can be undefined for useEffect0
    var jsDeps = dependencies ? caml_js_from_array(dependencies) : undefined;
    return effectFunction(function() {
      // No need to call caml_js_wrap_callback over `effect` or `unmount` as
      // they don't have any arguments
      var unmountEffect = effect();
      return jsUndefinedFromOption(unmountEffect);
    }, jsDeps);
  };
};

// Provides: useEffect
// Requires: React, useEffectFunction
var useEffect = useEffectFunction(React.useEffect);

// Provides: useLayoutEffect
// Requires: React, useEffectFunction
var useLayoutEffect = useEffectFunction(React.useLayoutEffect);

// Provides: Ref_current
var Ref_current = function(ref) {
  return ref.current;
};

// Provides: Ref_setCurrent
var Ref_setCurrent = function(ref, value) {
  ref.current = value;
};

// Provides: createRef
// Requires: React
var createRef = React.createRef;

// Provides: useRef
// Requires: React
var useRef = React.useRef;
