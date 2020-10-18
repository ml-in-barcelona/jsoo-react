(** This module is the entry point for the bindings library. It includes modules
  to specific functionality like {!Dom} or {!Event}.
  It also includes {{!React__.Core}Core} module, which provides the definitions to the most commonly
  used APIs like hooks, {!createElement} or {!Fragment}. *)

(** {1 Dom}*)

module Dom = Dom

(** {1 Event}*)

module Event = Event

(** {1 Router}*)

module Router = Router

(** {1 Core}*)

include module type of Core
