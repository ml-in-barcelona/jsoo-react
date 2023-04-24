# Contributing

## Getting started

- Install opam: https://opam.ocaml.org/doc/Install.html
- Create local switch by running `make init` (this step will take a few minutes, as it will build whole OCaml compiler)
- Build with `make build`
- Run tests with `make test`

It is recommended to run `git config --local core.hooksPath .githooks/` to make sure git hooks run,
otherwise you could get CI errors due to formatting.

## Ideas / decisions

- Abstract over Js_of_ocaml "native" types (`js_string `, `js_array`) as much as
possible behind the bindings. To do so, the library uses [`gen_js_api`](https://github.com/LexiFi/gen_js_api)
to convert from/to these types to their more idiomatic OCaml representation.
- Keep the API as close as possible to ReasonReact. This is useful for many reasons:
  - Battle tested.
  - Reduce cognitive load by leveraging ReasonReact knowledge.
  - Maximize potential reuse of existing components and libraries.

## Bindings

See [`interop.md`](interop.md).

## Running the example

```bash
git clone https://github.com/ml-in-barcelona/jsoo-react/
cd ./jsoo-react
make init
eval $(opam env)
make dev
# in another tab / terminal session 
cd ./jsoo-react/example
yarn && yarn server
```

After that, open up `localhost:8000`. Then modify `App.re` file in `src` and refresh the page to see the changes. The example
will not work without server as it relies on history / client-side routing using `jsoo-react` router to navigate through the pages.

### Ppx

- `make test` to run the test against the expected result.
- `make test-promote` when you want to update the expected results.
