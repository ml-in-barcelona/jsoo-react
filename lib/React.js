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

// Provides: useEffect
// Requires: React, caml_js_wrap_callback, optFromJs, caml_js_from_array
var useEffect = function(effect, dependencies) {
  var callback = caml_js_wrap_callback(effect);
  var jsDeps = dependencies ? caml_js_from_array(dependencies) : undefined;
  return React.useEffect(function() {
    var opt = optFromJs(callback);
    return opt === 0 ? null : caml_js_from_array(opt)[0];
  }, jsDeps);
};

// Provides: useLayoutEffect
// Requires: React, caml_js_wrap_callback, optFromJs, caml_js_from_array
var useLayoutEffect = function(effect, dependencies) {
  var callback = caml_js_wrap_callback(effect);
  var jsDeps = dependencies ? caml_js_from_array(dependencies) : undefined;
  return React.useLayoutEffect(function() {
    var opt = optFromJs(callback);
    return opt === 0 ? null : caml_js_from_array(opt)[0];
  }, jsDeps);
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
// Requires: React, caml_js_wrap_callback, optFromJs
var forwardRef = function(callback) {
  var jsCallback = caml_js_wrap_callback(callback);
  return React.forwardRef(function(props, jsRef) {
    var ref = optFromJs(jsRef);
    return jsCallback(props, jsRef);
  });
};

// Provides: useRef
// Requires: React
var useRef = React.useRef;
