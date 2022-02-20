(* [demo] *)
open React.Dom.Dsl
open Html

module Hello_message = struct
  let%component make ~name = div [||] [React.string ("Hello " ^ name)]
end

let () =
  React.Dom.render_to_element ~id:"hello-example"
    (Hello_message.make ~name:"Taylor" ())
(* [demo] *)
