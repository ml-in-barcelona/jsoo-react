## 0.1 (2023-04-06)

### What's Changed
* Add fragments and remove jsxv2 code from ppx by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/9
* Refs + fix for keys by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/11
* Bindings to useEffect Hook by @schinns in https://github.com/ml-in-barcelona/jsoo-react/pull/10
* Use pipe first for more ergonomic Lwt.bind calls by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/16
* Consolidate option libs and return unmount effects by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/17
* Fix forwardRef unsafety + make DOM refs types more idiomatic by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/19
* Eslint Config by @schinns in https://github.com/ml-in-barcelona/jsoo-react/pull/20
* Fix deep elements (<Foo.bar />) tests by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/21
* Use metaquot by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/22
* Fix example by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/24
* Upgrade to OCaml 4.08 + new bindings approach + gen_js_api by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/25
* Fix displayName so components names show properly in React devtools. by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/26
* Add example of autogenerated `code` element reading from file with ppx-blob by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/27
* changed dune lib name to jsoo_react_ppx by @idkjs in https://github.com/ml-in-barcelona/jsoo-react/pull/29
* Add more examples, add ReactEvent and domProps bindings by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/30
* fix example cd path by @naartjie in https://github.com/ml-in-barcelona/jsoo-react/pull/31
* Bump acorn from 6.3.0 to 6.4.1 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/33
* Fix build for dune 2, esy 0.6 and lwt 5 by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/35
* OCaml 4.10 + more by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/40
* Add ReactTestUtils, jsdom bindings, some initial tests for the bindings by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/41
* readme: minor fixes by @zindel in https://github.com/ml-in-barcelona/jsoo-react/pull/42
* Add memo and memoCustomCompareProps by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/44
* dune: remove `(wrapped false)` by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/45
* Allow consumers to decide how React is provided by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/48
* add ci by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/49
* Bump ini from 1.3.5 to 1.3.7 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/50
* Bump elliptic from 6.5.3 to 6.5.4 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/53
* Specify minimum on gen-js-api 1.0.7 by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/55
* Switch to ppxlib by @keremc in https://github.com/ml-in-barcelona/jsoo-react/pull/64
* CI: Update setup-ocaml to v2 by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/68
* Add pre-push hook to check formatting by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/70
* Inline props as object by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/66
* refactor: Rename createMarkup to makeInnerHtml by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/74
* Add 'help' command in Make by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/73
* Better support for OCaml syntax by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/72
* RFC: Better support for OCaml syntax by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/67
* Type-safe HTML and SVG tags by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/71
* fix: Ensure optionals are passed as undefineds by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/84
* Create a test case for capturing error messages at build(ppx)-time by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/87
* replace {dev} with :with-test by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/80
* Remove filtering of optional props in make_js_props_obj by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/89
* Update README.md by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/97
* refactor: require `react`, `react-dom` within OCaml by @zbaylin in https://github.com/ml-in-barcelona/jsoo-react/pull/96
* Keep useReducer dispatch and useState updater refs constant by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/101
* Allow `string option` transformations for native elements by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/92
* chore(deps): open jsoo constraint to 3.11.0 by @zbaylin in https://github.com/ml-in-barcelona/jsoo-react/pull/103
* fix build & test instructions in CONTRIBUTING by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/107
* Unify tests by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/108
* Remove React.list by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/102
* ppx: fix inexistent locations on comps that return element list by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/110
* style: use functions as style key creation mechanism by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/116
* chore(deps): bump follow-redirects from 1.14.5 to 1.14.7 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/114
* Bindings to external JS components by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/106
* fix: Add location on errors for invalid key/ref usage on props by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/118
* ppx: don't assume external components are functions by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/124
* ppx: fix external optional args by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/126
* PPX-less API for creating DOM elements and props. by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/119
* Wrong component type signature when using type annotation #85 by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/117
* PoC: automatic js ffi conversion of external props by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/127
* add Webcomponent example by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/129
* ppx: Remove @@@react.dom + transform lowercase elements to Dsl functions by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/128
* fix(ppx): Ensure we pass rec_flag on value_binding by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/133
* Help Merlin find ast nodes inside let%component by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/134
* ppx: fix bug on externals by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/135
* Convert API to snake case by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/138
* build(deps): bump follow-redirects from 1.14.7 to 1.14.8 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/140
* Docs: experiment with docsify by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/139
* Add ARIA 1.1 into global-attributes by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/145
* Add global_attributes into both html and svg Props. by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/144
* build(deps): bump url-parse from 1.5.3 to 1.5.7 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/148
* Experiment: more ergonomic/idiomatic API by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/141
* chore: bump js_of_ocaml to 4.0.0 by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/150
* build(deps): bump url-parse from 1.5.7 to 1.5.10 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/152
* consistent project-wide formatting by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/155
* ci: try to fix win by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/159
* dsl: fix react runtime warning when using maybe with None by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/156
* allow locally abstract type and type constraint on component definitions by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/151
* dsl: add classNames helper to Html and Svg props by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/157
* dom: add create_portal by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/158
* dsl: expose ARIA attributes by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/160
* Update ppxlib 0.26 ocamlformat 0.21 by @jchavarri in https://github.com/ml-in-barcelona/jsoo-react/pull/163
* Relax upper bounds to allow OCaml 4.14 and dune 3 by @sim642 in https://github.com/ml-in-barcelona/jsoo-react/pull/162
* build(deps): bump minimist from 1.2.5 to 1.2.6 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/161
* Hooks using OCaml idioms and equality semantics by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/154
* ppx: set display name on let%component by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/166
* A few ergonomic additions for dealing with conditional rendering by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/165
* dom: add missing svg props by @glennsl in https://github.com/ml-in-barcelona/jsoo-react/pull/164
* build(deps): bump async from 2.6.3 to 2.6.4 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/168
* chore(deps): relax `gen_js_api` constraint to allow ^1.1.0 by @zbaylin in https://github.com/ml-in-barcelona/jsoo-react/pull/167
* Add bindings to StrictMode by @schinns in https://github.com/ml-in-barcelona/jsoo-react/pull/169
* build(deps): bump decode-uri-component from 0.2.0 to 0.2.2 in /example by @dependabot in https://github.com/ml-in-barcelona/jsoo-react/pull/172
* OPAM: upgrade Js_of_ocaml to 5.1.0 by @zbaylin in https://github.com/ml-in-barcelona/jsoo-react/pull/177
* Prefix Option and Array with Stdlib by @davesnx in https://github.com/ml-in-barcelona/jsoo-react/pull/178

### New Contributors
* @jchavarri made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/9
* @schinns made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/10
* @idkjs made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/29
* @naartjie made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/31
* @dependabot made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/33
* @zindel made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/42
* @davesnx made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/55
* @keremc made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/64
* @zbaylin made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/96
* @glennsl made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/107
* @sim642 made their first contribution in https://github.com/ml-in-barcelona/jsoo-react/pull/162

**Full Changelog**: https://github.com/ml-in-barcelona/jsoo-react/commits/0.1