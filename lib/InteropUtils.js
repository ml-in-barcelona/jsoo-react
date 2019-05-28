// Provides: setIfSome
var setIfSome = function(obj, key, val) {
  if (val !== 0) {
    obj[key] = val[1];
  }
};

// Provides: setIfSomeMap
var setIfSomeMap = function(obj, key, val, f) {
  if (val !== 0) {
    obj[key] = f(val[1]);
  }
};
