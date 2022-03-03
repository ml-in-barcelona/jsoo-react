let use_ref initial =
  let state, _ = Core.use_state (fun () -> ref initial) in
  state

let use_effect ~on f =
  let last_value = use_ref on in
  Core.use_effect_once (fun () -> f () ; None) ;
  Core.use_effect_always (fun () ->
      if on <> !last_value then (
        last_value := on ;
        f () ) ;
      None )
