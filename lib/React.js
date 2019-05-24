// Provides: nullElement
var nullElement = function() {
  return null;
};

// Provides: stringElement
var stringElement = function(t) {
  return joo_global_object.jsoo_runtime.caml_to_js_string(t);
};

// Provides: createElement
var createElement = joo_global_object.React.createElement;

// Provides: cloneElement
var cloneElement = joo_global_object.React.cloneElement;

// Provides: createElementVariadic
var createElementVariadic = function(component, props, children) {
  return joo_global_object.React.createElement.apply(
    this,
    [component, props].concat(children)
  );
};
