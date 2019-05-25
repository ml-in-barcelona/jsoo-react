// Provides: React
var React = joo_global_object.React;

// Provides: nullElement
var nullElement = function() {
  return null;
};

// Provides: stringElement
// Requires: caml_js_from_string
var stringElement = function(s) {
  return caml_js_from_string(s);
};

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
