// Provides: ReactDOM
var ReactDOM = require('react-dom');

// Provides: render
// Requires: ReactDOM
var render = ReactDOM.render;

// Provides: createDOMElementVariadic
// Requires: React
var createDOMElementVariadic = function(string, props, children) {
  return React.createElement.apply(
    this,
    [joo_global_object.jsoo_runtime.caml_to_js_string(string), props].concat(children)
  );
};
