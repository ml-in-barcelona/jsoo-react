# Quick start

## New project

For new projects, the best way to start is by cloning [the jsoo-react template](https://github.com/ml-in-barcelona/jsoo-react-template).

## Existing project

1. Install the `jsoo-react` package:

    ```bash
    opam pin add -y jsoo-react https://github.com/ml-in-barcelona/jsoo-react.git
    ```

2. Add `jsoo-react` library and ppx to [dune](https://dune.readthedocs.io/en/stable/) file of your executable JavaScript app:

    ```dune
    (executables
    (names index)
    (modes js)
    (libraries jsoo-react.lib)
    (preprocess
      (pps jsoo-react.ppx)))
    ```

3. Provision React.js library
    
    `jsoo-react` uses `require` to import React and ReactDOM. This means that you will likely need to use a bundler such as Webpack or rollup.js.

    Note that at this moment, `jsoo-react` is compatible with **React 16.x**, so be sure to have the appropriate constraints in your `package.json`.

