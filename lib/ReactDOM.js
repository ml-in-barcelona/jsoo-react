// Provides: ReactDOM
var ReactDOM = joo_global_object.ReactDOM;

// Provides: caml_js_from_opt
// Requires: caml_js_from_array
var caml_js_from_opt = function(camlOpt) {
  return camlOpt === 0 ? null : caml_js_from_array(camlOpt)[0];
};

// Provides: render
// Requires: ReactDOM
var render = ReactDOM.render;

// Provides: createDOMElementVariadic
// Requires: React, caml_js_from_opt, caml_js_from_string, caml_js_from_array
var createDOMElementVariadic = function(string, props, children) {
  return React.createElement.apply(
    this,
    [caml_js_from_string(string), caml_js_from_opt(props)].concat(
      caml_js_from_array(children)
    )
  );
};
