(** Utilities to handle routes changes in browser.
*)

val push : string -> unit
(** OCaml syntax: [push path].
     
    Reason syntax: [push(path)].

    Updates the url with the string in [path].

    Examples in OCaml syntax: [push "/book/1"], [push "/books#title")]. 

    Examples in Reason syntax: [push("/book/1")], [push("/books#title")]. *)

val replace : string -> unit
(** OCaml syntax: [replace path].
     
    Reason syntax: [replace(path)].

    Modifies the current history entry instead of creating a new one.

    Examples in OCaml syntax: [replace "/book/1"], [replace "/books#title")]. 

    Examples in Reason syntax: [replace("/book/1")], [replace("/books#title")]. *)

(** The type of the listener id that is created with {!watchUrl} and can be passed as input to {!unwatchUrl}. *)
type watcherID

type url =
  { path: string list
        (** [path] takes [window.location.path] (e.g. ["/book/title/edit"]) and turns it into [["book", "title", "edit"]]. *)
  ; hash: string  (** The url's hash, if any. The [#] symbol is stripped out. *)
  ; search: string
        (** The url's query params, if any. The [?] symbol is stripped out. *)
  }

val watchUrl : (url -> unit) -> watcherID
(** Starts watching for URL changes. Returns a listener id. Upon url change, calls the callback and passes it the url record. *)

val unwatchUrl : watcherID -> unit
(** Stops watching for URL changes. *)

val useUrl : ?serverUrl:url -> unit -> url
(** Hook for watching url changes.
  [serverUrl] is used for server side rendering. It allows you to specify the url without relying on browser apis existing/working as expected.
 *)
