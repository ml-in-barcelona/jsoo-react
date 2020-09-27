[@@@js.stop]

type undefined

[@@@js.start]

[@@@js.implem
type undefined = Ojs.t

let undefined = Ojs.variable "undefined"

let undefined_to_js x = x

let undefined_of_js x = x]

val act : (unit -> unit) -> unit
  [@@js.custom
    val act : (unit -> undefined) -> unit
      [@@js.global "__LIB__reactDOMTestUtils.act"]

    let act f = act (fun () -> f () ; undefined)]
