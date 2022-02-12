(* [demo] *)
open React.Dom.Dsl
open Html

module Hello_message = struct
  let%component make ~name = div [||] [React.string ("Hello " ^ name)]
end

let () =
  React.Dom.render_to_element_with_id
    (Hello_message.make ~name:"Taylor" ())
    "hello-example"
(* [demo] *)