[@@@js.stop]

type domElement = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t

val domElement_to_js : domElement -> Ojs.t

val domElement_of_js : Ojs.t -> domElement

[@@@js.start]

[@@@js.implem
type domElement = Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t

external domElement_to_js : domElement -> Ojs.t = "%identity"

external domElement_of_js : Ojs.t -> domElement = "%identity"]

val unmountComponentAtNode : domElement -> bool
  [@@js.custom
    val unmountComponentAtNode_internal : Imports.reactDom -> domElement -> bool
      [@@js.call "unmountComponentAtNode"]

    let unmountComponentAtNode domElement =
      unmountComponentAtNode_internal Imports.reactDom domElement]

val render : Core.element -> domElement -> unit
  [@@js.custom
    val render_internal : Imports.reactDom -> Core.element -> domElement -> unit
      [@@js.call "render"]

    let render element domElement =
      render_internal Imports.reactDom element domElement]

val renderToElementWithId : Core.element -> string -> unit
  [@@js.custom
    val getElementById : string -> domElement option
      [@@js.global "document.getElementById"]

    let renderToElementWithId reactElement id =
      match getElementById id with
      | None ->
          raise
            (Invalid_argument
               ( "ReactDOM.renderToElementWithId : no element of id " ^ id
               ^ " found in the HTML." ) )
      | Some element ->
          render reactElement element]

type style

type domRef = private Ojs.t

module Ref : sig
  type t = domRef

  type currentDomRef = domElement Core.js_nullable Core.Ref.t

  type callbackDomRef = domElement Core.js_nullable -> unit

  [@@@js.stop]

  val domRef : currentDomRef -> domRef

  val callbackDomRef : callbackDomRef -> domRef

  [@@@js.start]

  [@@@js.implem
  external domRef : currentDomRef -> domRef = "%identity"

  external callbackDomRef : callbackDomRef -> domRef = "%identity"]
end

type domProps = private Ojs.t

val createDOMElementVariadic :
     string
  -> props:
       domProps
       (* props has to be non-optional as otherwise gen_js_api will put an empty list and React will break *)
  -> Core.element list
  -> Core.element
  [@@js.custom
    val createDOMElementVariadic_internal :
         Imports.react
      -> string
      -> props:domProps
      -> (Core.element list[@js.variadic])
      -> Core.element
      [@@js.call "createElement"]

    let createDOMElementVariadic typ ~props elts =
      createDOMElementVariadic_internal Imports.react typ ~props elts]

val forwardRef : ('props -> domRef -> Core.element) -> 'props Core.component
  [@@js.custom
    val forwardRef_internal :
         Imports.react
      -> ('props -> domRef -> Core.element)
      -> 'props Core.component
      [@@js.call "forwardRef"]

    let forwardRef renderFunc = forwardRef_internal Imports.react renderFunc]

module Style : sig
  [@@@js.stop]

  type style_key

  type t = style

  val make : style_key array -> style

  val azimuth : string -> style_key

  val background : string -> style_key

  val backgroundAttachment : string -> style_key

  val backgroundColor : string -> style_key

  val backgroundImage : string -> style_key

  val backgroundPosition : string -> style_key

  val backgroundRepeat : string -> style_key

  val border : string -> style_key

  val borderCollapse : string -> style_key

  val borderColor : string -> style_key

  val borderSpacing : string -> style_key

  val borderStyle : string -> style_key

  val borderTop : string -> style_key

  val borderRight : string -> style_key

  val borderBottom : string -> style_key

  val borderLeft : string -> style_key

  val borderTopColor : string -> style_key

  val borderRightColor : string -> style_key

  val borderBottomColor : string -> style_key

  val borderLeftColor : string -> style_key

  val borderTopStyle : string -> style_key

  val borderRightStyle : string -> style_key

  val borderBottomStyle : string -> style_key

  val borderLeftStyle : string -> style_key

  val borderTopWidth : string -> style_key

  val borderRightWidth : string -> style_key

  val borderBottomWidth : string -> style_key

  val borderLeftWidth : string -> style_key

  val borderWidth : string -> style_key

  val bottom : string -> style_key

  val captionSide : string -> style_key

  val clear : string -> style_key

  val clip : string -> style_key

  val color : string -> style_key

  val content : string -> style_key

  val counterIncrement : string -> style_key

  val counterReset : string -> style_key

  val cue : string -> style_key

  val cueAfter : string -> style_key

  val cueBefore : string -> style_key

  val cursor : string -> style_key

  val direction : string -> style_key

  val display : string -> style_key

  val elevation : string -> style_key

  val emptyCells : string -> style_key

  val float : string -> style_key

  val font : string -> style_key

  val fontFamily : string -> style_key

  val fontSize : string -> style_key

  val fontSizeAdjust : string -> style_key

  val fontStretch : string -> style_key

  val fontStyle : string -> style_key

  val fontVariant : string -> style_key

  val fontWeight : string -> style_key

  val height : string -> style_key

  val left : string -> style_key

  val letterSpacing : string -> style_key

  val lineHeight : string -> style_key

  val listStyle : string -> style_key

  val listStyleImage : string -> style_key

  val listStylePosition : string -> style_key

  val listStyleType : string -> style_key

  val margin : string -> style_key

  val marginTop : string -> style_key

  val marginRight : string -> style_key

  val marginBottom : string -> style_key

  val marginLeft : string -> style_key

  val markerOffset : string -> style_key

  val marks : string -> style_key

  val maxHeight : string -> style_key

  val maxWidth : string -> style_key

  val minHeight : string -> style_key

  val minWidth : string -> style_key

  val orphans : string -> style_key

  val outline : string -> style_key

  val outlineColor : string -> style_key

  val outlineStyle : string -> style_key

  val outlineWidth : string -> style_key

  val overflow : string -> style_key

  val overflowX : string -> style_key

  val overflowY : string -> style_key

  val padding : string -> style_key

  val paddingTop : string -> style_key

  val paddingRight : string -> style_key

  val paddingBottom : string -> style_key

  val paddingLeft : string -> style_key

  val page : string -> style_key

  val pageBreakAfter : string -> style_key

  val pageBreakBefore : string -> style_key

  val pageBreakInside : string -> style_key

  val pause : string -> style_key

  val pauseAfter : string -> style_key

  val pauseBefore : string -> style_key

  val pitch : string -> style_key

  val pitchRange : string -> style_key

  val playDuring : string -> style_key

  val position : string -> style_key

  val quotes : string -> style_key

  val richness : string -> style_key

  val right : string -> style_key

  val size : string -> style_key

  val speak : string -> style_key

  val speakHeader : string -> style_key

  val speakNumeral : string -> style_key

  val speakPunctuation : string -> style_key

  val speechRate : string -> style_key

  val stress : string -> style_key

  val tableLayout : string -> style_key

  val textAlign : string -> style_key

  val textDecoration : string -> style_key

  val textIndent : string -> style_key

  val textShadow : string -> style_key

  val textTransform : string -> style_key

  val top : string -> style_key

  val unicodeBidi : string -> style_key

  val verticalAlign : string -> style_key

  val visibility : string -> style_key

  val voiceFamily : string -> style_key

  val volume : string -> style_key

  val whiteSpace : string -> style_key

  val widows : string -> style_key

  val width : string -> style_key

  val wordSpacing : string -> style_key

  val zIndex : string -> style_key

  val opacity : string -> style_key

  val backgroundOrigin : string -> style_key

  val backgroundSize : string -> style_key

  val backgroundClip : string -> style_key

  val borderRadius : string -> style_key

  val borderTopLeftRadius : string -> style_key

  val borderTopRightRadius : string -> style_key

  val borderBottomLeftRadius : string -> style_key

  val borderBottomRightRadius : string -> style_key

  val borderImage : string -> style_key

  val borderImageSource : string -> style_key

  val borderImageSlice : string -> style_key

  val borderImageWidth : string -> style_key

  val borderImageOutset : string -> style_key

  val borderImageRepeat : string -> style_key

  val boxShadow : string -> style_key

  val columns : string -> style_key

  val columnCount : string -> style_key

  val columnFill : string -> style_key

  val columnGap : string -> style_key

  val columnRule : string -> style_key

  val columnRuleColor : string -> style_key

  val columnRuleStyle : string -> style_key

  val columnRuleWidth : string -> style_key

  val columnSpan : string -> style_key

  val columnWidth : string -> style_key

  val breakAfter : string -> style_key

  val breakBefore : string -> style_key

  val breakInside : string -> style_key

  val rest : string -> style_key

  val restAfter : string -> style_key

  val restBefore : string -> style_key

  val speakAs : string -> style_key

  val voiceBalance : string -> style_key

  val voiceDuration : string -> style_key

  val voicePitch : string -> style_key

  val voiceRange : string -> style_key

  val voiceRate : string -> style_key

  val voiceStress : string -> style_key

  val voiceVolume : string -> style_key

  val objectFit : string -> style_key

  val objectPosition : string -> style_key

  val imageResolution : string -> style_key

  val imageOrientation : string -> style_key

  val alignContent : string -> style_key

  val alignItems : string -> style_key

  val alignSelf : string -> style_key

  val flex : string -> style_key

  val flexBasis : string -> style_key

  val flexDirection : string -> style_key

  val flexFlow : string -> style_key

  val flexGrow : string -> style_key

  val flexShrink : string -> style_key

  val flexWrap : string -> style_key

  val justifyContent : string -> style_key

  val order : string -> style_key

  val textDecorationColor : string -> style_key

  val textDecorationLine : string -> style_key

  val textDecorationSkip : string -> style_key

  val textDecorationStyle : string -> style_key

  val textEmphasis : string -> style_key

  val textEmphasisColor : string -> style_key

  val textEmphasisPosition : string -> style_key

  val textEmphasisStyle : string -> style_key

  val textUnderlinePosition : string -> style_key

  val fontFeatureSettings : string -> style_key

  val fontKerning : string -> style_key

  val fontLanguageOverride : string -> style_key

  val fontSynthesis : string -> style_key

  val forntVariantAlternates : string -> style_key

  val fontVariantCaps : string -> style_key

  val fontVariantEastAsian : string -> style_key

  val fontVariantLigatures : string -> style_key

  val fontVariantNumeric : string -> style_key

  val fontVariantPosition : string -> style_key

  val all : string -> style_key

  val glyphOrientationVertical : string -> style_key

  val textCombineUpright : string -> style_key

  val textOrientation : string -> style_key

  val writingMode : string -> style_key

  val shapeImageThreshold : string -> style_key

  val shapeMargin : string -> style_key

  val shapeOutside : string -> style_key

  val clipPath : string -> style_key

  val clipRule : string -> style_key

  val mask : string -> style_key

  val maskBorder : string -> style_key

  val maskBorderMode : string -> style_key

  val maskBorderOutset : string -> style_key

  val maskBorderRepeat : string -> style_key

  val maskBorderSlice : string -> style_key

  val maskBorderSource : string -> style_key

  val maskBorderWidth : string -> style_key

  val maskClip : string -> style_key

  val maskComposite : string -> style_key

  val maskImage : string -> style_key

  val maskMode : string -> style_key

  val maskOrigin : string -> style_key

  val maskPosition : string -> style_key

  val maskRepeat : string -> style_key

  val maskSize : string -> style_key

  val maskType : string -> style_key

  val backgroundBlendMode : string -> style_key

  val isolation : string -> style_key

  val mixBlendMode : string -> style_key

  val boxDecorationBreak : string -> style_key

  val boxSizing : string -> style_key

  val caretColor : string -> style_key

  val navDown : string -> style_key

  val navLeft : string -> style_key

  val navRight : string -> style_key

  val navUp : string -> style_key

  val outlineOffset : string -> style_key

  val resize : string -> style_key

  val textOverflow : string -> style_key

  val grid : string -> style_key

  val gridArea : string -> style_key

  val gridAutoColumns : string -> style_key

  val gridAutoFlow : string -> style_key

  val gridAutoRows : string -> style_key

  val gridColumn : string -> style_key

  val gridColumnEnd : string -> style_key

  val gridColumnGap : string -> style_key

  val gridColumnStart : string -> style_key

  val gridGap : string -> style_key

  val gridRow : string -> style_key

  val gridRowEnd : string -> style_key

  val gridRowGap : string -> style_key

  val gridRowStart : string -> style_key

  val gridTemplate : string -> style_key

  val gridTemplateAreas : string -> style_key

  val gridTemplateColumns : string -> style_key

  val gridTemplateRows : string -> style_key

  val willChange : string -> style_key

  val hangingPunctuation : string -> style_key

  val hyphens : string -> style_key

  val lineBreak : string -> style_key

  val overflowWrap : string -> style_key

  val tabSize : string -> style_key

  val textAlignLast : string -> style_key

  val textJustify : string -> style_key

  val wordBreak : string -> style_key

  val wordWrap : string -> style_key

  val animation : string -> style_key

  val animationDelay : string -> style_key

  val animationDirection : string -> style_key

  val animationDuration : string -> style_key

  val animationFillMode : string -> style_key

  val animationIterationCount : string -> style_key

  val animationName : string -> style_key

  val animationPlayState : string -> style_key

  val animationTimingFunction : string -> style_key

  val transition : string -> style_key

  val transitionDelay : string -> style_key

  val transitionDuration : string -> style_key

  val transitionProperty : string -> style_key

  val transitionTimingFunction : string -> style_key

  val backfaceVisibility : string -> style_key

  val perspective : string -> style_key

  val perspectiveOrigin : string -> style_key

  val transform : string -> style_key

  val transformOrigin : string -> style_key

  val transformStyle : string -> style_key

  val justifyItems : string -> style_key

  val justifySelf : string -> style_key

  val placeContent : string -> style_key

  val placeItems : string -> style_key

  val placeSelf : string -> style_key

  val appearance : string -> style_key

  val caret : string -> style_key

  val caretAnimation : string -> style_key

  val caretShape : string -> style_key

  val userSelect : string -> style_key

  val maxLines : string -> style_key

  val marqueeDirection : string -> style_key

  val marqueeLoop : string -> style_key

  val marqueeSpeed : string -> style_key

  val marqueeStyle : string -> style_key

  val overflowStyle : string -> style_key

  val rotation : string -> style_key

  val rotationPoint : string -> style_key

  val alignmentBaseline : string -> style_key

  val baselineShift : string -> style_key

  val clip : string -> style_key

  val clipPath : string -> style_key

  val clipRule : string -> style_key

  val colorInterpolation : string -> style_key

  val colorInterpolationFilters : string -> style_key

  val colorProfile : string -> style_key

  val colorRendering : string -> style_key

  val cursor : string -> style_key

  val dominantBaseline : string -> style_key

  val fill : string -> style_key

  val fillOpacity : string -> style_key

  val fillRule : string -> style_key

  val filter : string -> style_key

  val floodColor : string -> style_key

  val floodOpacity : string -> style_key

  val glyphOrientationHorizontal : string -> style_key

  val glyphOrientationVertical : string -> style_key

  val imageRendering : string -> style_key

  val kerning : string -> style_key

  val lightingColor : string -> style_key

  val markerEnd : string -> style_key

  val markerMid : string -> style_key

  val markerStart : string -> style_key

  val pointerEvents : string -> style_key

  val shapeRendering : string -> style_key

  val stopColor : string -> style_key

  val stopOpacity : string -> style_key

  val stroke : string -> style_key

  val strokeDasharray : string -> style_key

  val strokeDashoffset : string -> style_key

  val strokeLinecap : string -> style_key

  val strokeLinejoin : string -> style_key

  val strokeMiterlimit : string -> style_key

  val strokeOpacity : string -> style_key

  val strokeWidth : string -> style_key

  val textAnchor : string -> style_key

  val textRendering : string -> style_key

  val rubyAlign : string -> style_key

  val rubyMerge : string -> style_key

  val rubyPosition : string -> style_key

  [@@@js.start]

  [@@@js.implem
  type style_key = string * Js_of_ocaml.Js.Unsafe.any

  type t = style

  let string_style_key key value =
    (key, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value))

  let make = Js_of_ocaml.Js.Unsafe.obj

  let azimuth = string_style_key "azimuth"

  let background = string_style_key "background"

  let backgroundAttachment = string_style_key "backgroundAttachment"

  let backgroundColor = string_style_key "backgroundColor"

  let backgroundImage = string_style_key "backgroundImage"

  let backgroundPosition = string_style_key "backgroundPosition"

  let backgroundRepeat = string_style_key "backgroundRepeat"

  let border = string_style_key "border"

  let borderCollapse = string_style_key "borderCollapse"

  let borderColor = string_style_key "borderColor"

  let borderSpacing = string_style_key "borderSpacing"

  let borderStyle = string_style_key "borderStyle"

  let borderTop = string_style_key "borderTop"

  let borderRight = string_style_key "borderRight"

  let borderBottom = string_style_key "borderBottom"

  let borderLeft = string_style_key "borderLeft"

  let borderTopColor = string_style_key "borderTopColor"

  let borderRightColor = string_style_key "borderRightColor"

  let borderBottomColor = string_style_key "borderBottomColor"

  let borderLeftColor = string_style_key "borderLeftColor"

  let borderTopStyle = string_style_key "borderTopStyle"

  let borderRightStyle = string_style_key "borderRightStyle"

  let borderBottomStyle = string_style_key "borderBottomStyle"

  let borderLeftStyle = string_style_key "borderLeftStyle"

  let borderTopWidth = string_style_key "borderTopWidth"

  let borderRightWidth = string_style_key "borderRightWidth"

  let borderBottomWidth = string_style_key "borderBottomWidth"

  let borderLeftWidth = string_style_key "borderLeftWidth"

  let borderWidth = string_style_key "borderWidth"

  let bottom = string_style_key "bottom"

  let captionSide = string_style_key "captionSide"

  let clear = string_style_key "clear"

  let clip = string_style_key "clip"

  let color = string_style_key "color"

  let content = string_style_key "content"

  let counterIncrement = string_style_key "counterIncrement"

  let counterReset = string_style_key "counterReset"

  let cue = string_style_key "cue"

  let cueAfter = string_style_key "cueAfter"

  let cueBefore = string_style_key "cueBefore"

  let cursor = string_style_key "cursor"

  let direction = string_style_key "direction"

  let display = string_style_key "display"

  let elevation = string_style_key "elevation"

  let emptyCells = string_style_key "emptyCells"

  let float = string_style_key "float"

  let font = string_style_key "font"

  let fontFamily = string_style_key "fontFamily"

  let fontSize = string_style_key "fontSize"

  let fontSizeAdjust = string_style_key "fontSizeAdjust"

  let fontStretch = string_style_key "fontStretch"

  let fontStyle = string_style_key "fontStyle"

  let fontVariant = string_style_key "fontVariant"

  let fontWeight = string_style_key "fontWeight"

  let height = string_style_key "height"

  let left = string_style_key "left"

  let letterSpacing = string_style_key "letterSpacing"

  let lineHeight = string_style_key "lineHeight"

  let listStyle = string_style_key "listStyle"

  let listStyleImage = string_style_key "listStyleImage"

  let listStylePosition = string_style_key "listStylePosition"

  let listStyleType = string_style_key "listStyleType"

  let margin = string_style_key "margin"

  let marginTop = string_style_key "marginTop"

  let marginRight = string_style_key "marginRight"

  let marginBottom = string_style_key "marginBottom"

  let marginLeft = string_style_key "marginLeft"

  let markerOffset = string_style_key "markerOffset"

  let marks = string_style_key "marks"

  let maxHeight = string_style_key "maxHeight"

  let maxWidth = string_style_key "maxWidth"

  let minHeight = string_style_key "minHeight"

  let minWidth = string_style_key "minWidth"

  let orphans = string_style_key "orphans"

  let outline = string_style_key "outline"

  let outlineColor = string_style_key "outlineColor"

  let outlineStyle = string_style_key "outlineStyle"

  let outlineWidth = string_style_key "outlineWidth"

  let overflow = string_style_key "overflow"

  let overflowX = string_style_key "overflowX"

  let overflowY = string_style_key "overflowY"

  let padding = string_style_key "padding"

  let paddingTop = string_style_key "paddingTop"

  let paddingRight = string_style_key "paddingRight"

  let paddingBottom = string_style_key "paddingBottom"

  let paddingLeft = string_style_key "paddingLeft"

  let page = string_style_key "page"

  let pageBreakAfter = string_style_key "pageBreakAfter"

  let pageBreakBefore = string_style_key "pageBreakBefore"

  let pageBreakInside = string_style_key "pageBreakInside"

  let pause = string_style_key "pause"

  let pauseAfter = string_style_key "pauseAfter"

  let pauseBefore = string_style_key "pauseBefore"

  let pitch = string_style_key "pitch"

  let pitchRange = string_style_key "pitchRange"

  let playDuring = string_style_key "playDuring"

  let position = string_style_key "position"

  let quotes = string_style_key "quotes"

  let richness = string_style_key "richness"

  let right = string_style_key "right"

  let size = string_style_key "size"

  let speak = string_style_key "speak"

  let speakHeader = string_style_key "speakHeader"

  let speakNumeral = string_style_key "speakNumeral"

  let speakPunctuation = string_style_key "speakPunctuation"

  let speechRate = string_style_key "speechRate"

  let stress = string_style_key "stress"

  let tableLayout = string_style_key "tableLayout"

  let textAlign = string_style_key "textAlign"

  let textDecoration = string_style_key "textDecoration"

  let textIndent = string_style_key "textIndent"

  let textShadow = string_style_key "textShadow"

  let textTransform = string_style_key "textTransform"

  let top = string_style_key "top"

  let unicodeBidi = string_style_key "unicodeBidi"

  let verticalAlign = string_style_key "verticalAlign"

  let visibility = string_style_key "visibility"

  let voiceFamily = string_style_key "voiceFamily"

  let volume = string_style_key "volume"

  let whiteSpace = string_style_key "whiteSpace"

  let widows = string_style_key "widows"

  let width = string_style_key "width"

  let wordSpacing = string_style_key "wordSpacing"

  let zIndex = string_style_key "zIndex"

  let opacity = string_style_key "opacity"

  let backgroundOrigin = string_style_key "backgroundOrigin"

  let backgroundSize = string_style_key "backgroundSize"

  let backgroundClip = string_style_key "backgroundClip"

  let borderRadius = string_style_key "borderRadius"

  let borderTopLeftRadius = string_style_key "borderTopLeftRadius"

  let borderTopRightRadius = string_style_key "borderTopRightRadius"

  let borderBottomLeftRadius = string_style_key "borderBottomLeftRadius"

  let borderBottomRightRadius = string_style_key "borderBottomRightRadius"

  let borderImage = string_style_key "borderImage"

  let borderImageSource = string_style_key "borderImageSource"

  let borderImageSlice = string_style_key "borderImageSlice"

  let borderImageWidth = string_style_key "borderImageWidth"

  let borderImageOutset = string_style_key "borderImageOutset"

  let borderImageRepeat = string_style_key "borderImageRepeat"

  let boxShadow = string_style_key "boxShadow"

  let columns = string_style_key "columns"

  let columnCount = string_style_key "columnCount"

  let columnFill = string_style_key "columnFill"

  let columnGap = string_style_key "columnGap"

  let columnRule = string_style_key "columnRule"

  let columnRuleColor = string_style_key "columnRuleColor"

  let columnRuleStyle = string_style_key "columnRuleStyle"

  let columnRuleWidth = string_style_key "columnRuleWidth"

  let columnSpan = string_style_key "columnSpan"

  let columnWidth = string_style_key "columnWidth"

  let breakAfter = string_style_key "breakAfter"

  let breakBefore = string_style_key "breakBefore"

  let breakInside = string_style_key "breakInside"

  let rest = string_style_key "rest"

  let restAfter = string_style_key "restAfter"

  let restBefore = string_style_key "restBefore"

  let speakAs = string_style_key "speakAs"

  let voiceBalance = string_style_key "voiceBalance"

  let voiceDuration = string_style_key "voiceDuration"

  let voicePitch = string_style_key "voicePitch"

  let voiceRange = string_style_key "voiceRange"

  let voiceRate = string_style_key "voiceRate"

  let voiceStress = string_style_key "voiceStress"

  let voiceVolume = string_style_key "voiceVolume"

  let objectFit = string_style_key "objectFit"

  let objectPosition = string_style_key "objectPosition"

  let imageResolution = string_style_key "imageResolution"

  let imageOrientation = string_style_key "imageOrientation"

  let alignContent = string_style_key "alignContent"

  let alignItems = string_style_key "alignItems"

  let alignSelf = string_style_key "alignSelf"

  let flex = string_style_key "flex"

  let flexBasis = string_style_key "flexBasis"

  let flexDirection = string_style_key "flexDirection"

  let flexFlow = string_style_key "flexFlow"

  let flexGrow = string_style_key "flexGrow"

  let flexShrink = string_style_key "flexShrink"

  let flexWrap = string_style_key "flexWrap"

  let justifyContent = string_style_key "justifyContent"

  let order = string_style_key "order"

  let textDecorationColor = string_style_key "textDecorationColor"

  let textDecorationLine = string_style_key "textDecorationLine"

  let textDecorationSkip = string_style_key "textDecorationSkip"

  let textDecorationStyle = string_style_key "textDecorationStyle"

  let textEmphasis = string_style_key "textEmphasis"

  let textEmphasisColor = string_style_key "textEmphasisColor"

  let textEmphasisPosition = string_style_key "textEmphasisPosition"

  let textEmphasisStyle = string_style_key "textEmphasisStyle"

  let textUnderlinePosition = string_style_key "textUnderlinePosition"

  let fontFeatureSettings = string_style_key "fontFeatureSettings"

  let fontKerning = string_style_key "fontKerning"

  let fontLanguageOverride = string_style_key "fontLanguageOverride"

  let fontSynthesis = string_style_key "fontSynthesis"

  let forntVariantAlternates = string_style_key "forntVariantAlternates"

  let fontVariantCaps = string_style_key "fontVariantCaps"

  let fontVariantEastAsian = string_style_key "fontVariantEastAsian"

  let fontVariantLigatures = string_style_key "fontVariantLigatures"

  let fontVariantNumeric = string_style_key "fontVariantNumeric"

  let fontVariantPosition = string_style_key "fontVariantPosition"

  let all = string_style_key "all"

  let glyphOrientationVertical = string_style_key "glyphOrientationVertical"

  let textCombineUpright = string_style_key "textCombineUpright"

  let textOrientation = string_style_key "textOrientation"

  let writingMode = string_style_key "writingMode"

  let shapeImageThreshold = string_style_key "shapeImageThreshold"

  let shapeMargin = string_style_key "shapeMargin"

  let shapeOutside = string_style_key "shapeOutside"

  let clipPath = string_style_key "clipPath"

  let clipRule = string_style_key "clipRule"

  let mask = string_style_key "mask"

  let maskBorder = string_style_key "maskBorder"

  let maskBorderMode = string_style_key "maskBorderMode"

  let maskBorderOutset = string_style_key "maskBorderOutset"

  let maskBorderRepeat = string_style_key "maskBorderRepeat"

  let maskBorderSlice = string_style_key "maskBorderSlice"

  let maskBorderSource = string_style_key "maskBorderSource"

  let maskBorderWidth = string_style_key "maskBorderWidth"

  let maskClip = string_style_key "maskClip"

  let maskComposite = string_style_key "maskComposite"

  let maskImage = string_style_key "maskImage"

  let maskMode = string_style_key "maskMode"

  let maskOrigin = string_style_key "maskOrigin"

  let maskPosition = string_style_key "maskPosition"

  let maskRepeat = string_style_key "maskRepeat"

  let maskSize = string_style_key "maskSize"

  let maskType = string_style_key "maskType"

  let backgroundBlendMode = string_style_key "backgroundBlendMode"

  let isolation = string_style_key "isolation"

  let mixBlendMode = string_style_key "mixBlendMode"

  let boxDecorationBreak = string_style_key "boxDecorationBreak"

  let boxSizing = string_style_key "boxSizing"

  let caretColor = string_style_key "caretColor"

  let navDown = string_style_key "navDown"

  let navLeft = string_style_key "navLeft"

  let navRight = string_style_key "navRight"

  let navUp = string_style_key "navUp"

  let outlineOffset = string_style_key "outlineOffset"

  let resize = string_style_key "resize"

  let textOverflow = string_style_key "textOverflow"

  let grid = string_style_key "grid"

  let gridArea = string_style_key "gridArea"

  let gridAutoColumns = string_style_key "gridAutoColumns"

  let gridAutoFlow = string_style_key "gridAutoFlow"

  let gridAutoRows = string_style_key "gridAutoRows"

  let gridColumn = string_style_key "gridColumn"

  let gridColumnEnd = string_style_key "gridColumnEnd"

  let gridColumnGap = string_style_key "gridColumnGap"

  let gridColumnStart = string_style_key "gridColumnStart"

  let gridGap = string_style_key "gridGap"

  let gridRow = string_style_key "gridRow"

  let gridRowEnd = string_style_key "gridRowEnd"

  let gridRowGap = string_style_key "gridRowGap"

  let gridRowStart = string_style_key "gridRowStart"

  let gridTemplate = string_style_key "gridTemplate"

  let gridTemplateAreas = string_style_key "gridTemplateAreas"

  let gridTemplateColumns = string_style_key "gridTemplateColumns"

  let gridTemplateRows = string_style_key "gridTemplateRows"

  let willChange = string_style_key "willChange"

  let hangingPunctuation = string_style_key "hangingPunctuation"

  let hyphens = string_style_key "hyphens"

  let lineBreak = string_style_key "lineBreak"

  let overflowWrap = string_style_key "overflowWrap"

  let tabSize = string_style_key "tabSize"

  let textAlignLast = string_style_key "textAlignLast"

  let textJustify = string_style_key "textJustify"

  let wordBreak = string_style_key "wordBreak"

  let wordWrap = string_style_key "wordWrap"

  let animation = string_style_key "animation"

  let animationDelay = string_style_key "animationDelay"

  let animationDirection = string_style_key "animationDirection"

  let animationDuration = string_style_key "animationDuration"

  let animationFillMode = string_style_key "animationFillMode"

  let animationIterationCount = string_style_key "animationIterationCount"

  let animationName = string_style_key "animationName"

  let animationPlayState = string_style_key "animationPlayState"

  let animationTimingFunction = string_style_key "animationTimingFunction"

  let transition = string_style_key "transition"

  let transitionDelay = string_style_key "transitionDelay"

  let transitionDuration = string_style_key "transitionDuration"

  let transitionProperty = string_style_key "transitionProperty"

  let transitionTimingFunction = string_style_key "transitionTimingFunction"

  let backfaceVisibility = string_style_key "backfaceVisibility"

  let perspective = string_style_key "perspective"

  let perspectiveOrigin = string_style_key "perspectiveOrigin"

  let transform = string_style_key "transform"

  let transformOrigin = string_style_key "transformOrigin"

  let transformStyle = string_style_key "transformStyle"

  let justifyItems = string_style_key "justifyItems"

  let justifySelf = string_style_key "justifySelf"

  let placeContent = string_style_key "placeContent"

  let placeItems = string_style_key "placeItems"

  let placeSelf = string_style_key "placeSelf"

  let appearance = string_style_key "appearance"

  let caret = string_style_key "caret"

  let caretAnimation = string_style_key "caretAnimation"

  let caretShape = string_style_key "caretShape"

  let userSelect = string_style_key "userSelect"

  let maxLines = string_style_key "maxLines"

  let marqueeDirection = string_style_key "marqueeDirection"

  let marqueeLoop = string_style_key "marqueeLoop"

  let marqueeSpeed = string_style_key "marqueeSpeed"

  let marqueeStyle = string_style_key "marqueeStyle"

  let overflowStyle = string_style_key "overflowStyle"

  let rotation = string_style_key "rotation"

  let rotationPoint = string_style_key "rotationPoint"

  let alignmentBaseline = string_style_key "alignmentBaseline"

  let baselineShift = string_style_key "baselineShift"

  let clip = string_style_key "clip"

  let clipPath = string_style_key "clipPath"

  let clipRule = string_style_key "clipRule"

  let colorInterpolation = string_style_key "colorInterpolation"

  let colorInterpolationFilters = string_style_key "colorInterpolationFilters"

  let colorProfile = string_style_key "colorProfile"

  let colorRendering = string_style_key "colorRendering"

  let cursor = string_style_key "cursor"

  let dominantBaseline = string_style_key "dominantBaseline"

  let fill = string_style_key "fill"

  let fillOpacity = string_style_key "fillOpacity"

  let fillRule = string_style_key "fillRule"

  let filter = string_style_key "filter"

  let floodColor = string_style_key "floodColor"

  let floodOpacity = string_style_key "floodOpacity"

  let glyphOrientationHorizontal = string_style_key "glyphOrientationHorizontal"

  let glyphOrientationVertical = string_style_key "glyphOrientationVertical"

  let imageRendering = string_style_key "imageRendering"

  let kerning = string_style_key "kerning"

  let lightingColor = string_style_key "lightingColor"

  let markerEnd = string_style_key "markerEnd"

  let markerMid = string_style_key "markerMid"

  let markerStart = string_style_key "markerStart"

  let pointerEvents = string_style_key "pointerEvents"

  let shapeRendering = string_style_key "shapeRendering"

  let stopColor = string_style_key "stopColor"

  let stopOpacity = string_style_key "stopOpacity"

  let stroke = string_style_key "stroke"

  let strokeDasharray = string_style_key "strokeDasharray"

  let strokeDashoffset = string_style_key "strokeDashoffset"

  let strokeLinecap = string_style_key "strokeLinecap"

  let strokeLinejoin = string_style_key "strokeLinejoin"

  let strokeMiterlimit = string_style_key "strokeMiterlimit"

  let strokeOpacity = string_style_key "strokeOpacity"

  let strokeWidth = string_style_key "strokeWidth"

  let textAnchor = string_style_key "textAnchor"

  let textRendering = string_style_key "textRendering"

  let rubyAlign = string_style_key "rubyAlign"

  let rubyMerge = string_style_key "rubyMerge"

  let rubyPosition = string_style_key "rubyPosition"]
end

module DangerouslySetInnerHTML : sig
  type t
end

val makeInnerHtml : __html:string -> DangerouslySetInnerHTML.t
  [@@js.builder] [@@js.verbatim_names]
