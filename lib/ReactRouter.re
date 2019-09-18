/* Adapted from reason-react: https://reasonml.github.io/reason-react/docs/en/router */
module Browser: {
  type history;
  
  type window;
  let window_to_js: window => Ojs.t;

  type location;

  [@js.global "history"] let history: option(history);

  [@js.global "window"] let window: option(window);

  [@js.get] let location: window => location;
  [@js.get] let pathname: location => string;
  [@js.get] let hash: location => string;
  [@js.get] let search: location => string;

  [@js.call] let pushState: (history, Ojs.t, string, ~href: string) => unit;

  [@js.call] let replaceState: (history, Ojs.t, string, ~href: string) => unit;
} =
  [%js];

module Event: {

  type t;

  [@js.global "Event"] let event: t;

[@js.new "Event"] let makeEventIE11Compatible: string => t;

[@js.global "document.createEvent"]
let createEventNonIEBrowsers: string => t;

[@js.call "initEvent"] let initEventNonIEBrowsers: (t, string, bool, bool) => unit;

/* The cb is t => unit, but access is restricted for now */
[@js.call]
let addEventListener : (Browser.window, string, unit => unit) => unit;

[@js.call]
 let  removeEventListener: (Browser.window, string, unit => unit) => unit;

[@js.call]
let dispatchEvent: (Browser.window, t) => unit;
} =
  [%js];

let safeMakeEvent = eventName =>
  if (Js_of_ocaml.(Js.typeof(Js.Unsafe.inject(Event.event)) == Js.string("function"))) {
    Event.makeEventIE11Compatible(eventName);
  } else {
    let event = Event.createEventNonIEBrowsers("Event");
    Event.initEventNonIEBrowsers(event, eventName, true, true);
    Event.event;
  };

let sliceToEnd = s => s == "" ? "" : String.sub(s, 1, String.length(s) - 1);

/* if we ever roll our own parser in the future, make sure you test all url combinations
   e.g. foo.com/?#bar
   */
/* URLSearchParams doesn't work on IE11, edge16, etc. */
/* The library doesn't provide search for now. Users can roll their own solution/data structure.*/
let path = () =>
  switch (Browser.window) {
  | None => []
  | Some(w) =>
    switch (Browser.(w |> location |> pathname)) {
    | ""
    | "/" => []
    | raw =>
      /* remove the preceeding /, which every pathname seems to have */
      let raw = sliceToEnd(raw);

      /* remove the trailing /, which some pathnames might have. Ugh */
      let raw = {
        let n = String.length(raw);
        n > 0 && raw.[n - 1] == '/' ? String.sub(raw, 0, n - 1) : raw;
      };

      raw |> String.split_on_char('/');
    }
  };

let hash = () =>
  switch (Browser.window) {
  | None => ""
  | Some(w) =>
    switch (Browser.(w |> location |> hash)) {
    | ""
    | "#" => ""
    | raw =>
      /* remove the preceeding #, which every hash seems to have.
         Why is this even included in location.hash?? */
      sliceToEnd(raw)
    }
  };

let search = () =>
  switch (Browser.window) {
  | None => ""
  | Some(w) =>
    switch (Browser.(w |> location |> search)) {
    | ""
    | "?" => ""
    | raw =>
      /* remove the preceeding ?, which every search seems to have. */
      sliceToEnd(raw)
    }
  };

let push = path =>
  switch (Browser.(history, window)) {
  | (None, _)
  | (_, None) => ()
  | (Some(history), Some(window)) =>
    Browser.pushState(history, Ojs.null, "", ~href=path);
    Event.dispatchEvent(window, safeMakeEvent("popstate"));
  };

let replace = path =>
  switch (Browser.(history, window)) {
  | (None, _)
  | (_, None) => ()
  | (Some((history)), Some((window))) =>
    Browser.replaceState(history, Ojs.null, "", ~href=path);
    Event.dispatchEvent(window, safeMakeEvent("popstate"));
  };

type url = {
  path: list(string),
  hash: string,
  search: string,
};

let urlNotEqual = (a, b) => {
  let rec listNotEqual = (aList, bList) => {
    switch (aList, bList) {
    | ([], []) => false
    | ([], [_, ..._])
    | ([_, ..._], []) => true
    | ([aHead, ...aRest], [bHead, ...bRest]) =>
      if (aHead !== bHead) {
        true
      } else {
        listNotEqual(aRest, bRest)
      }
    }
  };
  a.hash !== b.hash || a.search !== b.search || listNotEqual(a.path, b.path)
}

type watcherID = unit => unit;

let url = () => {path: path(), hash: hash(), search: search()};
/* alias exposed publicly */
let dangerouslyGetInitialUrl = url;
let watchUrl = callback =>
  switch (Browser.window) {
  | None => (() => ())
  | Some((window)) =>
    let watcherID = () => callback(url());
    Event.addEventListener(window, "popstate", watcherID);
    watcherID;
  };
let unwatchUrl = watcherID =>
  switch (Browser.window) {
  | None => ()
  | Some((window)) =>
    Event.removeEventListener(window, "popstate", watcherID)
  };

let useUrl = (~serverUrl=?, ()) => {
  let (url, setUrl) =
    React.useState(() =>
      switch (serverUrl) {
      | Some(url) => url
      | None => dangerouslyGetInitialUrl()
      }
    );

  React.useEffect0(() => {
    let watcherId = watchUrl(url => setUrl(_ => url));

    /**
      * check for updates that may have occured between
      * the initial state and the subscribe above
      */
    let newUrl = dangerouslyGetInitialUrl();
    if (newUrl != url) {
      setUrl(_ => newUrl);
    };

    Some(() => unwatchUrl(watcherId));
  });

  url;
};
