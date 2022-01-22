module Props = struct
  type t = string * Js_of_ocaml.Js.Unsafe.any

  let string_prop key value =
    (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value))

  let bool_prop key value =
    (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.bool value))

  let int_prop key (value : int) = (key, Js_of_ocaml.Js.Unsafe.inject value)

  let float_prop key (value : float) = (key, Js_of_ocaml.Js.Unsafe.inject value)

  let event_prop key (f : _ Event.synthetic -> unit) =
    (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.wrap_callback f))

  (* List of props dapted from rescript-react:
   * https://github.com/rescript-lang/rescript-react/blob/16dcbd8d079c7c20f3bd48fd677dfe7d70d0d020/src/ReactDOM.res#L51
   *)

  let key = string_prop "key"

  (* TODO: ref: domRef, *)

  (* react textarea/input *)

  let defaultChecked = bool_prop "defaultChecked"

  let defaultValue = string_prop "defaultValue"

  (* global html attributes *)

  let accessKey = string_prop "accessKey"

  let className = string_prop "className" (* substitute for "class" *)

  let contentEditable = bool_prop "contentEditable"

  let contextMenu = string_prop "contextMenu"

  let dir = string_prop "dir" (* "ltr", "rtl" or "auto" *)

  let draggable = bool_prop "draggable"

  let hidden = bool_prop "hidden"

  let id = string_prop "id"

  let lang = string_prop "lang"

  let role = string_prop "role" (* ARIA role *)

  (* TODO: style: style *)

  let spellCheck = bool_prop "spellCheck"

  let tabIndex = int_prop "tabIndex"

  let title = string_prop "title"

  (* html5 microdata *)

  let itemID = string_prop "itemID"

  let itemProp = string_prop "itemProp"

  let itemRef = string_prop "itemRef"

  let itemScope = bool_prop "itemScope"

  let itemType = string_prop "itemType" (* uri *)

  (* tag-specific html attributes *)

  let accept = string_prop "accept"

  let acceptCharset = string_prop "acceptCharset"

  let action = string_prop "action" (* uri *)

  let allowFullScreen = bool_prop "allowFullScreen"

  let alt = string_prop "alt"

  let async = bool_prop "async"

  let autoComplete = string_prop "autoComplete"
  (* has a fixed, but large-ish, set of possible values *)

  let autoCapitalize = string_prop "autoCapitalize" (* Mobile Safari specific *)

  let autoFocus = bool_prop "autoFocus"

  let autoPlay = bool_prop "autoPlay"

  let challenge = string_prop "challenge"

  let charSet = string_prop "charSet"

  let checked = bool_prop "checked"

  let cite = string_prop "cite" (* uri *)

  let crossOrigin = string_prop "crossOrigin" (* anonymous, use-credentials *)

  let cols = int_prop "cols"

  let colSpan = int_prop "colSpan"

  let content = string_prop "content"

  let controls = bool_prop "controls"

  let coords = string_prop "coords"
  (* set of values specifying the coordinates of a region *)

  let data = string_prop "data" (* uri *)

  let dateTime = string_prop "dateTime"
  (* "valid date string with optional time" *)

  let default = bool_prop "default"

  let defer = bool_prop "defer"

  let disabled = bool_prop "disabled"

  let download = string_prop "download"
  (* should really be either a boolean, signifying presence, or a string *)

  let encType = string_prop "encType"
  (* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" *)

  let form = string_prop "form"

  let formAction = string_prop "formAction" (* uri *)

  let formTarget = string_prop "formTarget" (* "_blank", "_self", etc. *)

  let formMethod = string_prop "formMethod" (* "post", "get", "put" *)

  let headers = string_prop "headers"

  let height = string_prop "height"
  (* in html5 this can only be a number, but in html4 it can ba a percentage as well *)

  let high = int_prop "high"

  let href = string_prop "href" (* uri *)

  let hrefLang = string_prop "hrefLang"

  let htmlFor = string_prop "htmlFor" (* substitute for "for" *)

  let httpEquiv = string_prop "httpEquiv"
  (* has a fixed set of possible values *)

  let icon = string_prop "icon" (* uri? *)

  let inputMode = string_prop "inputMode"
  (* "verbatim", "latin", "numeric", etc. *)

  let integrity = string_prop "integrity"

  let keyType = string_prop "keyType"

  let kind = string_prop "kind" (* has a fixed set of possible values *)

  let label = string_prop "label"

  let list = string_prop "list"

  let loop = bool_prop "loop"

  let low = int_prop "low"

  let manifest = string_prop "manifest" (* uri *)

  let max = string_prop "max" (* should be int or Js.Date.t *)

  let maxLength = int_prop "maxLength"

  let media = string_prop "media" (* a valid media query *)

  let mediaGroup = string_prop "mediaGroup"

  let method_ = string_prop "method" (* "post" or "get", reserved keyword *)

  let min = string_prop "min"

  let minLength = int_prop "minLength"

  let multiple = bool_prop "multiple"

  let muted = bool_prop "muted"

  let name = string_prop "name"

  let nonce = string_prop "nonce"

  let noValidate = bool_prop "noValidate"

  let open_ = bool_prop "open" (* reserved keyword *)

  let optimum = int_prop "optimum"

  let pattern = string_prop "pattern" (* valid Js RegExp *)

  let placeholder = string_prop "placeholder"

  let playsInline = bool_prop "playsInline"

  let poster = string_prop "poster" (* uri *)

  let preload = string_prop "preload"
  (* "none", "metadata" or "auto" (and "" as a synonym for "auto") *)

  let radioGroup = string_prop "radioGroup"

  let readOnly = bool_prop "readOnly"

  let rel = string_prop "rel"
  (* a space- or comma-separated (depending on the element) list of a fixed set of "link types" *)

  let required = bool_prop "required"

  let reversed = bool_prop "reversed"

  let rows = int_prop "rows"

  let rowSpan = int_prop "rowSpan"

  let sandbox = string_prop "sandbox" (* has a fixed set of possible values *)

  let scope = string_prop "scope" (* has a fixed set of possible values *)

  let scoped = bool_prop "scoped"

  let scrolling = string_prop "scrolling"
  (* html4 only, "auto", "yes" or "no" *)

  let selected = bool_prop "selected"

  let shape = string_prop "shape"

  let size = int_prop "size"

  let sizes = string_prop "sizes"

  let span = int_prop "span"

  let src = string_prop "src" (* uri *)

  let srcDoc = string_prop "srcDoc"

  let srcLang = string_prop "srcLang"

  let srcSet = string_prop "srcSet"

  let start = int_prop "start"

  let step = float_prop "step"

  let summary = string_prop "summary" (* deprecated *)

  let target = string_prop "target"

  let type_ = string_prop "type"
  (* has a fixed but large-ish set of possible values, reserved keyword *)

  let useMap = string_prop "useMap"

  let value = string_prop "value"

  let width = string_prop "width"
  (* in html5 this can only be a number, but in html4 it can ba a percentage as well *)

  let wrap = string_prop "wrap" (* "hard" or "soft" *)

  (* Clipboard events *)

  let onCopy = (event_prop "onCopy" : (Event.Clipboard.t -> unit) -> t)

  let onCut = (event_prop "onCut" : (Event.Clipboard.t -> unit) -> t)

  let onPaste = (event_prop "onPaste" : (Event.Clipboard.t -> unit) -> t)

  (* Composition events *)

  let onCompositionEnd =
    (event_prop "onCompositionEnd" : (Event.Composition.t -> unit) -> t)

  let onCompositionStart =
    (event_prop "onCompositionStart" : (Event.Composition.t -> unit) -> t)

  let onCompositionUpdate =
    (event_prop "onCompositionUpdate" : (Event.Composition.t -> unit) -> t)

  (* Keyboard events *)

  let onKeyDown = (event_prop "onKeyDown" : (Event.Keyboard.t -> unit) -> t)

  let onKeyPress = (event_prop "onKeyPress" : (Event.Keyboard.t -> unit) -> t)

  let onKeyUp = (event_prop "onKeyUp" : (Event.Keyboard.t -> unit) -> t)

  (* Focus events *)

  let onFocus = (event_prop "onFocus" : (Event.Focus.t -> unit) -> t)

  let onBlur = (event_prop "onBlur" : (Event.Focus.t -> unit) -> t)

  (* Form events *)

  let onChange = (event_prop "onChange" : (Event.Form.t -> unit) -> t)

  let onInput = (event_prop "onInput" : (Event.Form.t -> unit) -> t)

  let onSubmit = (event_prop "onSubmit" : (Event.Form.t -> unit) -> t)

  let onInvalid = (event_prop "onInvalid" : (Event.Form.t -> unit) -> t)

  (* Mouse events *)

  let onClick = (event_prop "onClick" : (Event.Mouse.t -> unit) -> t)

  let onContextMenu = (event_prop "onContextMenu" : (Event.Mouse.t -> unit) -> t)

  let onDoubleClick = (event_prop "onDoubleClick" : (Event.Mouse.t -> unit) -> t)

  let onDrag = (event_prop "onDrag" : (Event.Mouse.t -> unit) -> t)

  let onDragEnd = (event_prop "onDragEnd" : (Event.Mouse.t -> unit) -> t)

  let onDragEnter = (event_prop "onDragEnter" : (Event.Mouse.t -> unit) -> t)

  let onDragExit = (event_prop "onDragExit" : (Event.Mouse.t -> unit) -> t)

  let onDragLeave = (event_prop "onDragLeave" : (Event.Mouse.t -> unit) -> t)

  let onDragOver = (event_prop "onDragOver" : (Event.Mouse.t -> unit) -> t)

  let onDragStart = (event_prop "onDragStart" : (Event.Mouse.t -> unit) -> t)

  let onDrop = (event_prop "onDrop" : (Event.Mouse.t -> unit) -> t)

  let onMouseDown = (event_prop "onMouseDown" : (Event.Mouse.t -> unit) -> t)

  let onMouseEnter = (event_prop "onMouseEnter" : (Event.Mouse.t -> unit) -> t)

  let onMouseLeave = (event_prop "onMouseLeave" : (Event.Mouse.t -> unit) -> t)

  let onMouseMove = (event_prop "onMouseMove" : (Event.Mouse.t -> unit) -> t)

  let onMouseOut = (event_prop "onMouseOut" : (Event.Mouse.t -> unit) -> t)

  let onMouseOver = (event_prop "onMouseOver" : (Event.Mouse.t -> unit) -> t)

  let onMouseUp = (event_prop "onMouseUp" : (Event.Mouse.t -> unit) -> t)

  (* Selection events *)

  let onSelect = (event_prop "onSelect" : (Event.Selection.t -> unit) -> t)

  (* Touch events *)

  let onTouchCancel = (event_prop "onTouchCancel" : (Event.Touch.t -> unit) -> t)

  let onTouchEnd = (event_prop "onTouchEnd" : (Event.Touch.t -> unit) -> t)

  let onTouchMove = (event_prop "onTouchMove" : (Event.Touch.t -> unit) -> t)

  let onTouchStart = (event_prop "onTouchStart" : (Event.Touch.t -> unit) -> t)

  (* Pointer events *)

  let onPointerOver =
    (event_prop "onPointerOver" : (Event.Pointer.t -> unit) -> t)

  let onPointerEnter =
    (event_prop "onPointerEnter" : (Event.Pointer.t -> unit) -> t)

  let onPointerDown =
    (event_prop "onPointerDown" : (Event.Pointer.t -> unit) -> t)

  let onPointerMove =
    (event_prop "onPointerMove" : (Event.Pointer.t -> unit) -> t)

  let onPointerUp = (event_prop "onPointerUp" : (Event.Pointer.t -> unit) -> t)

  let onPointerCancel =
    (event_prop "onPointerCancel" : (Event.Pointer.t -> unit) -> t)

  let onPointerOut = (event_prop "onPointerOut" : (Event.Pointer.t -> unit) -> t)

  let onPointerLeave =
    (event_prop "onPointerLeave" : (Event.Pointer.t -> unit) -> t)

  let onGotPointerCapture =
    (event_prop "onGotPointerCapture" : (Event.Pointer.t -> unit) -> t)

  let onLostPointerCapture =
    (event_prop "onLostPointerCapture" : (Event.Pointer.t -> unit) -> t)

  (* UI events *)

  let onScroll = (event_prop "onScroll" : (Event.UI.t -> unit) -> t)

  (* Wheel events *)

  let onWheel = (event_prop "onWheel" : (Event.Wheel.t -> unit) -> t)

  (* Media events *)

  let onAbort = (event_prop "onAbort" : (Event.Media.t -> unit) -> t)

  let onCanPlay = (event_prop "onCanPlay" : (Event.Media.t -> unit) -> t)

  let onCanPlayThrough =
    (event_prop "onCanPlayThrough" : (Event.Media.t -> unit) -> t)

  let onDurationChange =
    (event_prop "onDurationChange" : (Event.Media.t -> unit) -> t)

  let onEmptied = (event_prop "onEmptied" : (Event.Media.t -> unit) -> t)

  let onEncrypetd = (event_prop "onEncrypetd" : (Event.Media.t -> unit) -> t)

  let onEnded = (event_prop "onEnded" : (Event.Media.t -> unit) -> t)

  let onError = (event_prop "onError" : (Event.Media.t -> unit) -> t)

  let onLoadedData = (event_prop "onLoadedData" : (Event.Media.t -> unit) -> t)

  let onLoadedMetadata =
    (event_prop "onLoadedMetadata" : (Event.Media.t -> unit) -> t)

  let onLoadStart = (event_prop "onLoadStart" : (Event.Media.t -> unit) -> t)

  let onPause = (event_prop "onPause" : (Event.Media.t -> unit) -> t)

  let onPlay = (event_prop "onPlay" : (Event.Media.t -> unit) -> t)

  let onPlaying = (event_prop "onPlaying" : (Event.Media.t -> unit) -> t)

  let onProgress = (event_prop "onProgress" : (Event.Media.t -> unit) -> t)

  let onRateChange = (event_prop "onRateChange" : (Event.Media.t -> unit) -> t)

  let onSeeked = (event_prop "onSeeked" : (Event.Media.t -> unit) -> t)

  let onSeeking = (event_prop "onSeeking" : (Event.Media.t -> unit) -> t)

  let onStalled = (event_prop "onStalled" : (Event.Media.t -> unit) -> t)

  let onSuspend = (event_prop "onSuspend" : (Event.Media.t -> unit) -> t)

  let onTimeUpdate = (event_prop "onTimeUpdate" : (Event.Media.t -> unit) -> t)

  let onVolumeChange =
    (event_prop "onVolumeChange" : (Event.Media.t -> unit) -> t)

  let onWaiting = (event_prop "onWaiting" : (Event.Media.t -> unit) -> t)

  (* Image events *)

  let onLoad =
    (event_prop "onLoad" (* duplicate *) : (Event.Image.t -> unit) -> t)

  (* Animation events *)

  let onAnimationStart =
    (event_prop "onAnimationStart" : (Event.Animation.t -> unit) -> t)

  let onAnimationEnd =
    (event_prop "onAnimationEnd" : (Event.Animation.t -> unit) -> t)

  let onAnimationIteration =
    (event_prop "onAnimationIteration" : (Event.Animation.t -> unit) -> t)

  (* Transition events *)

  let onTransitionEnd =
    (event_prop "onTransitionEnd" : (Event.Transition.t -> unit) -> t)

  (* react-specific *)

  (* TODO: dangerouslySetInnerHTML: {"__html": string} *)

  let suppressContentEditableWarning =
    bool_prop "suppressContentEditableWarning"
end

include Props

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

let fragment children = Core.Fragment.make ~children ()
let str = Core.string
let int = Core.int
let float = Core.float
