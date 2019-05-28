// Provides: ReactDOM
var ReactDOM = joo_global_object.ReactDOM;

// Provides: fromOpt
var fromOpt = function(camlOpt) {
  return camlOpt === 0 ? null : camlOpt[1];
};

// Provides: render
// Requires: ReactDOM
var render = ReactDOM.render;

// Provides: domProps
// Requires: setIfSome, setIfSomeMap, caml_js_from_string, caml_js_wrap_callback
var domProps = function(ref, alt, async, className, onClick) {
  var tmp = {};
  setIfSome(tmp, "ref", ref);
  setIfSomeMap(tmp, "alt", alt, caml_js_from_string);
  setIfSome(tmp, "async", async);
  setIfSomeMap(tmp, "className", className, caml_js_from_string);
  setIfSomeMap(tmp, "onClick", onClick, caml_js_wrap_callback);
  return tmp;
};

// Provides: createDOMElementVariadic
// Requires: React, fromOpt, caml_js_from_string, caml_js_from_array
var createDOMElementVariadic = function(string, props, children) {
  return React.createElement.apply(
    this,
    [caml_js_from_string(string), fromOpt(props)].concat(
      caml_js_from_array(children)
    )
  );
};
