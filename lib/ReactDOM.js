// Provides: ReactDOM
var ReactDOM = joo_global_object.ReactDOM;

// Provides: render
// Requires: ReactDOM
var render = ReactDOM.render;

// Provides: domProps
// Requires: setIfSome, setIfSomeMap, caml_js_from_string, caml_js_wrap_callback
var domProps = function(key, ref, alt, async, className, onClick) {
  var tmp = {};
  setIfSomeMap(tmp, "key", key, caml_js_from_string);
  setIfSome(tmp, "ref", ref);
  setIfSomeMap(tmp, "alt", alt, caml_js_from_string);
  setIfSome(tmp, "async", async);
  setIfSomeMap(tmp, "className", className, caml_js_from_string);
  setIfSomeMap(tmp, "onClick", onClick, caml_js_wrap_callback);
  return tmp;
};

// Provides: createDOMElementVariadic
// Requires: React, jsNullFromOption, caml_js_from_string, caml_js_from_array
var createDOMElementVariadic = function(string, props, children) {
  return React.createElement.apply(
    this,
    [caml_js_from_string(string), jsNullFromOption(props)].concat(
      caml_js_from_array(children)
    )
  );
};

// Provides: createFragment
// Requires: React, caml_js_from_array
var createFragment = function(children) {
  return React.createElement.apply(
    this,
    [React.Fragment, null].concat(caml_js_from_array(children))
  );
};
