// Provides: updateJsPropFromOpt
var updateJsPropFromOpt = function(obj, key) {
  if (obj[key] === 0) {
    delete obj[key];
  } else {
    obj[key] = obj[key][1];
  }
};

// Provides: jsNullToOption
var jsNullToOption = function(opt){
  return opt === null ? 0 : [0, opt]
}

// Provides: jsNullFromOption
var jsNullFromOption = function(camlOpt) {
  return camlOpt === 0 ? null : camlOpt[1];
};

// Provides: jsUndefinedFromOption
var jsUndefinedFromOption = function(camlOpt) {
  return camlOpt === 0 ? undefined : camlOpt[1];
};

// Provides: jsFromOptionMap
var jsFromOptionMap = function(camlOpt, f) {
  return camlOpt === 0 ? null : f(camlOpt[1]);
};

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
