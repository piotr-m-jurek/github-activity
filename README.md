# github-activity

Project made for learning path from [Roadmap][https://roadmap.sh]

Apologies for one commit. Took me not so long time, didn't commit in the meantime.

## Caveats

One point that I changed from roadmap's description in my implementation is:

> Do not use any external libraries or frameworks to build this project.

OCaml tends to be the language where, if you don't write your own standard library, you are not really programming.
Therefore I settled on using
- [yojson](https://github.com/ocaml-community/yojson) for parsing JSON file
- [core](https://opensource.janestreet.com/core/) standard library from Jane Street
- [lwt](https://github.com/ocsigen/lwt) for promises and concurrency

## Installation

Make sure you have OCaml installed on your machine [Instructions](https://ocaml.org/install)

Install deps:
```sh
opam install --deps-only --yes .
```

Build project:

```sh
opam exec -- dune build
```

Run:
```sh
opam exec -- dune exec github_user_activity piotr-m-jurek
```

