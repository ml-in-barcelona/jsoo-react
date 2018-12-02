# rroo

Reason/Ocaml bindings to ReactJS compatible with js_of_ocaml (instead of BuckleScript).

Based on the original [ReasonReact](https://github.com/reasonml/reason-react/).

### Migration guide from a ReasonReact / BuckleScript branch

Some of the things that change from BuckleScript and js_of_ocaml are:

| Feature                      | BuckleScript      | js_of_ocaml                              |
| ---------------------------- | ----------------- | ---------------------------------------- |
| Use JS data types            | `array`, `string` | `Js.js_array`, `Js.js_string`            |
| Require JS modules           | `[@bs.module]`    | Read from global with `Js.Unsafe.global` |
| Bind to JS values            | `[@bs.val]`       | `Js.Unsafe.js_expr();`                   |
| Variadic params              | `[@bs.splice]`    | `Js.Unsafe.fun_call();`                  |
| Raw expressions              | `[%bs.raw]`       | `Js.Unsafe.js_expr();`                   |
| Create JS objects            | TODO              | TODO                                     |
| Access JS objects properties | `##`              | `##.`                                    |
| Nullable values              | `Js.nullable`     | `Js.Opt.t`                               |
