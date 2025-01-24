open Core

let aggregate_by_type ~(event : UserActivity.t) ~events =
  let rec aux (events : (Activity.t * int) list) =
    match events with
    | [] -> [ event.activity_type, 0 ]
    | (key, count) :: tail
      when String.equal (Activity.to_string key) (Activity.to_string event.activity_type)
      -> (key, count + 1) :: tail
    | pair :: tail -> pair :: aux tail
  in
  aux events
;;

let event_string ~count ~activity =
  let open Activity in
  match activity with
  | CommitCommentEvent -> sprintf "Added commit comment to  %d times" count
  | CreateEvent -> sprintf "User created repo  %d times" count
  | DeleteEvent -> sprintf "User deleted repo %d times" count
  | ForkEvent -> sprintf "Forked repo %d times" count
  | GollumEvent -> sprintf "Created/Updated wiki to %d times" count
  | IssueCommentEvent -> sprintf "Issue commented on %d times" count
  | IssuesEvent -> sprintf "Interacted with issues %d times" count
  | MemberEvent -> sprintf "Collaborated %d times" count
  | PublicEvent -> sprintf "Published repository %d times" count
  | PullRequestEvent -> sprintf "Created pull request  %d times" count
  | PullRequestReviewCommentEvent -> sprintf "Commented on pull request %d times" count
  | PullRequestReviewEvent -> sprintf "Reviewed pull request %d times" count
  | PushEvent -> sprintf "Pushed commit on %d times" count
  | ReleaseEvent -> sprintf "Release repo on %d times" count
  | SponsorshipEvent -> sprintf "Sponsorship on %d times" count
  | WatchEvent -> sprintf "Watched on %d times" count
;;

let join_with_newline s1 s2 = s1 ^ "\n" ^ s2

let make events : (Activity.t * int) list =
  List.fold events ~init:[] ~f:(fun acc event -> aggregate_by_type ~event ~events:acc)
;;

let print_summary data =
  Printf.printf "\n%s" "User activity summary:";
  make data
  |> List.fold ~init:"" ~f:(fun acc (activity, count) ->
    event_string ~count ~activity |> join_with_newline acc)
;;
