(lang dune 3.16)

(name github_user_activity)

(generate_opam_files true)

(source
 (github piotr-m-jurek/github-user-activity))

(authors "Piotr Malecki-Jurek")

(maintainers "Piotr Malecki-Jurek")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name github_user_activity)
 (synopsis "not empty synopsis")
 (description "")
 (depends
   ocaml
   dune
   core
   lwt
   cohttp-lwt-unix
   yojson
   ocamlformat
   ppx_deriving_yojson
   )
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
