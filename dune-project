(lang dune 2.7)

(name jsoo-react)

(license MIT)

(maintainers "Javier Chávarri <javier.chavarri@gmail.com>")

(authors "Javier Chávarri <javier.chavarri@gmail.com>")

(source
 (github ml-in-barcelona/jsoo-react))

(generate_opam_files true)

(implicit_transitive_deps false)

(package
 (name jsoo-react)
 (synopsis "Bindings to ReactJS for js_of_ocaml, including JSX ppx")
 (depends
  ;; General system dependencies
  (ocaml (>= 4.12.0))

  (js_of_ocaml (>= 4.0.0))
  (gen_js_api (and (>= 1.0.8) (< 1.2.0)))
  (ppxlib (>= 0.23.0))

  ;; Test dependencies
  (webtest :with-test)
  (webtest-js :with-test)
  (js_of_ocaml-ppx :with-test)
  (conf-npm :with-test)

  ;; Dev dependencies, using with-test so that consumers don't install them (until package is released in opam)
  (ocamlformat (and (= 0.21.0) :with-test))
  (reason (and (= 3.8.2) :with-test))

  ;; Example dependencies, using with-test so that consumers don't install them (until package is released in opam)
  (ppx_blob :with-test)
  (js_of_ocaml-lwt :with-test)
))
