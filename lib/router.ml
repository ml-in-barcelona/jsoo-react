(* Adapted from reason-react: https://reasonml.github.io/reason-react/docs/en/router *)

module Browser =
[%js:
type history

type window

val window_to_js : window -> Ojs.t

type location

val history : history option [@@js.global "history"]

val window : window option [@@js.global "window"]

val location : window -> location [@@js.get]

val pathname : location -> string [@@js.get]

val hash : location -> string [@@js.get]

val search : location -> string [@@js.get]

val pushState : history -> Ojs.t -> string -> href:string -> unit [@@js.call]

val replaceState : history -> Ojs.t -> string -> href:string -> unit [@@js.call]]

module Event =
[%js:
type t

val event : t [@@js.global "Event"]

val makeEventIE11Compatible : string -> t [@@js.new "Event"]

val createEventNonIEBrowsers : string -> t [@@js.global "document.createEvent"]

val initEventNonIEBrowsers : t -> string -> bool -> bool -> unit
  [@@js.call "initEvent"]

(* The cb is t => unit, but access is restricted for now *)
val addEventListener : Browser.window -> string -> (unit -> unit) -> unit
  [@@js.call]

val removeEventListener : Browser.window -> string -> (unit -> unit) -> unit
  [@@js.call]

val dispatchEvent : Browser.window -> t -> unit [@@js.call]]

let safeMakeEvent eventName =
  if
    let open Js_of_ocaml in
    Js.typeof (Js.Unsafe.inject Event.event) = Js.string "function"
  then Event.makeEventIE11Compatible eventName
  else
    let event = Event.createEventNonIEBrowsers "Event" in
    Event.initEventNonIEBrowsers event eventName true true ;
    Event.event

let sliceToEnd s =
  match s = "" with true -> "" | false -> String.sub s 1 (String.length s - 1)

(* if we ever roll our own parser in the future, make sure you test all url combinations
   e.g. foo.com/?#bar
*)
(* URLSearchParams doesn't work on IE11, edge16, etc. *)
(* The library doesn't provide search for now. Users can roll their own solution/data structure.*)
let path () =
  match Browser.window with
  | None ->
      []
  | Some w -> (
    match
      let open Browser in
      w |> location |> pathname
    with
    | "" | "/" ->
        []
    | raw ->
        let raw = sliceToEnd raw in
        let raw =
          let n = String.length raw in
          match n > 0 && raw.[n - 1] = '/' with
          | true ->
              String.sub raw 0 (n - 1)
          | false ->
              raw
        in
        raw |> String.split_on_char '/' )

let hash () =
  match Browser.window with
  | None ->
      ""
  | Some w -> (
    match
      let open Browser in
      w |> location |> hash
    with
    | "" | "#" ->
        ""
    | raw ->
        (* remove the preceeding #, which every hash seems to have. *)
        sliceToEnd raw )

let search () =
  match Browser.window with
  | None ->
      ""
  | Some w -> (
    match
      let open Browser in
      w |> location |> search
    with
    | "" | "?" ->
        ""
    | raw ->
        (* remove the preceeding ?, which every search seems to have. *)
        sliceToEnd raw )

let push path =
  match
    let open Browser in
    (history, window)
  with
  | None, _ | _, None ->
      ()
  | Some history, Some window ->
      Browser.pushState history Ojs.null "" ~href:path ;
      Event.dispatchEvent window (safeMakeEvent "popstate")

let replace path =
  match
    let open Browser in
    (history, window)
  with
  | None, _ | _, None ->
      ()
  | Some history, Some window ->
      Browser.replaceState history Ojs.null "" ~href:path ;
      Event.dispatchEvent window (safeMakeEvent "popstate")

type url = {path: string list; hash: string; search: string}

let urlNotEqual a b =
  let rec listNotEqual aList bList =
    match (aList, bList) with
    | [], [] ->
        false
    | [], _ :: _ | _ :: _, [] ->
        true
    | aHead :: aRest, bHead :: bRest ->
        if aHead != bHead then true else listNotEqual aRest bRest
  in
  a.hash != b.hash || a.search != b.search || listNotEqual a.path b.path

type watcherID = unit -> unit

let url () = {path= path (); hash= hash (); search= search ()}

(* alias exposed publicly *)
let dangerouslyGetInitialUrl = url

let watchUrl callback =
  match Browser.window with
  | None ->
      fun () -> ()
  | Some window ->
      let watcherID () = callback (url ()) in
      Event.addEventListener window "popstate" watcherID ;
      watcherID

let unwatchUrl watcherID =
  match Browser.window with
  | None ->
      ()
  | Some window ->
      Event.removeEventListener window "popstate" watcherID

let useUrl ?serverUrl () =
  let url, setUrl =
    Core.use_state (fun () ->
        match serverUrl with
        | Some url ->
            url
        | None ->
            dangerouslyGetInitialUrl () )
  in
  Core.use_effect0 (fun () ->
      let watcherId = watchUrl (fun url -> setUrl (fun _ -> url)) in
      (* check for updates that may have occured between the initial state and the subscribe above *)
      let newUrl = dangerouslyGetInitialUrl () in
      if urlNotEqual newUrl url then setUrl (fun _ -> newUrl) ;
      Some (fun () -> unwatchUrl watcherId) ) ;
  url
