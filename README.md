# rroo

Bindings to ReactJS for js_of_ocaml, including JSX ppx.

Adapted from [ReasonReact](https://github.com/reasonml/reason-react/).

## A word of caution

:construction: :construction: :construction: :construction: 

Very experimental / early stage. Not ready for consumption yet.

There are only bindings to the most basic rendering functions and `useState` / `useReducer`.
The rest of the bindings are to be implemented yet.

## Ideas / decisions

- Hide Js_of_ocaml native types as much as possible behind the bindings.
- Implement bindings as pure OCaml `external` statements, avoid custom `Js.` functions as much as possible to reduce cognitive load.
- Keep the API as close as possible to ReasonReact. This is useful for many reasons:
  - Battle tested.
  - Reduce cognitive load by leveraging ReasonReact knowledge.
  - Maximize potential reuse of existing components and libraries.

## Bindings

See [`interop.md`](./interop.md).

## Installation

```bash
git clone https://github.com/jchavarri/rroo/
cd lib && yarn # gets react and react-dom
cd ..
esy
```

Open `bin/index.html`.


### Production bundle

Run `esy build:prod`

### Ppx

- `esy test` to run the test against the expected result.
- `esy test:regen` to regenerate OCaml file `test.ml` from Reason file `test_src.re` (ocaml-migrate-parsetree drivers don't support input files with Reason syntax).
- `esy test:promote` to make

### `Uncaught TypeError: Cannot set property 'React' of undefined`

To fix this error, go to `lib/node_modules/react/umd/react.development.js` and remove the `use strict` at the top.
Do the same with `lib/node_modules/react-dom/umd/react-dom.development.js`.
Then run `esy` again and open / reload `bin/index.html`.

**More context:** Due to the way jsoo wraps the linked JavaScript files, combined with the usage of `use strict` by React, leads to this problem because it's not possible to reference the window object through `this` inside a strict mode function.

To get around this issue, the `react` package is being downloaded manually as seen above, and bundled by Js_of_ocaml. 

This is very nasty, but things will hopefully get better. There is one big piece missing before being able to "just run `esy`", which is the update to the latest PnP standard (see [tracking issue](https://github.com/esy/esy/issues/930)).

Once esy updates to latest PnP, package management can be entirely be done with esy, and bundling with any JavaScript bundler (like Webpack).

## Acknowledgements

Thanks to the authors and maintainers of ReasonReact, in particular @rickyvetter for his work on the v3 of the JSX ppx.
Thanks to the authors and maintainers of Js_of_ocaml, in particular @hhugo who has been answering many many questions in GitHub threads.
And thanks to the team behind ReactJS! What an amazing library :)
