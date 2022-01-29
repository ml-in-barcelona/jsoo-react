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

type block

module Style : sig
  [@@@js.stop]

  type decl

  type t = block

  val make : decl array -> block

  val azimuth : string -> decl

  val background : string -> decl

  val backgroundAttachment : string -> decl

  val backgroundColor : string -> decl

  val backgroundImage : string -> decl

  val backgroundPosition : string -> decl

  val backgroundRepeat : string -> decl

  val border : string -> decl

  val borderCollapse : string -> decl

  val borderColor : string -> decl

  val borderSpacing : string -> decl

  val borderStyle : string -> decl

  val borderTop : string -> decl

  val borderRight : string -> decl

  val borderBottom : string -> decl

  val borderLeft : string -> decl

  val borderTopColor : string -> decl

  val borderRightColor : string -> decl

  val borderBottomColor : string -> decl

  val borderLeftColor : string -> decl

  val borderTopStyle : string -> decl

  val borderRightStyle : string -> decl

  val borderBottomStyle : string -> decl

  val borderLeftStyle : string -> decl

  val borderTopWidth : string -> decl

  val borderRightWidth : string -> decl

  val borderBottomWidth : string -> decl

  val borderLeftWidth : string -> decl

  val borderWidth : string -> decl

  val bottom : string -> decl

  val captionSide : string -> decl

  val clear : string -> decl

  val color : string -> decl

  val content : string -> decl

  val counterIncrement : string -> decl

  val counterReset : string -> decl

  val cue : string -> decl

  val cueAfter : string -> decl

  val cueBefore : string -> decl

  val direction : string -> decl

  val display : string -> decl

  val elevation : string -> decl

  val emptyCells : string -> decl

  val float : string -> decl

  val font : string -> decl

  val fontFamily : string -> decl

  val fontSize : string -> decl

  val fontSizeAdjust : string -> decl

  val fontStretch : string -> decl

  val fontStyle : string -> decl

  val fontVariant : string -> decl

  val fontWeight : string -> decl

  val height : string -> decl

  val left : string -> decl

  val letterSpacing : string -> decl

  val lineHeight : string -> decl

  val listStyle : string -> decl

  val listStyleImage : string -> decl

  val listStylePosition : string -> decl

  val listStyleType : string -> decl

  val margin : string -> decl

  val marginTop : string -> decl

  val marginRight : string -> decl

  val marginBottom : string -> decl

  val marginLeft : string -> decl

  val markerOffset : string -> decl

  val marks : string -> decl

  val maxHeight : string -> decl

  val maxWidth : string -> decl

  val minHeight : string -> decl

  val minWidth : string -> decl

  val orphans : string -> decl

  val outline : string -> decl

  val outlineColor : string -> decl

  val outlineStyle : string -> decl

  val outlineWidth : string -> decl

  val overflow : string -> decl

  val overflowX : string -> decl

  val overflowY : string -> decl

  val padding : string -> decl

  val paddingTop : string -> decl

  val paddingRight : string -> decl

  val paddingBottom : string -> decl

  val paddingLeft : string -> decl

  val page : string -> decl

  val pageBreakAfter : string -> decl

  val pageBreakBefore : string -> decl

  val pageBreakInside : string -> decl

  val pause : string -> decl

  val pauseAfter : string -> decl

  val pauseBefore : string -> decl

  val pitch : string -> decl

  val pitchRange : string -> decl

  val playDuring : string -> decl

  val position : string -> decl

  val quotes : string -> decl

  val richness : string -> decl

  val right : string -> decl

  val size : string -> decl

  val speak : string -> decl

  val speakHeader : string -> decl

  val speakNumeral : string -> decl

  val speakPunctuation : string -> decl

  val speechRate : string -> decl

  val stress : string -> decl

  val tableLayout : string -> decl

  val textAlign : string -> decl

  val textDecoration : string -> decl

  val textIndent : string -> decl

  val textShadow : string -> decl

  val textTransform : string -> decl

  val top : string -> decl

  val unicodeBidi : string -> decl

  val verticalAlign : string -> decl

  val visibility : string -> decl

  val voiceFamily : string -> decl

  val volume : string -> decl

  val whiteSpace : string -> decl

  val widows : string -> decl

  val width : string -> decl

  val wordSpacing : string -> decl

  val zIndex : string -> decl

  val opacity : string -> decl

  val backgroundOrigin : string -> decl

  val backgroundSize : string -> decl

  val backgroundClip : string -> decl

  val borderRadius : string -> decl

  val borderTopLeftRadius : string -> decl

  val borderTopRightRadius : string -> decl

  val borderBottomLeftRadius : string -> decl

  val borderBottomRightRadius : string -> decl

  val borderImage : string -> decl

  val borderImageSource : string -> decl

  val borderImageSlice : string -> decl

  val borderImageWidth : string -> decl

  val borderImageOutset : string -> decl

  val borderImageRepeat : string -> decl

  val boxShadow : string -> decl

  val columns : string -> decl

  val columnCount : string -> decl

  val columnFill : string -> decl

  val columnGap : string -> decl

  val columnRule : string -> decl

  val columnRuleColor : string -> decl

  val columnRuleStyle : string -> decl

  val columnRuleWidth : string -> decl

  val columnSpan : string -> decl

  val columnWidth : string -> decl

  val breakAfter : string -> decl

  val breakBefore : string -> decl

  val breakInside : string -> decl

  val rest : string -> decl

  val restAfter : string -> decl

  val restBefore : string -> decl

  val speakAs : string -> decl

  val voiceBalance : string -> decl

  val voiceDuration : string -> decl

  val voicePitch : string -> decl

  val voiceRange : string -> decl

  val voiceRate : string -> decl

  val voiceStress : string -> decl

  val voiceVolume : string -> decl

  val objectFit : string -> decl

  val objectPosition : string -> decl

  val imageResolution : string -> decl

  val imageOrientation : string -> decl

  val alignContent : string -> decl

  val alignItems : string -> decl

  val alignSelf : string -> decl

  val flex : string -> decl

  val flexBasis : string -> decl

  val flexDirection : string -> decl

  val flexFlow : string -> decl

  val flexGrow : string -> decl

  val flexShrink : string -> decl

  val flexWrap : string -> decl

  val justifyContent : string -> decl

  val order : string -> decl

  val textDecorationColor : string -> decl

  val textDecorationLine : string -> decl

  val textDecorationSkip : string -> decl

  val textDecorationStyle : string -> decl

  val textEmphasis : string -> decl

  val textEmphasisColor : string -> decl

  val textEmphasisPosition : string -> decl

  val textEmphasisStyle : string -> decl

  val textUnderlinePosition : string -> decl

  val fontFeatureSettings : string -> decl

  val fontKerning : string -> decl

  val fontLanguageOverride : string -> decl

  val fontSynthesis : string -> decl

  val forntVariantAlternates : string -> decl

  val fontVariantCaps : string -> decl

  val fontVariantEastAsian : string -> decl

  val fontVariantLigatures : string -> decl

  val fontVariantNumeric : string -> decl

  val fontVariantPosition : string -> decl

  val all : string -> decl

  val textCombineUpright : string -> decl

  val textOrientation : string -> decl

  val writingMode : string -> decl

  val shapeImageThreshold : string -> decl

  val shapeMargin : string -> decl

  val shapeOutside : string -> decl

  val mask : string -> decl

  val maskBorder : string -> decl

  val maskBorderMode : string -> decl

  val maskBorderOutset : string -> decl

  val maskBorderRepeat : string -> decl

  val maskBorderSlice : string -> decl

  val maskBorderSource : string -> decl

  val maskBorderWidth : string -> decl

  val maskClip : string -> decl

  val maskComposite : string -> decl

  val maskImage : string -> decl

  val maskMode : string -> decl

  val maskOrigin : string -> decl

  val maskPosition : string -> decl

  val maskRepeat : string -> decl

  val maskSize : string -> decl

  val maskType : string -> decl

  val backgroundBlendMode : string -> decl

  val isolation : string -> decl

  val mixBlendMode : string -> decl

  val boxDecorationBreak : string -> decl

  val boxSizing : string -> decl

  val caretColor : string -> decl

  val navDown : string -> decl

  val navLeft : string -> decl

  val navRight : string -> decl

  val navUp : string -> decl

  val outlineOffset : string -> decl

  val resize : string -> decl

  val textOverflow : string -> decl

  val grid : string -> decl

  val gridArea : string -> decl

  val gridAutoColumns : string -> decl

  val gridAutoFlow : string -> decl

  val gridAutoRows : string -> decl

  val gridColumn : string -> decl

  val gridColumnEnd : string -> decl

  val gridColumnGap : string -> decl

  val gridColumnStart : string -> decl

  val gridGap : string -> decl

  val gridRow : string -> decl

  val gridRowEnd : string -> decl

  val gridRowGap : string -> decl

  val gridRowStart : string -> decl

  val gridTemplate : string -> decl

  val gridTemplateAreas : string -> decl

  val gridTemplateColumns : string -> decl

  val gridTemplateRows : string -> decl

  val willChange : string -> decl

  val hangingPunctuation : string -> decl

  val hyphens : string -> decl

  val lineBreak : string -> decl

  val overflowWrap : string -> decl

  val tabSize : string -> decl

  val textAlignLast : string -> decl

  val textJustify : string -> decl

  val wordBreak : string -> decl

  val wordWrap : string -> decl

  val animation : string -> decl

  val animationDelay : string -> decl

  val animationDirection : string -> decl

  val animationDuration : string -> decl

  val animationFillMode : string -> decl

  val animationIterationCount : string -> decl

  val animationName : string -> decl

  val animationPlayState : string -> decl

  val animationTimingFunction : string -> decl

  val transition : string -> decl

  val transitionDelay : string -> decl

  val transitionDuration : string -> decl

  val transitionProperty : string -> decl

  val transitionTimingFunction : string -> decl

  val backfaceVisibility : string -> decl

  val perspective : string -> decl

  val perspectiveOrigin : string -> decl

  val transform : string -> decl

  val transformOrigin : string -> decl

  val transformStyle : string -> decl

  val justifyItems : string -> decl

  val justifySelf : string -> decl

  val placeContent : string -> decl

  val placeItems : string -> decl

  val placeSelf : string -> decl

  val appearance : string -> decl

  val caret : string -> decl

  val caretAnimation : string -> decl

  val caretShape : string -> decl

  val userSelect : string -> decl

  val maxLines : string -> decl

  val marqueeDirection : string -> decl

  val marqueeLoop : string -> decl

  val marqueeSpeed : string -> decl

  val marqueeStyle : string -> decl

  val overflowStyle : string -> decl

  val rotation : string -> decl

  val rotationPoint : string -> decl

  val alignmentBaseline : string -> decl

  val baselineShift : string -> decl

  val clip : string -> decl

  val clipPath : string -> decl

  val clipRule : string -> decl

  val colorInterpolation : string -> decl

  val colorInterpolationFilters : string -> decl

  val colorProfile : string -> decl

  val colorRendering : string -> decl

  val cursor : string -> decl

  val dominantBaseline : string -> decl

  val fill : string -> decl

  val fillOpacity : string -> decl

  val fillRule : string -> decl

  val filter : string -> decl

  val floodColor : string -> decl

  val floodOpacity : string -> decl

  val glyphOrientationHorizontal : string -> decl

  val glyphOrientationVertical : string -> decl

  val imageRendering : string -> decl

  val kerning : string -> decl

  val lightingColor : string -> decl

  val markerEnd : string -> decl

  val markerMid : string -> decl

  val markerStart : string -> decl

  val pointerEvents : string -> decl

  val shapeRendering : string -> decl

  val stopColor : string -> decl

  val stopOpacity : string -> decl

  val stroke : string -> decl

  val strokeDasharray : string -> decl

  val strokeDashoffset : string -> decl

  val strokeLinecap : string -> decl

  val strokeLinejoin : string -> decl

  val strokeMiterlimit : string -> decl

  val strokeOpacity : string -> decl

  val strokeWidth : string -> decl

  val textAnchor : string -> decl

  val textRendering : string -> decl

  val rubyAlign : string -> decl

  val rubyMerge : string -> decl

  val rubyPosition : string -> decl

  [@@@js.start]

  [@@@js.implem
  type decl = string * Js_of_ocaml.Js.Unsafe.any

  type t = block

  let string_style_prop property value =
    (property, Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value))

  let make = Js_of_ocaml.Js.Unsafe.obj

  let azimuth = string_style_prop "azimuth"

  let background = string_style_prop "background"

  let backgroundAttachment = string_style_prop "backgroundAttachment"

  let backgroundColor = string_style_prop "backgroundColor"

  let backgroundImage = string_style_prop "backgroundImage"

  let backgroundPosition = string_style_prop "backgroundPosition"

  let backgroundRepeat = string_style_prop "backgroundRepeat"

  let border = string_style_prop "border"

  let borderCollapse = string_style_prop "borderCollapse"

  let borderColor = string_style_prop "borderColor"

  let borderSpacing = string_style_prop "borderSpacing"

  let borderStyle = string_style_prop "borderStyle"

  let borderTop = string_style_prop "borderTop"

  let borderRight = string_style_prop "borderRight"

  let borderBottom = string_style_prop "borderBottom"

  let borderLeft = string_style_prop "borderLeft"

  let borderTopColor = string_style_prop "borderTopColor"

  let borderRightColor = string_style_prop "borderRightColor"

  let borderBottomColor = string_style_prop "borderBottomColor"

  let borderLeftColor = string_style_prop "borderLeftColor"

  let borderTopStyle = string_style_prop "borderTopStyle"

  let borderRightStyle = string_style_prop "borderRightStyle"

  let borderBottomStyle = string_style_prop "borderBottomStyle"

  let borderLeftStyle = string_style_prop "borderLeftStyle"

  let borderTopWidth = string_style_prop "borderTopWidth"

  let borderRightWidth = string_style_prop "borderRightWidth"

  let borderBottomWidth = string_style_prop "borderBottomWidth"

  let borderLeftWidth = string_style_prop "borderLeftWidth"

  let borderWidth = string_style_prop "borderWidth"

  let bottom = string_style_prop "bottom"

  let captionSide = string_style_prop "captionSide"

  let clear = string_style_prop "clear"

  let clip = string_style_prop "clip"

  let color = string_style_prop "color"

  let content = string_style_prop "content"

  let counterIncrement = string_style_prop "counterIncrement"

  let counterReset = string_style_prop "counterReset"

  let cue = string_style_prop "cue"

  let cueAfter = string_style_prop "cueAfter"

  let cueBefore = string_style_prop "cueBefore"

  let cursor = string_style_prop "cursor"

  let direction = string_style_prop "direction"

  let display = string_style_prop "display"

  let elevation = string_style_prop "elevation"

  let emptyCells = string_style_prop "emptyCells"

  let float = string_style_prop "float"

  let font = string_style_prop "font"

  let fontFamily = string_style_prop "fontFamily"

  let fontSize = string_style_prop "fontSize"

  let fontSizeAdjust = string_style_prop "fontSizeAdjust"

  let fontStretch = string_style_prop "fontStretch"

  let fontStyle = string_style_prop "fontStyle"

  let fontVariant = string_style_prop "fontVariant"

  let fontWeight = string_style_prop "fontWeight"

  let height = string_style_prop "height"

  let left = string_style_prop "left"

  let letterSpacing = string_style_prop "letterSpacing"

  let lineHeight = string_style_prop "lineHeight"

  let listStyle = string_style_prop "listStyle"

  let listStyleImage = string_style_prop "listStyleImage"

  let listStylePosition = string_style_prop "listStylePosition"

  let listStyleType = string_style_prop "listStyleType"

  let margin = string_style_prop "margin"

  let marginTop = string_style_prop "marginTop"

  let marginRight = string_style_prop "marginRight"

  let marginBottom = string_style_prop "marginBottom"

  let marginLeft = string_style_prop "marginLeft"

  let markerOffset = string_style_prop "markerOffset"

  let marks = string_style_prop "marks"

  let maxHeight = string_style_prop "maxHeight"

  let maxWidth = string_style_prop "maxWidth"

  let minHeight = string_style_prop "minHeight"

  let minWidth = string_style_prop "minWidth"

  let orphans = string_style_prop "orphans"

  let outline = string_style_prop "outline"

  let outlineColor = string_style_prop "outlineColor"

  let outlineStyle = string_style_prop "outlineStyle"

  let outlineWidth = string_style_prop "outlineWidth"

  let overflow = string_style_prop "overflow"

  let overflowX = string_style_prop "overflowX"

  let overflowY = string_style_prop "overflowY"

  let padding = string_style_prop "padding"

  let paddingTop = string_style_prop "paddingTop"

  let paddingRight = string_style_prop "paddingRight"

  let paddingBottom = string_style_prop "paddingBottom"

  let paddingLeft = string_style_prop "paddingLeft"

  let page = string_style_prop "page"

  let pageBreakAfter = string_style_prop "pageBreakAfter"

  let pageBreakBefore = string_style_prop "pageBreakBefore"

  let pageBreakInside = string_style_prop "pageBreakInside"

  let pause = string_style_prop "pause"

  let pauseAfter = string_style_prop "pauseAfter"

  let pauseBefore = string_style_prop "pauseBefore"

  let pitch = string_style_prop "pitch"

  let pitchRange = string_style_prop "pitchRange"

  let playDuring = string_style_prop "playDuring"

  let position = string_style_prop "position"

  let quotes = string_style_prop "quotes"

  let richness = string_style_prop "richness"

  let right = string_style_prop "right"

  let size = string_style_prop "size"

  let speak = string_style_prop "speak"

  let speakHeader = string_style_prop "speakHeader"

  let speakNumeral = string_style_prop "speakNumeral"

  let speakPunctuation = string_style_prop "speakPunctuation"

  let speechRate = string_style_prop "speechRate"

  let stress = string_style_prop "stress"

  let tableLayout = string_style_prop "tableLayout"

  let textAlign = string_style_prop "textAlign"

  let textDecoration = string_style_prop "textDecoration"

  let textIndent = string_style_prop "textIndent"

  let textShadow = string_style_prop "textShadow"

  let textTransform = string_style_prop "textTransform"

  let top = string_style_prop "top"

  let unicodeBidi = string_style_prop "unicodeBidi"

  let verticalAlign = string_style_prop "verticalAlign"

  let visibility = string_style_prop "visibility"

  let voiceFamily = string_style_prop "voiceFamily"

  let volume = string_style_prop "volume"

  let whiteSpace = string_style_prop "whiteSpace"

  let widows = string_style_prop "widows"

  let width = string_style_prop "width"

  let wordSpacing = string_style_prop "wordSpacing"

  let zIndex = string_style_prop "zIndex"

  let opacity = string_style_prop "opacity"

  let backgroundOrigin = string_style_prop "backgroundOrigin"

  let backgroundSize = string_style_prop "backgroundSize"

  let backgroundClip = string_style_prop "backgroundClip"

  let borderRadius = string_style_prop "borderRadius"

  let borderTopLeftRadius = string_style_prop "borderTopLeftRadius"

  let borderTopRightRadius = string_style_prop "borderTopRightRadius"

  let borderBottomLeftRadius = string_style_prop "borderBottomLeftRadius"

  let borderBottomRightRadius = string_style_prop "borderBottomRightRadius"

  let borderImage = string_style_prop "borderImage"

  let borderImageSource = string_style_prop "borderImageSource"

  let borderImageSlice = string_style_prop "borderImageSlice"

  let borderImageWidth = string_style_prop "borderImageWidth"

  let borderImageOutset = string_style_prop "borderImageOutset"

  let borderImageRepeat = string_style_prop "borderImageRepeat"

  let boxShadow = string_style_prop "boxShadow"

  let columns = string_style_prop "columns"

  let columnCount = string_style_prop "columnCount"

  let columnFill = string_style_prop "columnFill"

  let columnGap = string_style_prop "columnGap"

  let columnRule = string_style_prop "columnRule"

  let columnRuleColor = string_style_prop "columnRuleColor"

  let columnRuleStyle = string_style_prop "columnRuleStyle"

  let columnRuleWidth = string_style_prop "columnRuleWidth"

  let columnSpan = string_style_prop "columnSpan"

  let columnWidth = string_style_prop "columnWidth"

  let breakAfter = string_style_prop "breakAfter"

  let breakBefore = string_style_prop "breakBefore"

  let breakInside = string_style_prop "breakInside"

  let rest = string_style_prop "rest"

  let restAfter = string_style_prop "restAfter"

  let restBefore = string_style_prop "restBefore"

  let speakAs = string_style_prop "speakAs"

  let voiceBalance = string_style_prop "voiceBalance"

  let voiceDuration = string_style_prop "voiceDuration"

  let voicePitch = string_style_prop "voicePitch"

  let voiceRange = string_style_prop "voiceRange"

  let voiceRate = string_style_prop "voiceRate"

  let voiceStress = string_style_prop "voiceStress"

  let voiceVolume = string_style_prop "voiceVolume"

  let objectFit = string_style_prop "objectFit"

  let objectPosition = string_style_prop "objectPosition"

  let imageResolution = string_style_prop "imageResolution"

  let imageOrientation = string_style_prop "imageOrientation"

  let alignContent = string_style_prop "alignContent"

  let alignItems = string_style_prop "alignItems"

  let alignSelf = string_style_prop "alignSelf"

  let flex = string_style_prop "flex"

  let flexBasis = string_style_prop "flexBasis"

  let flexDirection = string_style_prop "flexDirection"

  let flexFlow = string_style_prop "flexFlow"

  let flexGrow = string_style_prop "flexGrow"

  let flexShrink = string_style_prop "flexShrink"

  let flexWrap = string_style_prop "flexWrap"

  let justifyContent = string_style_prop "justifyContent"

  let order = string_style_prop "order"

  let textDecorationColor = string_style_prop "textDecorationColor"

  let textDecorationLine = string_style_prop "textDecorationLine"

  let textDecorationSkip = string_style_prop "textDecorationSkip"

  let textDecorationStyle = string_style_prop "textDecorationStyle"

  let textEmphasis = string_style_prop "textEmphasis"

  let textEmphasisColor = string_style_prop "textEmphasisColor"

  let textEmphasisPosition = string_style_prop "textEmphasisPosition"

  let textEmphasisStyle = string_style_prop "textEmphasisStyle"

  let textUnderlinePosition = string_style_prop "textUnderlinePosition"

  let fontFeatureSettings = string_style_prop "fontFeatureSettings"

  let fontKerning = string_style_prop "fontKerning"

  let fontLanguageOverride = string_style_prop "fontLanguageOverride"

  let fontSynthesis = string_style_prop "fontSynthesis"

  let forntVariantAlternates = string_style_prop "forntVariantAlternates"

  let fontVariantCaps = string_style_prop "fontVariantCaps"

  let fontVariantEastAsian = string_style_prop "fontVariantEastAsian"

  let fontVariantLigatures = string_style_prop "fontVariantLigatures"

  let fontVariantNumeric = string_style_prop "fontVariantNumeric"

  let fontVariantPosition = string_style_prop "fontVariantPosition"

  let all = string_style_prop "all"

  let glyphOrientationVertical = string_style_prop "glyphOrientationVertical"

  let textCombineUpright = string_style_prop "textCombineUpright"

  let textOrientation = string_style_prop "textOrientation"

  let writingMode = string_style_prop "writingMode"

  let shapeImageThreshold = string_style_prop "shapeImageThreshold"

  let shapeMargin = string_style_prop "shapeMargin"

  let shapeOutside = string_style_prop "shapeOutside"

  let clipPath = string_style_prop "clipPath"

  let clipRule = string_style_prop "clipRule"

  let mask = string_style_prop "mask"

  let maskBorder = string_style_prop "maskBorder"

  let maskBorderMode = string_style_prop "maskBorderMode"

  let maskBorderOutset = string_style_prop "maskBorderOutset"

  let maskBorderRepeat = string_style_prop "maskBorderRepeat"

  let maskBorderSlice = string_style_prop "maskBorderSlice"

  let maskBorderSource = string_style_prop "maskBorderSource"

  let maskBorderWidth = string_style_prop "maskBorderWidth"

  let maskClip = string_style_prop "maskClip"

  let maskComposite = string_style_prop "maskComposite"

  let maskImage = string_style_prop "maskImage"

  let maskMode = string_style_prop "maskMode"

  let maskOrigin = string_style_prop "maskOrigin"

  let maskPosition = string_style_prop "maskPosition"

  let maskRepeat = string_style_prop "maskRepeat"

  let maskSize = string_style_prop "maskSize"

  let maskType = string_style_prop "maskType"

  let backgroundBlendMode = string_style_prop "backgroundBlendMode"

  let isolation = string_style_prop "isolation"

  let mixBlendMode = string_style_prop "mixBlendMode"

  let boxDecorationBreak = string_style_prop "boxDecorationBreak"

  let boxSizing = string_style_prop "boxSizing"

  let caretColor = string_style_prop "caretColor"

  let navDown = string_style_prop "navDown"

  let navLeft = string_style_prop "navLeft"

  let navRight = string_style_prop "navRight"

  let navUp = string_style_prop "navUp"

  let outlineOffset = string_style_prop "outlineOffset"

  let resize = string_style_prop "resize"

  let textOverflow = string_style_prop "textOverflow"

  let grid = string_style_prop "grid"

  let gridArea = string_style_prop "gridArea"

  let gridAutoColumns = string_style_prop "gridAutoColumns"

  let gridAutoFlow = string_style_prop "gridAutoFlow"

  let gridAutoRows = string_style_prop "gridAutoRows"

  let gridColumn = string_style_prop "gridColumn"

  let gridColumnEnd = string_style_prop "gridColumnEnd"

  let gridColumnGap = string_style_prop "gridColumnGap"

  let gridColumnStart = string_style_prop "gridColumnStart"

  let gridGap = string_style_prop "gridGap"

  let gridRow = string_style_prop "gridRow"

  let gridRowEnd = string_style_prop "gridRowEnd"

  let gridRowGap = string_style_prop "gridRowGap"

  let gridRowStart = string_style_prop "gridRowStart"

  let gridTemplate = string_style_prop "gridTemplate"

  let gridTemplateAreas = string_style_prop "gridTemplateAreas"

  let gridTemplateColumns = string_style_prop "gridTemplateColumns"

  let gridTemplateRows = string_style_prop "gridTemplateRows"

  let willChange = string_style_prop "willChange"

  let hangingPunctuation = string_style_prop "hangingPunctuation"

  let hyphens = string_style_prop "hyphens"

  let lineBreak = string_style_prop "lineBreak"

  let overflowWrap = string_style_prop "overflowWrap"

  let tabSize = string_style_prop "tabSize"

  let textAlignLast = string_style_prop "textAlignLast"

  let textJustify = string_style_prop "textJustify"

  let wordBreak = string_style_prop "wordBreak"

  let wordWrap = string_style_prop "wordWrap"

  let animation = string_style_prop "animation"

  let animationDelay = string_style_prop "animationDelay"

  let animationDirection = string_style_prop "animationDirection"

  let animationDuration = string_style_prop "animationDuration"

  let animationFillMode = string_style_prop "animationFillMode"

  let animationIterationCount = string_style_prop "animationIterationCount"

  let animationName = string_style_prop "animationName"

  let animationPlayState = string_style_prop "animationPlayState"

  let animationTimingFunction = string_style_prop "animationTimingFunction"

  let transition = string_style_prop "transition"

  let transitionDelay = string_style_prop "transitionDelay"

  let transitionDuration = string_style_prop "transitionDuration"

  let transitionProperty = string_style_prop "transitionProperty"

  let transitionTimingFunction = string_style_prop "transitionTimingFunction"

  let backfaceVisibility = string_style_prop "backfaceVisibility"

  let perspective = string_style_prop "perspective"

  let perspectiveOrigin = string_style_prop "perspectiveOrigin"

  let transform = string_style_prop "transform"

  let transformOrigin = string_style_prop "transformOrigin"

  let transformStyle = string_style_prop "transformStyle"

  let justifyItems = string_style_prop "justifyItems"

  let justifySelf = string_style_prop "justifySelf"

  let placeContent = string_style_prop "placeContent"

  let placeItems = string_style_prop "placeItems"

  let placeSelf = string_style_prop "placeSelf"

  let appearance = string_style_prop "appearance"

  let caret = string_style_prop "caret"

  let caretAnimation = string_style_prop "caretAnimation"

  let caretShape = string_style_prop "caretShape"

  let userSelect = string_style_prop "userSelect"

  let maxLines = string_style_prop "maxLines"

  let marqueeDirection = string_style_prop "marqueeDirection"

  let marqueeLoop = string_style_prop "marqueeLoop"

  let marqueeSpeed = string_style_prop "marqueeSpeed"

  let marqueeStyle = string_style_prop "marqueeStyle"

  let overflowStyle = string_style_prop "overflowStyle"

  let rotation = string_style_prop "rotation"

  let rotationPoint = string_style_prop "rotationPoint"

  let alignmentBaseline = string_style_prop "alignmentBaseline"

  let baselineShift = string_style_prop "baselineShift"

  let clip = string_style_prop "clip"

  let clipPath = string_style_prop "clipPath"

  let clipRule = string_style_prop "clipRule"

  let colorInterpolation = string_style_prop "colorInterpolation"

  let colorInterpolationFilters = string_style_prop "colorInterpolationFilters"

  let colorProfile = string_style_prop "colorProfile"

  let colorRendering = string_style_prop "colorRendering"

  let cursor = string_style_prop "cursor"

  let dominantBaseline = string_style_prop "dominantBaseline"

  let fill = string_style_prop "fill"

  let fillOpacity = string_style_prop "fillOpacity"

  let fillRule = string_style_prop "fillRule"

  let filter = string_style_prop "filter"

  let floodColor = string_style_prop "floodColor"

  let floodOpacity = string_style_prop "floodOpacity"

  let glyphOrientationHorizontal =
    string_style_prop "glyphOrientationHorizontal"

  let glyphOrientationVertical = string_style_prop "glyphOrientationVertical"

  let imageRendering = string_style_prop "imageRendering"

  let kerning = string_style_prop "kerning"

  let lightingColor = string_style_prop "lightingColor"

  let markerEnd = string_style_prop "markerEnd"

  let markerMid = string_style_prop "markerMid"

  let markerStart = string_style_prop "markerStart"

  let pointerEvents = string_style_prop "pointerEvents"

  let shapeRendering = string_style_prop "shapeRendering"

  let stopColor = string_style_prop "stopColor"

  let stopOpacity = string_style_prop "stopOpacity"

  let stroke = string_style_prop "stroke"

  let strokeDasharray = string_style_prop "strokeDasharray"

  let strokeDashoffset = string_style_prop "strokeDashoffset"

  let strokeLinecap = string_style_prop "strokeLinecap"

  let strokeLinejoin = string_style_prop "strokeLinejoin"

  let strokeMiterlimit = string_style_prop "strokeMiterlimit"

  let strokeOpacity = string_style_prop "strokeOpacity"

  let strokeWidth = string_style_prop "strokeWidth"

  let textAnchor = string_style_prop "textAnchor"

  let textRendering = string_style_prop "textRendering"

  let rubyAlign = string_style_prop "rubyAlign"

  let rubyMerge = string_style_prop "rubyMerge"

  let rubyPosition = string_style_prop "rubyPosition"]
end

module DangerouslySetInnerHTML : sig
  type t
end

val makeHtml : __html:string -> DangerouslySetInnerHTML.t
  [@@js.builder] [@@js.verbatim_names]
