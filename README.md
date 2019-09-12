# rroo

Bindings to ReactJS for js_of_ocaml, including JSX ppx.

Adapted from [ReasonReact](https://github.com/reasonml/reason-react/).

## A word of caution

:construction: :construction: :construction: :construction: 

Very experimental / early stage. Not ready for consumption yet.

Only bindings to the most basic rendering functions and `useState` / `useReducer` exist.
The rest of the bindings are to be implemented yet.

## Ideas / decisions

- Abstract over Js_of_ocaml "native" types (`js_string `, `js_array`) as much as
possible behind the bindings. To do so, the library uses [`gen_js_api`](https://github.com/LexiFi/gen_js_api)
to convert from/to these types to their more idiomatic OCaml representation.
- Keep the API as close as possible to ReasonReact. This is useful for many reasons:
  - Battle tested.
  - Reduce cognitive load by leveraging ReasonReact knowledge.
  - Maximize potential reuse of existing components and libraries.

## Bindings

See [`interop.md`](./interop.md).

## Running the example

```bash
git clone https://github.com/jchavarri/rroo/
cd example
esy
yarn && yarn webpack
```

After you see the webpack compilation succeed (the `yarn webpack` step), open up `example/build/index.html` (no server needed!). Then modify `App.re` file in `src` and refresh the page to see the changes.

## Run example with server

To run with the webpack development server run `yarn server` from the `example` folder and view in the browser at http://localhost:8000. Running in this environment provides hot reloading and support for routing; just edit and save the file and the browser will automatically refresh.

To use a port other than 8000 set the `PORT` environment variable (`PORT=8080 yarn server`).

### Ppx

- `esy test` to run the test against the expected result.
- `esy test:regen` to regenerate OCaml file `test.ml` from Reason file `test_src.re` (ocaml-migrate-parsetree drivers don't support input files with Reason syntax).
- `esy test:promote` to make

## Acknowledgements

Thanks to the authors and maintainers of ReasonReact, in particular @rickyvetter for his work on the v3 of the JSX ppx.
Thanks to the authors and maintainers of Js_of_ocaml, in particular @hhugo who has been answering many many questions in GitHub threads.
And thanks to the team behind React.js! What an amazing library :)
