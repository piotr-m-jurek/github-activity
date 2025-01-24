open Core

type t =
  | CommitCommentEvent
  | CreateEvent
  | DeleteEvent
  | ForkEvent
  | GollumEvent
  | IssueCommentEvent
  | IssuesEvent
  | MemberEvent
  | PublicEvent
  | PullRequestEvent
  | PullRequestReviewCommentEvent
  | PullRequestReviewEvent
  | PushEvent
  | ReleaseEvent
  | SponsorshipEvent
  | WatchEvent
[@@deriving yojson { strict = false }]

let of_yojson = function
  | `String "CommitCommentEvent" -> Ok CommitCommentEvent
  | `String "CreateEvent" -> Ok CreateEvent
  | `String "DeleteEvent" -> Ok DeleteEvent
  | `String "ForkEvent" -> Ok ForkEvent
  | `String "GollumEvent" -> Ok GollumEvent
  | `String "IssueCommentEvent" -> Ok IssueCommentEvent
  | `String "IssuesEvent" -> Ok IssuesEvent
  | `String "MemberEvent" -> Ok MemberEvent
  | `String "PublicEvent" -> Ok PublicEvent
  | `String "PullRequestEvent" -> Ok PullRequestEvent
  | `String "PullRequestReviewCommentEvent" -> Ok PullRequestReviewCommentEvent
  | `String "PullRequestReviewEvent" -> Ok PullRequestReviewEvent
  | `String "PushEvent" -> Ok PushEvent
  | `String "ReleaseEvent" -> Ok ReleaseEvent
  | `String "SponsorshipEvent" -> Ok SponsorshipEvent
  | `String "WatchEvent" -> Ok WatchEvent
  | x ->
    Printf.eprintf "\nError parsing activity_type: %s\n" (Yojson.Safe.to_string x);
    Error ("Unknown activity type: " ^ Yojson.Safe.to_string x)
;;

let to_string = function
  | CommitCommentEvent -> "CommitCommentEvent"
  | CreateEvent -> "CreateEvent"
  | DeleteEvent -> "DeleteEvent"
  | ForkEvent -> "ForkEvent"
  | GollumEvent -> "GollumEvent"
  | IssueCommentEvent -> "IssueCommentEvent"
  | IssuesEvent -> "IssuesEvent"
  | MemberEvent -> "MemberEvent"
  | PublicEvent -> "PublicEvent"
  | PullRequestEvent -> "PullRequestEvent"
  | PullRequestReviewCommentEvent -> "PullRequestReviewCommentEvent"
  | PullRequestReviewEvent -> "PullRequestReviewEvent"
  | PushEvent -> "PushEvent"
  | ReleaseEvent -> "ReleaseEvent"
  | SponsorshipEvent -> "SponsorshipEvent"
  | WatchEvent -> "WatchEvent"
;;
