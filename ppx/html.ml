type attributeType = String | Int | Float | Bool | Style | Ref | InnerHtml

type eventType =
  | Clipboard
  | Composition
  | Keyboard
  | Focus
  | Form
  | Mouse
  | Selection
  | Touch
  | UI
  | Wheel
  | Media
  | Image
  | Animation
  | Transition

type attribute = {type_: attributeType; name: string; htmlName: string}

type event = {type_: eventType; name: string}

type prop = Attribute of attribute | Event of event

let propTypeList =
  [ Attribute {type_= String; name= "about"; htmlName= "about"}
  ; Attribute {type_= String; name= "about"; htmlName= "about"}
  ; Attribute {type_= String; name= "accentHeight"; htmlName= "accentHeight"}
  ; Attribute {type_= String; name= "accept"; htmlName= "accept"}
  ; Attribute {type_= String; name= "acceptCharset"; htmlName= "acceptCharset"}
  ; Attribute {type_= String; name= "accessKey"; htmlName= "accessKey"}
  ; Attribute {type_= String; name= "accumulate"; htmlName= "accumulate"}
  ; Attribute {type_= String; name= "action"; htmlName= "action"}
  ; Attribute {type_= String; name= "additive"; htmlName= "additive"}
  ; Attribute
      {type_= String; name= "alignmentBaseline"; htmlName= "alignmentBaseline"}
  ; Attribute {type_= Bool; name= "allowFullScreen"; htmlName= "allowFullScreen"}
  ; Attribute {type_= String; name= "allowReorder"; htmlName= "allowReorder"}
  ; Attribute {type_= String; name= "alphabetic"; htmlName= "alphabetic"}
  ; Attribute {type_= String; name= "alt"; htmlName= "alt"}
  ; Attribute {type_= String; name= "amplitude"; htmlName= "amplitude"}
  ; Attribute {type_= String; name= "arabicForm"; htmlName= "arabicForm"}
  ; Attribute
      { type_= String
      ; name= "ariaActivedescendant"
      ; htmlName= "aria-activedescendant" }
  ; Attribute {type_= Bool; name= "ariaAtomic"; htmlName= "aria-atomic"}
  ; Attribute {type_= Bool; name= "ariaBusy"; htmlName= "aria-busy"}
  ; Attribute {type_= Int; name= "ariaColcount"; htmlName= "aria-colcount"}
  ; Attribute {type_= Int; name= "ariaColindex"; htmlName= "aria-colindex"}
  ; Attribute {type_= Int; name= "ariaColspan"; htmlName= "aria-colspan"}
  ; Attribute {type_= String; name= "ariaControls"; htmlName= "aria-controls"}
  ; Attribute
      {type_= String; name= "ariaDescribedby"; htmlName= "aria-describedby"}
  ; Attribute {type_= String; name= "ariaDetails"; htmlName= "aria-details"}
  ; Attribute {type_= Bool; name= "ariaDisabled"; htmlName= "aria-disabled"}
  ; Attribute
      {type_= String; name= "ariaErrormessage"; htmlName= "aria-errormessage"}
  ; Attribute {type_= Bool; name= "ariaExpanded"; htmlName= "aria-expanded"}
  ; Attribute {type_= String; name= "ariaFlowto"; htmlName= "aria-flowto"}
  ; Attribute {type_= Bool; name= "ariaGrabbed"; htmlName= "aria-grabbed"}
  ; Attribute {type_= Bool; name= "ariaHidden"; htmlName= "aria-hidden"}
  ; Attribute
      {type_= String; name= "ariaKeyshortcuts"; htmlName= "aria-keyshortcuts"}
  ; Attribute {type_= String; name= "ariaLabel"; htmlName= "aria-label"}
  ; Attribute
      {type_= String; name= "ariaLabelledby"; htmlName= "aria-labelledby"}
  ; Attribute {type_= Int; name= "ariaLevel"; htmlName= "aria-level"}
  ; Attribute {type_= Bool; name= "ariaModal"; htmlName= "aria-modal"}
  ; Attribute {type_= Bool; name= "ariaMultiline"; htmlName= "aria-multiline"}
  ; Attribute
      { type_= Bool
      ; name= "ariaMultiselectable"
      ; htmlName= "aria-multiselectable" }
  ; Attribute {type_= String; name= "ariaOwns"; htmlName= "aria-owns"}
  ; Attribute
      {type_= String; name= "ariaPlaceholder"; htmlName= "aria-placeholder"}
  ; Attribute {type_= Int; name= "ariaPosinset"; htmlName= "aria-posinset"}
  ; Attribute {type_= Bool; name= "ariaReadonly"; htmlName= "aria-readonly"}
  ; Attribute {type_= String; name= "ariaRelevant"; htmlName= "aria-relevant"}
  ; Attribute {type_= Bool; name= "ariaRequired"; htmlName= "aria-required"}
  ; Attribute
      { type_= String
      ; name= "ariaRoledescription"
      ; htmlName= "aria-roledescription" }
  ; Attribute {type_= Int; name= "ariaRowcount"; htmlName= "aria-rowcount"}
  ; Attribute {type_= Int; name= "ariaRowindex"; htmlName= "aria-rowindex"}
  ; Attribute {type_= Int; name= "ariaRowspan"; htmlName= "aria-rowspan"}
  ; Attribute {type_= Bool; name= "ariaSelected"; htmlName= "aria-selected"}
  ; Attribute {type_= Int; name= "ariaSetsize"; htmlName= "aria-setsize"}
  ; Attribute {type_= String; name= "ariaSort"; htmlName= "aria-sort"}
  ; Attribute {type_= Float; name= "ariaValuemax"; htmlName= "aria-valuemax"}
  ; Attribute {type_= Float; name= "ariaValuemin"; htmlName= "aria-valuemin"}
  ; Attribute {type_= Float; name= "ariaValuenow"; htmlName= "aria-valuenow"}
  ; Attribute {type_= String; name= "ariaValuetext"; htmlName= "aria-valuetext"}
  ; Attribute {type_= String; name= "ascent"; htmlName= "ascent"}
  ; Attribute {type_= Bool; name= "async"; htmlName= "async"}
  ; Attribute {type_= String; name= "attributeName"; htmlName= "attributeName"}
  ; Attribute {type_= String; name= "attributeType"; htmlName= "attributeType"}
  ; Attribute {type_= String; name= "autoComplete"; htmlName= "autoComplete"}
  ; Attribute {type_= Bool; name= "autoFocus"; htmlName= "autoFocus"}
  ; Attribute {type_= Bool; name= "autoPlay"; htmlName= "autoPlay"}
  ; Attribute {type_= String; name= "autoReverse"; htmlName= "autoReverse"}
  ; Attribute {type_= String; name= "azimuth"; htmlName= "azimuth"}
  ; Attribute {type_= String; name= "baseFrequency"; htmlName= "baseFrequency"}
  ; Attribute {type_= String; name= "baselineShift"; htmlName= "baselineShift"}
  ; Attribute {type_= String; name= "baseProfile"; htmlName= "baseProfile"}
  ; Attribute {type_= String; name= "bbox"; htmlName= "bbox"}
  ; Attribute {type_= String; name= "begin_"; htmlName= "begin_"}
  ; Attribute {type_= String; name= "bias"; htmlName= "bias"}
  ; Attribute {type_= String; name= "by"; htmlName= "by"}
  ; Attribute {type_= String; name= "calcMode"; htmlName= "calcMode"}
  ; Attribute {type_= String; name= "capHeight"; htmlName= "capHeight"}
  ; Attribute {type_= String; name= "challenge"; htmlName= "challenge"}
  ; Attribute {type_= String; name= "charSet"; htmlName= "charSet"}
  ; Attribute {type_= Bool; name= "checked"; htmlName= "checked"}
  ; Attribute {type_= String; name= "cite"; htmlName= "cite"}
  ; Attribute {type_= String; name= "className"; htmlName= "className"}
  ; Attribute {type_= String; name= "clip"; htmlName= "clip"}
  ; Attribute {type_= String; name= "clipPath"; htmlName= "clipPath"}
  ; Attribute {type_= String; name= "clipPathUnits"; htmlName= "clipPathUnits"}
  ; Attribute {type_= String; name= "clipRule"; htmlName= "clipRule"}
  ; Attribute
      {type_= String; name= "colorInterpolation"; htmlName= "colorInterpolation"}
  ; Attribute
      { type_= String
      ; name= "colorInterpolationFilters"
      ; htmlName= "colorInterpolationFilters" }
  ; Attribute {type_= String; name= "colorProfile"; htmlName= "colorProfile"}
  ; Attribute {type_= String; name= "colorRendering"; htmlName= "colorRendering"}
  ; Attribute {type_= Int; name= "cols"; htmlName= "cols"}
  ; Attribute {type_= Int; name= "colSpan"; htmlName= "colSpan"}
  ; Attribute {type_= String; name= "content"; htmlName= "content"}
  ; Attribute {type_= Bool; name= "contentEditable"; htmlName= "contentEditable"}
  ; Attribute
      {type_= String; name= "contentScriptType"; htmlName= "contentScriptType"}
  ; Attribute
      {type_= String; name= "contentStyleType"; htmlName= "contentStyleType"}
  ; Attribute {type_= String; name= "contextMenu"; htmlName= "contextMenu"}
  ; Attribute {type_= Bool; name= "controls"; htmlName= "controls"}
  ; Attribute {type_= String; name= "coords"; htmlName= "coords"}
  ; Attribute {type_= Bool; name= "crossorigin"; htmlName= "crossorigin"}
  ; Attribute {type_= String; name= "cursor"; htmlName= "cursor"}
  ; Attribute {type_= String; name= "cx"; htmlName= "cx"}
  ; Attribute {type_= String; name= "cy"; htmlName= "cy"}
  ; Attribute {type_= String; name= "d"; htmlName= "d"}
  ; Attribute {type_= String; name= "data"; htmlName= "data"}
  ; Attribute {type_= String; name= "datatype"; htmlName= "datatype"}
  ; Attribute {type_= String; name= "dateTime"; htmlName= "dateTime"}
  ; Attribute
      { type_= InnerHtml
      ; name= "dangerouslySetInnerHTML"
      ; htmlName= "dangerouslySetInnerHTML" }
  ; Attribute {type_= String; name= "decelerate"; htmlName= "decelerate"}
  ; Attribute {type_= Bool; name= "default"; htmlName= "default"}
  ; Attribute {type_= Bool; name= "defaultChecked"; htmlName= "defaultChecked"}
  ; Attribute {type_= String; name= "defaultValue"; htmlName= "defaultValue"}
  ; Attribute {type_= Bool; name= "defer"; htmlName= "defer"}
  ; Attribute {type_= String; name= "descent"; htmlName= "descent"}
  ; Attribute
      {type_= String; name= "diffuseConstant"; htmlName= "diffuseConstant"}
  ; Attribute {type_= String; name= "dir"; htmlName= "dir"}
  ; Attribute {type_= String; name= "direction"; htmlName= "direction"}
  ; Attribute {type_= Bool; name= "disabled"; htmlName= "disabled"}
  ; Attribute {type_= String; name= "display"; htmlName= "display"}
  ; Attribute {type_= String; name= "divisor"; htmlName= "divisor"}
  ; Attribute
      {type_= String; name= "dominantBaseline"; htmlName= "dominantBaseline"}
  ; Attribute {type_= String; name= "download"; htmlName= "download"}
  ; Attribute {type_= Bool; name= "draggable"; htmlName= "draggable"}
  ; Attribute {type_= String; name= "dur"; htmlName= "dur"}
  ; Attribute {type_= String; name= "dx"; htmlName= "dx"}
  ; Attribute {type_= String; name= "dy"; htmlName= "dy"}
  ; Attribute {type_= String; name= "edgeMode"; htmlName= "edgeMode"}
  ; Attribute {type_= String; name= "elevation"; htmlName= "elevation"}
  ; Attribute
      {type_= String; name= "enableBackground"; htmlName= "enableBackground"}
  ; Attribute {type_= String; name= "encType"; htmlName= "encType"}
  ; Attribute {type_= String; name= "end_"; htmlName= "end_"}
  ; Attribute {type_= String; name= "exponent"; htmlName= "exponent"}
  ; Attribute
      { type_= String
      ; name= "externalResourcesRequired"
      ; htmlName= "externalResourcesRequired" }
  ; Attribute {type_= String; name= "fill"; htmlName= "fill"}
  ; Attribute {type_= String; name= "fillOpacity"; htmlName= "fillOpacity"}
  ; Attribute {type_= String; name= "fillRule"; htmlName= "fillRule"}
  ; Attribute {type_= String; name= "filter"; htmlName= "filter"}
  ; Attribute {type_= String; name= "filterRes"; htmlName= "filterRes"}
  ; Attribute {type_= String; name= "filterUnits"; htmlName= "filterUnits"}
  ; Attribute {type_= String; name= "floodColor"; htmlName= "floodColor"}
  ; Attribute {type_= String; name= "floodOpacity"; htmlName= "floodOpacity"}
  ; Attribute {type_= String; name= "focusable"; htmlName= "focusable"}
    (* fomat? *)
  ; Attribute {type_= String; name= "fomat"; htmlName= "fomat"}
  ; Attribute {type_= String; name= "fontFamily"; htmlName= "fontFamily"}
  ; Attribute {type_= String; name= "fontSize"; htmlName= "fontSize"}
  ; Attribute {type_= String; name= "fontSizeAdjust"; htmlName= "fontSizeAdjust"}
  ; Attribute {type_= String; name= "fontStretch"; htmlName= "fontStretch"}
  ; Attribute {type_= String; name= "fontStyle"; htmlName= "fontStyle"}
  ; Attribute {type_= String; name= "fontVariant"; htmlName= "fontVariant"}
  ; Attribute {type_= String; name= "fontWeight"; htmlName= "fontWeight"}
  ; Attribute {type_= String; name= "form"; htmlName= "form"}
  ; Attribute {type_= String; name= "formAction"; htmlName= "formAction"}
  ; Attribute {type_= String; name= "formMethod"; htmlName= "formMethod"}
  ; Attribute {type_= String; name= "formTarget"; htmlName= "formTarget"}
  ; Attribute {type_= String; name= "from"; htmlName= "from"}
  ; Attribute {type_= String; name= "fx"; htmlName= "fx"}
  ; Attribute {type_= String; name= "fy"; htmlName= "fy"}
  ; Attribute {type_= String; name= "g1"; htmlName= "g1"}
  ; Attribute {type_= String; name= "g2"; htmlName= "g2"}
  ; Attribute {type_= String; name= "glyphName"; htmlName= "glyphName"}
  ; Attribute
      { type_= String
      ; name= "glyphOrientationHorizontal"
      ; htmlName= "glyphOrientationHorizontal" }
  ; Attribute
      { type_= String
      ; name= "glyphOrientationVertical"
      ; htmlName= "glyphOrientationVertical" }
  ; Attribute {type_= String; name= "glyphRef"; htmlName= "glyphRef"}
  ; Attribute
      {type_= String; name= "gradientTransform"; htmlName= "gradientTransform"}
  ; Attribute {type_= String; name= "gradientUnits"; htmlName= "gradientUnits"}
  ; Attribute {type_= String; name= "hanging"; htmlName= "hanging"}
  ; Attribute {type_= String; name= "headers"; htmlName= "headers"}
  ; Attribute {type_= String; name= "height"; htmlName= "height"}
  ; Attribute {type_= Bool; name= "hidden"; htmlName= "hidden"}
  ; Attribute {type_= Int; name= "high"; htmlName= "high"}
  ; Attribute {type_= String; name= "horizAdvX"; htmlName= "horizAdvX"}
  ; Attribute {type_= String; name= "horizOriginX"; htmlName= "horizOriginX"}
  ; Attribute {type_= String; name= "href"; htmlName= "href"}
  ; Attribute {type_= String; name= "hrefLang"; htmlName= "hrefLang"}
  ; Attribute {type_= String; name= "htmlFor"; htmlName= "htmlFor"}
  ; Attribute {type_= String; name= "httpEquiv"; htmlName= "httpEquiv"}
  ; Attribute {type_= String; name= "icon"; htmlName= "icon"}
  ; Attribute {type_= String; name= "id"; htmlName= "id"}
  ; Attribute {type_= String; name= "ideographic"; htmlName= "ideographic"}
  ; Attribute {type_= String; name= "imageRendering"; htmlName= "imageRendering"}
  ; Attribute {type_= String; name= "in_"; htmlName= "in_"}
  ; Attribute {type_= String; name= "in2"; htmlName= "in2"}
  ; Attribute {type_= String; name= "inlist"; htmlName= "inlist"}
  ; Attribute {type_= String; name= "inputMode"; htmlName= "inputMode"}
  ; Attribute {type_= String; name= "integrity"; htmlName= "integrity"}
  ; Attribute {type_= String; name= "intercept"; htmlName= "intercept"}
  ; Attribute {type_= String; name= "itemID"; htmlName= "itemID"}
  ; Attribute {type_= String; name= "itemProp"; htmlName= "itemProp"}
  ; Attribute {type_= String; name= "itemRef"; htmlName= "itemRef"}
  ; Attribute {type_= Bool; name= "itemScope"; htmlName= "itemScope"}
  ; Attribute {type_= String; name= "itemType"; htmlName= "itemType"}
  ; Attribute {type_= String; name= "k"; htmlName= "k"}
  ; Attribute {type_= String; name= "k1"; htmlName= "k1"}
  ; Attribute {type_= String; name= "k2"; htmlName= "k2"}
  ; Attribute {type_= String; name= "k3"; htmlName= "k3"}
  ; Attribute {type_= String; name= "k4"; htmlName= "k4"}
  ; Attribute {type_= String; name= "kernelMatrix"; htmlName= "kernelMatrix"}
  ; Attribute
      {type_= String; name= "kernelUnitLength"; htmlName= "kernelUnitLength"}
  ; Attribute {type_= String; name= "kerning"; htmlName= "kerning"}
  ; Attribute {type_= String; name= "key"; htmlName= "key"}
  ; Attribute {type_= String; name= "keyPoints"; htmlName= "keyPoints"}
  ; Attribute {type_= String; name= "keySplines"; htmlName= "keySplines"}
  ; Attribute {type_= String; name= "keyTimes"; htmlName= "keyTimes"}
  ; Attribute {type_= String; name= "keyType"; htmlName= "keyType"}
  ; Attribute {type_= String; name= "kind"; htmlName= "kind"}
  ; Attribute {type_= String; name= "label"; htmlName= "label"}
  ; Attribute {type_= String; name= "lang"; htmlName= "lang"}
  ; Attribute {type_= String; name= "lengthAdjust"; htmlName= "lengthAdjust"}
  ; Attribute {type_= String; name= "letterSpacing"; htmlName= "letterSpacing"}
  ; Attribute {type_= String; name= "lightingColor"; htmlName= "lightingColor"}
  ; Attribute
      {type_= String; name= "limitingConeAngle"; htmlName= "limitingConeAngle"}
  ; Attribute {type_= String; name= "list"; htmlName= "list"}
  ; Attribute {type_= String; name= "local"; htmlName= "local"}
  ; Attribute {type_= Bool; name= "loop"; htmlName= "loop"}
  ; Attribute {type_= Int; name= "low"; htmlName= "low"}
  ; Attribute {type_= String; name= "manifest"; htmlName= "manifest"}
  ; Attribute {type_= String; name= "markerEnd"; htmlName= "markerEnd"}
  ; Attribute {type_= String; name= "markerHeight"; htmlName= "markerHeight"}
  ; Attribute {type_= String; name= "markerMid"; htmlName= "markerMid"}
  ; Attribute {type_= String; name= "markerStart"; htmlName= "markerStart"}
  ; Attribute {type_= String; name= "markerUnits"; htmlName= "markerUnits"}
  ; Attribute {type_= String; name= "markerWidth"; htmlName= "markerWidth"}
  ; Attribute {type_= String; name= "mask"; htmlName= "mask"}
  ; Attribute
      {type_= String; name= "maskContentUnits"; htmlName= "maskContentUnits"}
  ; Attribute {type_= String; name= "maskUnits"; htmlName= "maskUnits"}
  ; Attribute {type_= String; name= "mathematical"; htmlName= "mathematical"}
  ; Attribute {type_= String; name= "max"; htmlName= "max"}
  ; Attribute {type_= Int; name= "maxLength"; htmlName= "maxLength"}
  ; Attribute {type_= String; name= "media"; htmlName= "media"}
  ; Attribute {type_= String; name= "mediaGroup"; htmlName= "mediaGroup"}
  ; Attribute {type_= Int; name= "min"; htmlName= "min"}
  ; Attribute {type_= Int; name= "minLength"; htmlName= "minLength"}
  ; Attribute {type_= String; name= "mode"; htmlName= "mode"}
  ; Attribute {type_= Bool; name= "multiple"; htmlName= "multiple"}
  ; Attribute {type_= Bool; name= "muted"; htmlName= "muted"}
  ; Attribute {type_= String; name= "name"; htmlName= "name"}
  ; Attribute {type_= String; name= "nonce"; htmlName= "nonce"}
  ; Attribute {type_= Bool; name= "noValidate"; htmlName= "noValidate"}
  ; Attribute {type_= String; name= "numOctaves"; htmlName= "numOctaves"}
  ; Attribute {type_= String; name= "offset"; htmlName= "offset"}
  ; Attribute {type_= String; name= "opacity"; htmlName= "opacity"}
  ; Attribute {type_= Bool; name= "open_"; htmlName= "open_"}
  ; Attribute {type_= String; name= "operator"; htmlName= "operator"}
  ; Attribute {type_= Int; name= "optimum"; htmlName= "optimum"}
  ; Attribute {type_= String; name= "order"; htmlName= "order"}
  ; Attribute {type_= String; name= "orient"; htmlName= "orient"}
  ; Attribute {type_= String; name= "orientation"; htmlName= "orientation"}
  ; Attribute {type_= String; name= "origin"; htmlName= "origin"}
  ; Attribute {type_= String; name= "overflow"; htmlName= "overflow"}
  ; Attribute {type_= String; name= "overflowX"; htmlName= "overflowX"}
  ; Attribute {type_= String; name= "overflowY"; htmlName= "overflowY"}
  ; Attribute
      {type_= String; name= "overlinePosition"; htmlName= "overlinePosition"}
  ; Attribute
      {type_= String; name= "overlineThickness"; htmlName= "overlineThickness"}
  ; Attribute {type_= String; name= "paintOrder"; htmlName= "paintOrder"}
  ; Attribute {type_= String; name= "panose1"; htmlName= "panose1"}
  ; Attribute {type_= String; name= "pathLength"; htmlName= "pathLength"}
  ; Attribute {type_= String; name= "pattern"; htmlName= "pattern"}
  ; Attribute
      { type_= String
      ; name= "patternContentUnits"
      ; htmlName= "patternContentUnits" }
  ; Attribute
      {type_= String; name= "patternTransform"; htmlName= "patternTransform"}
  ; Attribute {type_= String; name= "patternUnits"; htmlName= "patternUnits"}
  ; Attribute {type_= String; name= "placeholder"; htmlName= "placeholder"}
  ; Attribute {type_= String; name= "pointerEvents"; htmlName= "pointerEvents"}
  ; Attribute {type_= String; name= "points"; htmlName= "points"}
  ; Attribute {type_= String; name= "pointsAtX"; htmlName= "pointsAtX"}
  ; Attribute {type_= String; name= "pointsAtY"; htmlName= "pointsAtY"}
  ; Attribute {type_= String; name= "pointsAtZ"; htmlName= "pointsAtZ"}
  ; Attribute {type_= String; name= "poster"; htmlName= "poster"}
  ; Attribute {type_= String; name= "prefix"; htmlName= "prefix"}
  ; Attribute {type_= String; name= "preload"; htmlName= "preload"}
  ; Attribute {type_= String; name= "preserveAlpha"; htmlName= "preserveAlpha"}
  ; Attribute
      { type_= String
      ; name= "preserveAspectRatio"
      ; htmlName= "preserveAspectRatio" }
  ; Attribute {type_= String; name= "primitiveUnits"; htmlName= "primitiveUnits"}
  ; Attribute {type_= String; name= "property"; htmlName= "property"}
  ; Attribute {type_= String; name= "r"; htmlName= "r"}
  ; Attribute {type_= String; name= "radioGroup"; htmlName= "radioGroup"}
  ; Attribute {type_= String; name= "radius"; htmlName= "radius"}
  ; Attribute {type_= Bool; name= "readOnly"; htmlName= "readOnly"}
  ; Attribute {type_= Ref; name= "ref"; htmlName= "ref"}
  ; Attribute {type_= String; name= "refX"; htmlName= "refX"}
  ; Attribute {type_= String; name= "refY"; htmlName= "refY"}
  ; Attribute {type_= String; name= "rel"; htmlName= "rel"}
  ; Attribute
      {type_= String; name= "renderingIntent"; htmlName= "renderingIntent"}
  ; Attribute {type_= String; name= "repeatCount"; htmlName= "repeatCount"}
  ; Attribute {type_= String; name= "repeatDur"; htmlName= "repeatDur"}
  ; Attribute {type_= Bool; name= "required"; htmlName= "required"}
  ; Attribute
      {type_= String; name= "requiredExtensions"; htmlName= "requiredExtensions"}
  ; Attribute
      {type_= String; name= "requiredFeatures"; htmlName= "requiredFeatures"}
  ; Attribute {type_= String; name= "resource"; htmlName= "resource"}
  ; Attribute {type_= String; name= "restart"; htmlName= "restart"}
  ; Attribute {type_= String; name= "result"; htmlName= "result"}
  ; Attribute {type_= Bool; name= "reversed"; htmlName= "reversed"}
  ; Attribute {type_= String; name= "role"; htmlName= "role"}
  ; Attribute {type_= String; name= "rotate"; htmlName= "rotate"}
  ; Attribute {type_= Int; name= "rows"; htmlName= "rows"}
  ; Attribute {type_= Int; name= "rowSpan"; htmlName= "rowSpan"}
  ; Attribute {type_= String; name= "rx"; htmlName= "rx"}
  ; Attribute {type_= String; name= "ry"; htmlName= "ry"}
  ; Attribute {type_= String; name= "sandbox"; htmlName= "sandbox"}
  ; Attribute {type_= String; name= "scale"; htmlName= "scale"}
  ; Attribute {type_= String; name= "scope"; htmlName= "scope"}
  ; Attribute {type_= Bool; name= "scoped"; htmlName= "scoped"}
  ; Attribute {type_= String; name= "scrolling"; htmlName= "scrolling"}
  ; Attribute {type_= String; name= "seed"; htmlName= "seed"}
  ; Attribute {type_= Bool; name= "selected"; htmlName= "selected"}
  ; Attribute {type_= String; name= "shape"; htmlName= "shape"}
  ; Attribute {type_= String; name= "shapeRendering"; htmlName= "shapeRendering"}
  ; Attribute {type_= Int; name= "size"; htmlName= "size"}
  ; Attribute {type_= String; name= "sizes"; htmlName= "sizes"}
  ; Attribute {type_= String; name= "slope"; htmlName= "slope"}
  ; Attribute {type_= String; name= "spacing"; htmlName= "spacing"}
  ; Attribute {type_= Int; name= "span"; htmlName= "span"}
  ; Attribute
      {type_= String; name= "specularConstant"; htmlName= "specularConstant"}
  ; Attribute
      {type_= String; name= "specularExponent"; htmlName= "specularExponent"}
  ; Attribute {type_= String; name= "speed"; htmlName= "speed"}
  ; Attribute {type_= Bool; name= "spellCheck"; htmlName= "spellCheck"}
  ; Attribute {type_= String; name= "spreadMethod"; htmlName= "spreadMethod"}
  ; Attribute {type_= String; name= "src"; htmlName= "src"}
  ; Attribute {type_= String; name= "srcDoc"; htmlName= "srcDoc"}
  ; Attribute {type_= String; name= "srcLang"; htmlName= "srcLang"}
  ; Attribute {type_= String; name= "srcSet"; htmlName= "srcSet"}
  ; Attribute {type_= Int; name= "start"; htmlName= "start"}
  ; Attribute {type_= String; name= "startOffset"; htmlName= "startOffset"}
  ; Attribute {type_= String; name= "stdDeviation"; htmlName= "stdDeviation"}
  ; Attribute {type_= String; name= "stemh"; htmlName= "stemh"}
  ; Attribute {type_= String; name= "stemv"; htmlName= "stemv"}
  ; Attribute {type_= Float; name= "step"; htmlName= "step"}
  ; Attribute {type_= String; name= "stitchTiles"; htmlName= "stitchTiles"}
  ; Attribute {type_= String; name= "stopColor"; htmlName= "stopColor"}
  ; Attribute {type_= String; name= "stopOpacity"; htmlName= "stopOpacity"}
  ; Attribute
      { type_= String
      ; name= "strikethroughPosition"
      ; htmlName= "strikethroughPosition" }
  ; Attribute
      { type_= String
      ; name= "strikethroughThickness"
      ; htmlName= "strikethroughThickness" }
  ; Attribute {type_= String; name= "stroke"; htmlName= "stroke"}
  ; Attribute
      {type_= String; name= "strokeDasharray"; htmlName= "strokeDasharray"}
  ; Attribute
      {type_= String; name= "strokeDashoffset"; htmlName= "strokeDashoffset"}
  ; Attribute {type_= String; name= "strokeLinecap"; htmlName= "strokeLinecap"}
  ; Attribute {type_= String; name= "strokeLinejoin"; htmlName= "strokeLinejoin"}
  ; Attribute
      {type_= String; name= "strokeMiterlimit"; htmlName= "strokeMiterlimit"}
  ; Attribute {type_= String; name= "strokeOpacity"; htmlName= "strokeOpacity"}
  ; Attribute {type_= String; name= "strokeWidth"; htmlName= "strokeWidth"}
  ; Attribute {type_= Style; name= "style"; htmlName= "style"}
  ; Attribute {type_= String; name= "summary"; htmlName= "summary"}
  ; Attribute
      { type_= Bool
      ; name= "suppressContentEditableWarning"
      ; htmlName= "suppressContentEditableWarning" }
  ; Attribute {type_= String; name= "surfaceScale"; htmlName= "surfaceScale"}
  ; Attribute {type_= String; name= "systemLanguage"; htmlName= "systemLanguage"}
  ; Attribute {type_= Int; name= "tabIndex"; htmlName= "tabIndex"}
  ; Attribute {type_= String; name= "tableValues"; htmlName= "tableValues"}
  ; Attribute {type_= String; name= "target"; htmlName= "target"}
  ; Attribute {type_= String; name= "targetX"; htmlName= "targetX"}
  ; Attribute {type_= String; name= "targetY"; htmlName= "targetY"}
  ; Attribute {type_= String; name= "textAnchor"; htmlName= "textAnchor"}
  ; Attribute {type_= String; name= "textDecoration"; htmlName= "textDecoration"}
  ; Attribute {type_= String; name= "textLength"; htmlName= "textLength"}
  ; Attribute {type_= String; name= "textRendering"; htmlName= "textRendering"}
  ; Attribute {type_= String; name= "title"; htmlName= "title"}
  ; Attribute {type_= String; name= "to_"; htmlName= "to_"}
  ; Attribute {type_= String; name= "transform"; htmlName= "transform"}
  ; Attribute {type_= String; name= "type_"; htmlName= "type"}
  ; Attribute {type_= String; name= "typeof"; htmlName= "typeof"}
  ; Attribute {type_= String; name= "u1"; htmlName= "u1"}
  ; Attribute {type_= String; name= "u2"; htmlName= "u2"}
  ; Attribute
      {type_= String; name= "underlinePosition"; htmlName= "underlinePosition"}
  ; Attribute
      {type_= String; name= "underlineThickness"; htmlName= "underlineThickness"}
  ; Attribute {type_= String; name= "unicode"; htmlName= "unicode"}
  ; Attribute {type_= String; name= "unicodeBidi"; htmlName= "unicodeBidi"}
  ; Attribute {type_= String; name= "unicodeRange"; htmlName= "unicodeRange"}
  ; Attribute {type_= String; name= "unitsPerEm"; htmlName= "unitsPerEm"}
  ; Attribute {type_= String; name= "useMap"; htmlName= "useMap"}
  ; Attribute {type_= String; name= "vAlphabetic"; htmlName= "vAlphabetic"}
  ; Attribute {type_= String; name= "value"; htmlName= "value"}
  ; Attribute {type_= String; name= "values"; htmlName= "values"}
  ; Attribute {type_= String; name= "vectorEffect"; htmlName= "vectorEffect"}
  ; Attribute {type_= String; name= "version"; htmlName= "version"}
  ; Attribute {type_= String; name= "vertAdvX"; htmlName= "vertAdvX"}
  ; Attribute {type_= String; name= "vertAdvY"; htmlName= "vertAdvY"}
  ; Attribute {type_= String; name= "vertOriginX"; htmlName= "vertOriginX"}
  ; Attribute {type_= String; name= "vertOriginY"; htmlName= "vertOriginY"}
  ; Attribute {type_= String; name= "vHanging"; htmlName= "vHanging"}
  ; Attribute {type_= String; name= "vIdeographic"; htmlName= "vIdeographic"}
  ; Attribute {type_= String; name= "viewBox"; htmlName= "viewBox"}
  ; Attribute {type_= String; name= "viewTarget"; htmlName= "viewTarget"}
  ; Attribute {type_= String; name= "visibility"; htmlName= "visibility"}
  ; Attribute {type_= String; name= "vMathematical"; htmlName= "vMathematical"}
  ; Attribute {type_= String; name= "vocab"; htmlName= "vocab"}
  ; Attribute {type_= String; name= "width"; htmlName= "width"}
  ; Attribute {type_= String; name= "widths"; htmlName= "widths"}
  ; Attribute {type_= String; name= "wordSpacing"; htmlName= "wordSpacing"}
  ; Attribute {type_= String; name= "wrap"; htmlName= "wrap"}
  ; Attribute {type_= String; name= "writingMode"; htmlName= "writingMode"}
  ; Attribute {type_= String; name= "x"; htmlName= "x"}
  ; Attribute {type_= String; name= "x1"; htmlName= "x1"}
  ; Attribute {type_= String; name= "x2"; htmlName= "x2"}
  ; Attribute
      {type_= String; name= "xChannelSelector"; htmlName= "xChannelSelector"}
  ; Attribute {type_= String; name= "xHeight"; htmlName= "xHeight"}
  ; Attribute {type_= String; name= "xlinkActuate"; htmlName= "xlinkActuate"}
  ; Attribute {type_= String; name= "xlinkArcrole"; htmlName= "xlinkArcrole"}
  ; Attribute {type_= String; name= "xlinkHref"; htmlName= "xlinkHref"}
  ; Attribute {type_= String; name= "xlinkRole"; htmlName= "xlinkRole"}
  ; Attribute {type_= String; name= "xlinkShow"; htmlName= "xlinkShow"}
  ; Attribute {type_= String; name= "xlinkTitle"; htmlName= "xlinkTitle"}
  ; Attribute {type_= String; name= "xlinkType"; htmlName= "xlinkType"}
  ; Attribute {type_= String; name= "xmlBase"; htmlName= "xmlBase"}
  ; Attribute {type_= String; name= "xmlLang"; htmlName= "xmlLang"}
  ; Attribute {type_= String; name= "xmlns"; htmlName= "xmlns"}
  ; Attribute {type_= String; name= "xmlnsXlink"; htmlName= "xmlnsXlink"}
  ; Attribute {type_= String; name= "xmlSpace"; htmlName= "xmlSpace"}
  ; Attribute {type_= String; name= "y"; htmlName= "y"}
  ; Attribute {type_= String; name= "y1"; htmlName= "y1"}
  ; Attribute {type_= String; name= "y2"; htmlName= "y2"}
  ; Attribute
      {type_= String; name= "yChannelSelector"; htmlName= "yChannelSelector"}
  ; Attribute {type_= String; name= "z"; htmlName= "z"}
  ; Attribute {type_= String; name= "zoomAndPan"; htmlName= "zoomAndPan"}
  ; Event {name= "onAbort"; type_= Media}
  ; Event {name= "onAnimationEnd"; type_= Animation}
  ; Event {name= "onAnimationIteration"; type_= Animation}
  ; Event {name= "onAnimationStart"; type_= Animation}
  ; Event {name= "onBlur"; type_= Focus}
  ; Event {name= "onCanPlay"; type_= Media}
  ; Event {name= "onCanPlayThrough"; type_= Media}
  ; Event {name= "onChange"; type_= Form}
  ; Event {name= "onClick"; type_= Mouse}
  ; Event {name= "onCompositionEnd"; type_= Composition}
  ; Event {name= "onCompositionStart"; type_= Composition}
  ; Event {name= "onCompositionUpdate"; type_= Composition}
  ; Event {name= "onContextMenu"; type_= Mouse}
  ; Event {name= "onCopy"; type_= Clipboard}
  ; Event {name= "onCut"; type_= Clipboard}
  ; Event {name= "onDoubleClick"; type_= Mouse}
  ; Event {name= "onDrag"; type_= Mouse}
  ; Event {name= "onDragEnd"; type_= Mouse}
  ; Event {name= "onDragEnter"; type_= Mouse}
  ; Event {name= "onDragExit"; type_= Mouse}
  ; Event {name= "onDragLeave"; type_= Mouse}
  ; Event {name= "onDragOver"; type_= Mouse}
  ; Event {name= "onDragStart"; type_= Mouse}
  ; Event {name= "onDrop"; type_= Mouse}
  ; Event {name= "onDurationChange"; type_= Media}
  ; Event {name= "onEmptied"; type_= Media}
  ; Event {name= "onEncrypetd"; type_= Media}
  ; Event {name= "onEnded"; type_= Media}
  ; Event {name= "onError"; type_= Media}
  ; Event {name= "onFocus"; type_= Focus}
  ; Event {name= "onInput"; type_= Form}
  ; Event {name= "onKeyDown"; type_= Keyboard}
  ; Event {name= "onKeyPress"; type_= Keyboard}
  ; Event {name= "onKeyUp"; type_= Keyboard}
  ; Event {name= "onLoadedData"; type_= Media}
  ; Event {name= "onLoadedMetadata"; type_= Media}
  ; Event {name= "onLoadStart"; type_= Media}
  ; Event {name= "onMouseDown"; type_= Mouse}
  ; Event {name= "onMouseEnter"; type_= Mouse}
  ; Event {name= "onMouseLeave"; type_= Mouse}
  ; Event {name= "onMouseMove"; type_= Mouse}
  ; Event {name= "onMouseOut"; type_= Mouse}
  ; Event {name= "onMouseOver"; type_= Mouse}
  ; Event {name= "onMouseUp"; type_= Mouse}
  ; Event {name= "onPaste"; type_= Clipboard}
  ; Event {name= "onPause"; type_= Media}
  ; Event {name= "onPlay"; type_= Media}
  ; Event {name= "onPlaying"; type_= Media}
  ; Event {name= "onProgress"; type_= Media}
  ; Event {name= "onRateChange"; type_= Media}
  ; Event {name= "onScroll"; type_= UI}
  ; Event {name= "onSeeked"; type_= Media}
  ; Event {name= "onSeeking"; type_= Media}
  ; Event {name= "onSelect"; type_= Selection}
  ; Event {name= "onStalled"; type_= Media}
  ; Event {name= "onSubmit"; type_= Form}
  ; Event {name= "onSuspend"; type_= Media}
  ; Event {name= "onTimeUpdate"; type_= Media}
  ; Event {name= "onTouchCancel"; type_= Touch}
  ; Event {name= "onTouchEnd"; type_= Touch}
  ; Event {name= "onTouchMove"; type_= Touch}
  ; Event {name= "onTouchStart"; type_= Touch}
  ; Event {name= "onTransitionEnd"; type_= Transition}
  ; Event {name= "onVolumeChange"; type_= Media}
  ; Event {name= "onWaiting"; type_= Media}
  ; Event {name= "onWheel"; type_= Wheel} ]

let getName = function Attribute {name; _} -> name | Event {name; _} -> name

let getHtmlName = function
  | Attribute {htmlName; _} ->
      htmlName
  | Event {name; _} ->
      name

let findByName name =
  match List.find_opt (fun p -> name = getName p) propTypeList with
  | Some p ->
      p
  | None ->
      failwith @@ Printf.sprintf "prop '%s' doesn't exist in React" name
