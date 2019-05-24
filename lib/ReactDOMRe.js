// Provides: render
var render = joo_global_object.ReactDOM.render;

// Provides: createDOMElementVariadic
var createDOMElementVariadic = function(string, props, children) {
  return joo_global_object.React.createElement.apply(
    this,
    [joo_global_object.jsoo_runtime.caml_to_js_string(string), props].concat(children)
  );
};
