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
// Requires: React
var createElement = React.createElement;

// Provides: cloneElement
// Requires: React
var cloneElement = React.cloneElement;

// Provides: createElementVariadic
// Requires: React
var createElementVariadic = function(component, props, children) {
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

// Provides: useEffect
// Requires: React, caml_js_wrap_callback, caml_js_from_array
var useEffect = function(effect) {
  var callback = caml_js_wrap_callback(
    effect === 0 ? null : caml_js_from_array(effect)[0]
  );
  return React.useEffect(callback);
};