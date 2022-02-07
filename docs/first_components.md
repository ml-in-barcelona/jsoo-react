# Your first components

## A simple component

Jsoo-react components are functions that take input data and returns what to display. The library provides a DSL that allows to create elements like `div`, or `p` with just plain OCaml functions. The uppercase component props are passed as labelled arguments, while lowercase components take an array of attributes.

[filename](snippets/basic.ml ':include :type=code :fragment=demo')
