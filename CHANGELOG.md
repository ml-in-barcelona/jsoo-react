0.0.2 (unpublished)

- Updates the library to depend on OCaml 4.08
- Takes a new approach to bindings (explored in [`jsoo-is-sorted`](https://github.com/jchavarri/jsoo-is-sorted/)) which streamlines the dependency on JavaScript libraries like `react` and `react-dom` by injecting them in js_of_ocaml global scope, so the bindings can find them in any case, even if they are exposed as a library
- Uses `gen_js_api` and moves away from the `.js`-based approach, which was error prone and more boilerplaty. `gen_js_api` allows to declare the functions in regular interface files, and generates the "glue code" automatically behind the scenes.
- Updates the ppx code to make it compatible with latest OCaml AST types and also to make it compatible with requirements from gen_js_api (e.g. the conversion of `key` prop to `js_string` has to be handled now at the ppx level).

0.0.1 (unpublished)

- Initial version
