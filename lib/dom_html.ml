module Props = struct
  let string_prop key value =
    (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value))

  let href = string_prop "href"

  let target = string_prop "target"

  let className = string_prop "className"
end

include Props

module Fragment = struct
  include Core.Fragment

  let make children = make ~children ()
end

let h name props children =
  Dom.createDOMElementVariadic name
    ~props:(Js_of_ocaml.Js.Unsafe.obj props)
    children

(* Elements *)

let a = h "a"

let abbr = h "abbr"

let address = h "address"

let area = h "area"

let article = h "article"

let aside = h "aside"

let audio = h "audio"

let b = h "b"

let base = h "base"

let bdi = h "bdi"

let bdo = h "bdo"

let big = h "big"

let blockquote = h "blockquote"

let body = h "body"

let br = h "br"

let button = h "button"

let canvas = h "canvas"

let caption = h "caption"

let cite = h "cite"

let code = h "code"

let col = h "col"

let colgroup = h "colgroup"

let data = h "data"

let datalist = h "datalist"

let dd = h "dd"

let del = h "del"

let details = h "details"

let dfn = h "dfn"

let dialog = h "dialog"

let div = h "div"

let dl = h "dl"

let dt = h "dt"

let em = h "em"

let embed = h "embed"

let fieldset = h "fieldset"

let figcaption = h "figcaption"

let figure = h "figure"

let footer = h "footer"

let form = h "form"

let h1 = h "h1"

let h2 = h "h2"

let h3 = h "h3"

let h4 = h "h4"

let h5 = h "h5"

let h6 = h "h6"

let head = h "head"

let header = h "header"

let hr = h "hr"

let html = h "html"

let i = h "i"

let iframe = h "iframe"

let img = h "img"

let input = h "input"

let ins = h "ins"

let kbd = h "kbd"

let keygen = h "keygen"

let label = h "label"

let legend = h "legend"

let li = h "li"

let link = h "link"

let main = h "main"

let map = h "map"

let mark = h "mark"

let menu = h "menu"

let menuitem = h "menuitem"

let meta = h "meta"

let meter = h "meter"

let nav = h "nav"

let noscript = h "noscript"

let object_ = h "object" (* reserved keyword *)

let ol = h "ol"

let optgroup = h "optgroup"

let option = h "option"

let output = h "output"

let p = h "p"

let param = h "param"

let picture = h "picture"

let pre = h "pre"

let progress = h "progress"

let q = h "q"

let rp = h "rp"

let rt = h "rt"

let ruby = h "ruby"

let s = h "s"

let samp = h "samp"

let script = h "script"

let section = h "section"

let select = h "select"

let small = h "small"

let source = h "source"

let span = h "span"

let strong = h "strong"

let style = h "style"

let sub = h "sub"

let summary = h "summary"

let sup = h "sup"

let table = h "table"

let tbody = h "tbody"

let td = h "td"

let textarea = h "textarea"

let tfoot = h "tfoot"

let th = h "th"

let thead = h "thead"

let time = h "time"

let title = h "title"

let tr = h "tr"

let track = h "track"

let u = h "u"

let ul = h "ul"

let var = h "var"

let video = h "video"

let wbr = h "wbr"

(* Convenience functions *)

let text = Core.string
