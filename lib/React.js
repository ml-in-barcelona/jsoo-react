// Provides: React
var React = require('react');

// Provides: nullElement
var nullElement = function() {
  return null;
};

// Provides: stringElement
var stringElement = function(t) {
  return joo_global_object.jsoo_runtime.caml_to_js_string(t);
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
  return React.createElement.apply(
    this,
    [component, props].concat(children)
  );
};
