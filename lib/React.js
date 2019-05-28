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
// Requires: React, setIfSome
var createElement = function(comp, props) {
  setIfSome(props, "key", props.key);
  return React.createElement(comp, props);
};

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

// Provides: Ref_current
// Requires: React
var Ref_current = React.current;

// Provides: Ref_setCurrent
// Requires: React
var Ref_setCurrent = React.setCurrent;

// Provides: createRef
// Requires: React
var createRef = React.createRef;

// Provides: forwardRef
// Requires: React, caml_js_wrap_callback
var forwardRef = function(callback) {
  var jsCallback = caml_js_wrap_callback(callback);
  React.forwardRef(function(props, jsRef) {
    var ref = jsRef === null ? 0 : [0, jsRef];
    jsCallback(props, jsRef);
  });
};

// Provides: useRef
// Requires: React
var useRef = React.useRef;
