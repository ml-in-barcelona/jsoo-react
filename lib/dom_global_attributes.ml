include Dom_dsl_core.Prop

let accessKey = string "accessKey"

let className = string "className" (* substitute for "class" *)

let contentEditable = bool "contentEditable"

let contextMenu = string "contextMenu"

let dir = string "dir" (* "ltr", "rtl" or "auto" *)

let draggable = bool "draggable"

let hidden = bool "hidden"

let id = string "id"

let lang = string "lang"

let role = string "role" (* ARIA role *)

let style = (any "style" : Dom.Style.t -> t)

let spellCheck = bool "spellCheck"

let tabIndex = int "tabIndex"

let title = string "title"
