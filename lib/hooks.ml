let use_ref initial =
  let state, _ = Core.use_state (fun () -> ref initial) in
  state

let use_ref_lazy init =
  let state, _ = Core.use_state (fun () -> ref (init ())) in
  state

let use_resource ~on:deps ?(equal = ( = )) ~release acquire =
  let last_deps = use_ref deps in
  let resource = use_ref None in

  let release () = Option.iter release !resource in
  let acquire () = resource := Some (acquire ()) in

  Core.use_effect_once (fun () ->
      acquire ();
      Some release);

  Core.use_effect_always (fun () ->
      if not (equal deps !last_deps) then (
        last_deps := deps;
        release ();
        acquire ());
      None)

let use_effect ~on ?equal ?(cleanup = fun () -> ()) f =
  use_resource ~on ?equal ~release:cleanup f

let use_memo ~on:deps ?(equal = ( = )) f =
  let last_deps = use_ref deps in
  let value = use_ref_lazy (fun () -> f ()) in

  if not (equal deps !last_deps) then begin
    last_deps := deps;
    value := f ()
  end;

  !value
