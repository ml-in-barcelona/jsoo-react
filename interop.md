## js_of_ocaml: Interop with JavaScript

There are two approaches to interop with JavaScript code in Js_of_ocaml:

1. Use the functions available in the [`Js` module](http://ocsigen.org/js_of_ocaml/3.1.0/api/Js) in order to translate the data inside Reason/OCaml files, so it can be used from JavaScript.
2. Use OCaml `external` statements to define the types, and then do the transformations on the JavaScript side. External functions are the same way that OCaml offers to [interop with C code](https://caml.inria.fr/pub/docs/manual-ocaml/intfc.html) as well.

The approach being used in `rroo` is the second. While it involves writing code that will live in JavaScript files and won't be checked by the type checker, using `external` statements has two main benefits:
- Doesn't require to learn specific ways to deal with transformations (like BuckleScript `[@bs]` annotations or Js_of_ocaml `Js` module)
- Delimits very well the boundaries between platform and library code, which is important for future explorations on platform independent type definitions for components that might surface from `rroo`.

#### Adding a new binding to a React function

The approach is:

1. In `Module.re` write `external myFun: int => string = "myFun"`
2. In `Module.js` write `var myFun = function(n){ return ... }`. The function will need to include two comments over its definition that declare:
  - Which external function it provides, e.g. `// Provides: useReducer`
  - Which other JavaScript functions or values it requires, e.g. `// Requires: React, caml_js_wrap_callback`
3. Apply conversions in the JS implementation as needed (see table below)
4. If required, add a new component with an example of usage of the new function in the `/example` folder.

#### Examples

See examples in `React.js` and `ReactDOM.js`.

A few types need to be converted between OCaml and JavaScript:

#### Data from JavaScript to OCaml

| Data type (JS) | function            |
| -------------- | ------------------- |
| string         | `caml_js_to_string` |
| array          | `caml_js_to_array`  |
| callback       | `tbd`               |
| option         | `tbd`               |

#### Data from OCaml to JavaScript

| Data type (OCaml) | function                                                  |
| ----------------- | --------------------------------------------------------- |
| string            | `caml_js_from_string`                                     |
| array             | `caml_js_from_array`                                      |
| callback          | `caml_js_wrap_callback`                                   |
| option            | `ocamlOpt === 0 ? null : caml_js_from_array(ocamlOpt)[0]` |

### Comparison with BuckleScript

Some notes on how interop in BuckleScript and js_of_ocaml relate. This is less relevant than the table above, as most of this is not necessary with `external` + `.js` file:

| Feature                      | BuckleScript      | js_of_ocaml                              |
| ---------------------------- | ----------------- | ---------------------------------------- |
| Use JS data types            | `array`, `string` | `Js.js_array`, `Js.js_string`            |
| Require JS modules           | `[@bs.module]`    | Read from global with `Js.Unsafe.global` |
| Bind to JS values            | `[@bs.val]`       | `Js.Unsafe.js_expr();`                   |
| Variadic params              | `[@bs.splice]`    | `Js.Unsafe.fun_call();`                  |
| Raw expressions              | `[%bs.raw]`       | `Js.Unsafe.js_expr();`                   |
| Create JS objects            | `[%bs.obj]`       | `[%js]` or `Js.Unsafe.obj`               |
| Access JS objects properties | `##`              | `##.`                                    |
| Nullable values              | `Js.nullable`     | `Js.Opt.t`                               |

