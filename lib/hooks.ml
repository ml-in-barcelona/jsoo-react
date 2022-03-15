let use_ref initial =
  let state, _ = Core.use_state (fun () -> ref initial) in
  state

let use_effect ~on ?(release = Fun.const ()) acquire =
  let last_value = use_ref on in
  let state = use_ref None in
  let release () = Option.iter release !state in
  let acquire () = state := Some (acquire ()) in
  Core.use_effect_once (fun () ->
      acquire ();
      Some release);
  Core.use_effect_always (fun () ->
      if on <> !last_value then (
        last_value := on;
        release ();
        acquire ());
      None)
