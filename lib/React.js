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
// Requires: React
var Ref_current = React.current;

// Provides: Ref_setCurrent
// Requires: React
var Ref_setCurrent = React.setCurrent;

// Provides: createRef
// Requires: React
var createRef = React.createRef;

// Provides: forwardRef
// Requires: React, caml_js_wrap_callback, jsNullToOption
var forwardRef = function(callback) {
  var jsCallback = caml_js_wrap_callback(callback);
  return React.forwardRef(function(props, jsRef) {
    var ref = jsNullToOption(jsRef);
    return jsCallback(props, jsRef);
  });
};

// Provides: useRef
// Requires: React
var useRef = React.useRef;
