## js_of_ocaml: Interop with JavaScript

There are two approaches to interop with JavaScript code in Js_of_ocaml:

1. Use the functions available in the [`Js` module](http://ocsigen.org/js_of_ocaml/3.1.0/api/Js) in order to translate the data inside Reason/OCaml files, so it can be used from JavaScript.
2. Use OCaml `external` statements to define the types, and then do the transformations on the JavaScript side. External functions are the same way that OCaml offers to [interop with C code](https://caml.inria.fr/pub/docs/manual-ocaml/intfc.html) as well.
3. Use `gen_js_api` and create interface files so that the tool generates all the mapping code for you :)

The approach being used in `jsoo-react` is the third, as it automates all the conversions needed and doesn't require to think about them

#### Adding a new binding to a React function

The main files are `lib/React.mli` and `lib/ReactDOM.mli`. They are both using OCaml syntax until Reason parser allows to declare nested attributes (see issue [#2445](https://github.com/facebook/reason/issues/2445)).

### gen_js_api: Comparison with BuckleScript

Some notes on how interop in BuckleScript and gen_js_api relate:

| Feature                      | BuckleScript interop  | gen_js_api interface files               |
| ---------------------------- | ----------------- | ---------------------------------------- |
| Use JS data types            | `array`, `string` | No work needed, conversions will be added in generated code automatically            |
| Require JS modules           | `[@bs.module]`    | Add `require("my-lib")` statement in `.js` file ([example](https://github.com/jchavarri/jsoo-react/blob/3a69759eaf7a777b8b006422b829c8e0fdcc94cf/lib/ReactJs.js)), include it in Dune ([example](https://github.com/jchavarri/jsoo-react/blob/3a69759eaf7a777b8b006422b829c8e0fdcc94cf/lib/dune#L5)) |
| Bind to JS values            | `[@bs.val]`       | `[@js.global]`                           |
| Variadic params              | `[@bs.splice]`    | `[@js.variadic]`                         |
| Raw expressions              | `[%bs.raw]`       | `Js.Unsafe.js_expr();`                   |
| Create JS objects            | `[%bs.obj]`       | `[@js.builder]`                          |
| Access JS objects properties | `##`              | `##.`                                    |
| Nullable values              | `Js.nullable`     | No work needed, conversions will be added in generated code automatically            |

For more information about `gen_js_api`, check the [project documentation](https://github.com/LexiFi/gen_js_api#documentation).
