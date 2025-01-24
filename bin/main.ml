open Core
open Github_user_activity

let () =
  let args = Sys.get_argv () in
  try
    let username = Array.get args 1 in
    let url = Printf.sprintf "https://api.github.com/users/%s/events" username in
    let body = Lwt_main.run @@ UserActivity.fetch ~username ~url in
    let json = Yojson.Safe.from_string body in
    match UserActivity.events_of_yojson json with
    | Ok events -> Printf.printf "\n%s" @@ AggregatedData.print_summary events
    | Error x ->
      Printf.eprintf "\nError parsing json: \n %s" x;
      ()
  with
  | Invalid_argument _ ->
    Printf.eprintf "\nNo User Provided\n    Please provide a username as an argument\n"
  | e -> Printf.eprintf "\nError: %s\n" (Exn.to_string e)
;;
