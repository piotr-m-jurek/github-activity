open Core

type t =
  { count : int
  ; repo : string
  }

let aggregate_by_type ~(event : UserActivity.t) ~events =
  let rec aux (events : (Activity.t * t) list) =
    match events with
    | [] -> [ event.activity_type, { count = 0; repo = event.repo.name } ]
    | (key, data) :: tail
      when String.equal (Activity.to_string key) (Activity.to_string event.activity_type)
      -> (key, { data with count = data.count + 1 }) :: tail
    | pair :: tail -> pair :: aux tail
  in
  aux events
;;

let event_string ~data:{ count; repo } ~activity =
  let open Activity in
  match activity with
  | CommitCommentEvent ->
    sprintf "User added Commit comment to repo %s %d times" repo count
  | CreateEvent -> sprintf "User created repo %s %d times" repo count
  | DeleteEvent -> sprintf "User deleted repo %s %d times" repo count
  | ForkEvent -> sprintf "Forked repo %s %d times" repo count
  | GollumEvent -> sprintf "User added GollumEvent to repo %s %d times" repo count
  | IssueCommentEvent -> sprintf "Issue commented on repo %s %d times" repo count
  | IssuesEvent -> sprintf "IssuesEvent on repo %s %d times" repo count
  | MemberEvent -> sprintf "MemberEvent on repo %s %d times" repo count
  | PublicEvent -> sprintf "PublicEvent on repo %s %d times" repo count
  | PullRequestEvent -> sprintf "PullRequestEvent on repo %s %d times" repo count
  | PullRequestReviewCommentEvent ->
    sprintf "PullRequestReviewCommentEvent on repo %s %d times" repo count
  | PullRequestReviewEvent -> sprintf "PullRequestReviewEvent"
  | PushEvent -> sprintf "PushEvent on repo %s %d times" repo count
  | ReleaseEvent -> sprintf "ReleaseEvent on repo %s %d times" repo count
  | SponsorshipEvent -> sprintf "SponsorshipEvent on repo %s %d times" repo count
  | WatchEvent -> sprintf "WatchEvent on repo %s %d times" repo count
;;

let join_with_newline s1 s2 = s1 ^ "\n" ^ s2

let make (events : UserActivity.events) : (Activity.t * t) list =
  List.fold events ~init:[] ~f:(fun acc event -> aggregate_by_type ~event ~events:acc)
;;

let print_summary data =
  Printf.printf "\n%s" "User activity summary:\n\n";
  make data
  |> List.fold ~init:"" ~f:(fun acc (activity, data) ->
    event_string ~data ~activity |> join_with_newline acc)
;;
