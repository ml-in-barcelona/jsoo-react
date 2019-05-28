// Provides: updateJsPropFromOpt
var updateJsPropFromOpt = function(obj, key) {
  if (obj[key] === 0) {
    delete obj[key];
  } else {
    obj[key] = obj[key][1];
  }
};

// Provides: optFromJs
var optFromJs = function(opt){
  return opt === null ? 0 : [0, opt]
}

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
