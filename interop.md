## Main idea: use `external`

It is much easier to use regular `external` statements and write bindings directly in JavaScript files.

The approach is:

- In `Module.re` write `external myFun: int => string = "myFun"`
- In `Module.js` write `var myFun = function(n){ return ... }`
- Apply conversions in the JS implementation as needed (see table below)

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

