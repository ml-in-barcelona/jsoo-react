let use_effect ~on f =
  let last_value = Core.use_ref on in
  Core.use_effect_once (fun () -> f () ; None) ;
  Core.use_effect_always (fun () ->
      if on <> Core.Ref.current last_value then (
        Core.Ref.set_current last_value on ;
        f () ) ;
      None )
