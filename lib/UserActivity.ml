open Core

type actor =
  { id : int
  ; display_login : string
  ; avatar_url : string
  }
[@@deriving yojson { strict = false }]

type repo = { name : string } [@@deriving yojson { strict = false }]

type t =
  { id : string
  ; activity_type : Activity.t [@key "type"]
  ; actor : actor
  ; repo : repo
  }
[@@deriving yojson { strict = false }]

type events = t list [@@deriving yojson { strict = false }]

let handle_user_not_found username =
  Printf.eprintf "\n User not found: %s" username;
  exit 1
;;

let handle_failed_to_fetch () =
  Printf.eprintf "\nFailed to fetch data";
  exit 1
;;

let fetch ~(username : string) ~(url : string) =
  let open Lwt.Syntax in
  let uri = Uri.of_string url in
  let* resp, data = Cohttp_lwt_unix.Client.get uri in
  let* body_string = data |> Cohttp_lwt.Body.to_string in
  let status = resp |> Cohttp_lwt_unix.Response.status in
  (* INFO: Write all data to the file, for debugging purposes *)
  Out_channel.write_all "output.json" ~data:body_string;
  let handle =
    match status with
    | `OK ->
      (match Cohttp.Code.code_of_status status with
       | 200 -> body_string
       | 404 -> handle_user_not_found username
       | _ -> handle_failed_to_fetch ())
    | _ -> handle_failed_to_fetch ()
  in
  Lwt.return handle
;;
