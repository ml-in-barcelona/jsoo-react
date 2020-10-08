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

val render : React.element -> domElement -> unit
  [@@js.global "__LIB__reactDOM.render"]

val renderToElementWithId : React.element -> string -> unit
  [@@js.custom
    val getElementById : string -> domElement option
      [@@js.global "document.getElementById"]

    let renderToElementWithId reactElement id =
      match getElementById id with
      | None ->
          raise
            (Invalid_argument
               ( "ReactDOM.renderToElementWithId : no element of id " ^ id
               ^ " found in the HTML." ))
      | Some element ->
          render reactElement element]

type style

type domRef = private Ojs.t

module Ref : sig
  type t = domRef

  type currentDomRef = domElement React.js_nullable React.Ref.t

  type callbackDomRef = domElement React.js_nullable -> unit

  [@@@js.stop]

  val domRef : currentDomRef -> domRef

  val callbackDomRef : callbackDomRef -> domRef

  [@@@js.start]

  [@@@js.implem
  external domRef : currentDomRef -> domRef = "%identity"

  external callbackDomRef : callbackDomRef -> domRef = "%identity"]
end

type domProps = private Ojs.t

val domProps :
     ?key:string
  -> ?ref:
       domRef
       (* accessibility *)
       (* https://www.w3.org/TR/wai-aria-1.1/ *)
       (* https://accessibilityresources.org/<aria-tag> is a great resource for these *)
       (* -> ?ariaCurrent: (page|step|location|date|time|true|false [@js "aria-current"]) *)
  -> ?ariaDetails:(string[@js "aria-details"])
  -> ?ariaDisabled:(bool[@js "aria-disabled"])
  -> ?ariaHidden:(bool[@js "aria-hidden"])
  -> ?ariaKeyshortcuts:
       ((* -> ?ariaInvalid: (grammar|false|spelling|true [@js "aria-invalid"]) *)
        string[@js "aria-keyshortcuts"])
  -> ?ariaLabel:(string[@js "aria-label"])
  -> ?ariaRoledescription:(string[@js "aria-roledescription"])
  -> ?ariaExpanded:
       ((* Widget Attributes *)
        (* -> ?ariaAutocomplete: (inline|list|both|none [@js "aria-autocomplete"]) *)
        (* -> ?ariaChecked: (true|false|mixed [@js "aria-checked"]) (* https://www.w3.org/TR/wai-aria-1.1/#valuetype_tristate *) *)
        bool[@js "aria-expanded"])
  -> ?ariaLevel:
       ((* -> ?ariaHaspopup: (false|true|menu|listbox|tree|grid|dialog [@js "aria-haspopup"]) *)
        int[@js "aria-level"])
  -> ?ariaModal:(bool[@js "aria-modal"])
  -> ?ariaMultiline:(bool[@js "aria-multiline"])
  -> ?ariaMultiselectable:(bool[@js "aria-multiselectable"])
  -> ?ariaPlaceholder:
       ((* -> ?ariaOrientation: (horizontal|vertical|undefined [@js "aria-orientation"]) *)
        string[@js "aria-placeholder"])
  -> ?ariaReadonly:
       ((* -> ?ariaPressed: (true|false|mixed [@js "aria-pressed"]) (* https://www.w3.org/TR/wai-aria-1.1/#valuetype_tristate *) *)
        bool[@js "aria-readonly"])
  -> ?ariaRequired:(bool[@js "aria-required"])
  -> ?ariaSelected:(bool[@js "aria-selected"])
  -> ?ariaSort:(string[@js "aria-sort"])
  -> ?ariaValuemax:(float[@js "aria-valuemax"])
  -> ?ariaValuemin:(float[@js "aria-valuemin"])
  -> ?ariaValuenow:(float[@js "aria-valuenow"])
  -> ?ariaValuetext:(string[@js "aria-valuetext"])
  -> ?ariaAtomic:((* Live Region Attributes *)
                  bool[@js "aria-atomic"])
  -> ?ariaBusy:(bool[@js "aria-busy"])
  -> ?ariaRelevant:
       ((* -> ?ariaLive: (off|polite|assertive|rude [@js "aria-live"]) *)
        string[@js "aria-relevant"])
  -> ?ariaGrabbed:
       ((* Drag-and-Drop Attributes *)
        (* -> ?ariaDropeffect: (copy|move|link|execute|popup|none [@js "aria-dropeffect"]) *)
        bool[@js "aria-grabbed"])
  -> ?ariaActivedescendant:((* Relationship Attributes *)
                            string[@js "aria-activedescendant"])
  -> ?ariaColcount:(int[@js "aria-colcount"])
  -> ?ariaColindex:(int[@js "aria-colindex"])
  -> ?ariaColspan:(int[@js "aria-colspan"])
  -> ?ariaControls:(string[@js "aria-controls"])
  -> ?ariaDescribedby:(string[@js "aria-describedby"])
  -> ?ariaErrormessage:(string[@js "aria-errormessage"])
  -> ?ariaFlowto:(string[@js "aria-flowto"])
  -> ?ariaLabelledby:(string[@js "aria-labelledby"])
  -> ?ariaOwns:(string[@js "aria-owns"])
  -> ?ariaPosinset:(int[@js "aria-posinset"])
  -> ?ariaRowcount:(int[@js "aria-rowcount"])
  -> ?ariaRowindex:(int[@js "aria-rowindex"])
  -> ?ariaRowspan:(int[@js "aria-rowspan"])
  -> ?ariaSetsize:(int[@js "aria-setsize"])
  -> ?defaultChecked:(* react textarea/input *)
                     bool
  -> ?defaultValue:string (* global html attributes *)
  -> ?accessKey:string
  -> ?className:string (* substitute for "class" *)
  -> ?contentEditable:bool
  -> ?contextMenu:string
  -> ?dir:string (* "ltr", "rtl" or "auto" *)
  -> ?draggable:bool
  -> ?hidden:bool
  -> ?id:string
  -> ?lang:string
  -> ?role:string (* ARIA role *)
  -> ?style:style
  -> ?spellCheck:bool
  -> ?tabIndex:int
  -> ?title:string (* html5 microdata *)
  -> ?itemID:string
  -> ?itemProp:string
  -> ?itemRef:string
  -> ?itemScope:bool
  -> ?itemType:string (* uri *)
                      (* tag-specific html attributes *)
  -> ?accept:string
  -> ?acceptCharset:string
  -> ?action:string (* uri *)
  -> ?allowFullScreen:bool
  -> ?alt:string
  -> ?async:bool
  -> ?autoComplete:
       string (* has a fixed, but large-ish, set of possible values *)
  -> ?autoFocus:bool
  -> ?autoPlay:bool
  -> ?challenge:string
  -> ?charSet:string
  -> ?checked:bool
  -> ?cite:string (* uri *)
  -> ?crossorigin:bool
  -> ?cols:int
  -> ?colSpan:int
  -> ?content:string
  -> ?controls:bool
  -> ?coords:string (* set of values specifying the coordinates of a region *)
  -> ?data:string (* uri *)
  -> ?dateTime:string (* "valid date string with optional time" *)
  -> ?default:bool
  -> ?defer:bool
  -> ?disabled:bool
  -> ?download:
       string
       (* should really be either a boolean, signifying presence, or a string *)
  -> ?encType:
       string
       (* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" *)
  -> ?form:string
  -> ?formAction:string (* uri *)
  -> ?formTarget:string (* "_blank", "_self", etc. *)
  -> ?formMethod:string (* "post", "get", "put" *)
  -> ?headers:string
  -> ?height:
       string
       (* in html5 this can only be a number, but in html4 it can ba a percentage as well *)
  -> ?high:int
  -> ?href:string (* uri *)
  -> ?hrefLang:string
  -> ?htmlFor:string (* substitute for "for" *)
  -> ?httpEquiv:string (* has a fixed set of possible values *)
  -> ?icon:string (* uri? *)
  -> ?inputMode:string (* "verbatim", "latin", "numeric", etc. *)
  -> ?integrity:string
  -> ?keyType:string
  -> ?kind:string (* has a fixed set of possible values *)
  -> ?label:string
  -> ?list:string
  -> ?loop:bool
  -> ?low:int
  -> ?manifest:string (* uri *)
  -> ?max:string (* should be int or Js.Date.t *)
  -> ?maxLength:int
  -> ?media:string (* a valid media query *)
  -> ?mediaGroup:string
  -> ?method_:(string[@js "method"])
  -> ?min:(* "post" or "get" *)
          int
  -> ?minLength:int
  -> ?multiple:bool
  -> ?muted:bool
  -> ?name:string
  -> ?nonce:string
  -> ?noValidate:bool
  -> ?open_:(bool[@js "open"])
  -> ?optimum:(* use this one. Previous one is deprecated *)
              int
  -> ?pattern:string (* valid Js RegExp *)
  -> ?placeholder:string
  -> ?poster:string (* uri *)
  -> ?preload:
       string
       (* "none", "metadata" or "auto" (and "" as a synonym for "auto") *)
  -> ?radioGroup:string
  -> ?readOnly:bool
  -> ?rel:
       string
       (* a space- or comma-separated (depending on the element) list of a fixed set of "link types" *)
  -> ?required:bool
  -> ?reversed:bool
  -> ?rows:int
  -> ?rowSpan:int
  -> ?sandbox:string (* has a fixed set of possible values *)
  -> ?scope:string (* has a fixed set of possible values *)
  -> ?scoped:bool
  -> ?scrolling:
       string
       (* html4 only, "auto", "yes" or "no" *)
       (* seamless - supported by React, but removed from the html5 spec *)
  -> ?selected:bool
  -> ?shape:string
  -> ?size:int
  -> ?sizes:string
  -> ?span:int
  -> ?src:string (* uri *)
  -> ?srcDoc:string
  -> ?srcLang:string
  -> ?srcSet:string
  -> ?start:int
  -> ?step:float
  -> ?summary:string (* deprecated *)
  -> ?target:string
  -> ?type_:(string[@js "type"])
  -> ?useMap:
       (* has a fixed but large-ish set of possible values *)
       (* use this one. Previous one is deprecated *)
       string
  -> ?value:string
  -> ?width:
       string
       (* in html5 this can only be a number, but in html4 it can ba a percentage as well *)
  -> ?wrap:
       string
       (* "hard" or "soft" *)
       (* Clipboard events *)
  -> ?onCopy:(ReactEvent.Clipboard.t -> unit)
  -> ?onCut:(ReactEvent.Clipboard.t -> unit)
  -> ?onPaste:(ReactEvent.Clipboard.t -> unit)
  -> ?onCompositionEnd:
       ((* Composition events *)
        ReactEvent.Composition.t -> unit)
  -> ?onCompositionStart:(ReactEvent.Composition.t -> unit)
  -> ?onCompositionUpdate:(ReactEvent.Composition.t -> unit)
  -> ?onKeyDown:((* Keyboard events *)
                 ReactEvent.Keyboard.t -> unit)
  -> ?onKeyPress:(ReactEvent.Keyboard.t -> unit)
  -> ?onKeyUp:(ReactEvent.Keyboard.t -> unit)
  -> ?onFocus:((* Focus events *)
               ReactEvent.Focus.t -> unit)
  -> ?onBlur:(ReactEvent.Focus.t -> unit)
  -> ?onChange:((* Form events *)
                ReactEvent.Form.t -> unit)
  -> ?onInput:(ReactEvent.Form.t -> unit)
  -> ?onSubmit:(ReactEvent.Form.t -> unit)
  -> ?onClick:((* Mouse events *)
               ReactEvent.Mouse.t -> unit)
  -> ?onContextMenu:(ReactEvent.Mouse.t -> unit)
  -> ?onDoubleClick:(ReactEvent.Mouse.t -> unit)
  -> ?onDrag:(ReactEvent.Mouse.t -> unit)
  -> ?onDragEnd:(ReactEvent.Mouse.t -> unit)
  -> ?onDragEnter:(ReactEvent.Mouse.t -> unit)
  -> ?onDragExit:(ReactEvent.Mouse.t -> unit)
  -> ?onDragLeave:(ReactEvent.Mouse.t -> unit)
  -> ?onDragOver:(ReactEvent.Mouse.t -> unit)
  -> ?onDragStart:(ReactEvent.Mouse.t -> unit)
  -> ?onDrop:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseDown:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseEnter:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseLeave:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseMove:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseOut:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseOver:(ReactEvent.Mouse.t -> unit)
  -> ?onMouseUp:(ReactEvent.Mouse.t -> unit)
  -> ?onSelect:((* Selection events *)
                ReactEvent.Selection.t -> unit)
  -> ?onTouchCancel:((* Touch events *)
                     ReactEvent.Touch.t -> unit)
  -> ?onTouchEnd:(ReactEvent.Touch.t -> unit)
  -> ?onTouchMove:(ReactEvent.Touch.t -> unit)
  -> ?onTouchStart:(ReactEvent.Touch.t -> unit)
  -> ?onScroll:((* UI events *)
                ReactEvent.UI.t -> unit)
  -> ?onWheel:((* Wheel events *)
               ReactEvent.Wheel.t -> unit)
  -> ?onAbort:((* Media events *)
               ReactEvent.Media.t -> unit)
  -> ?onCanPlay:(ReactEvent.Media.t -> unit)
  -> ?onCanPlayThrough:(ReactEvent.Media.t -> unit)
  -> ?onDurationChange:(ReactEvent.Media.t -> unit)
  -> ?onEmptied:(ReactEvent.Media.t -> unit)
  -> ?onEncrypetd:(ReactEvent.Media.t -> unit)
  -> ?onEnded:(ReactEvent.Media.t -> unit)
  -> ?onError:(ReactEvent.Media.t -> unit)
  -> ?onLoadedData:(ReactEvent.Media.t -> unit)
  -> ?onLoadedMetadata:(ReactEvent.Media.t -> unit)
  -> ?onLoadStart:(ReactEvent.Media.t -> unit)
  -> ?onPause:(ReactEvent.Media.t -> unit)
  -> ?onPlay:(ReactEvent.Media.t -> unit)
  -> ?onPlaying:(ReactEvent.Media.t -> unit)
  -> ?onProgress:(ReactEvent.Media.t -> unit)
  -> ?onRateChange:(ReactEvent.Media.t -> unit)
  -> ?onSeeked:(ReactEvent.Media.t -> unit)
  -> ?onSeeking:(ReactEvent.Media.t -> unit)
  -> ?onStalled:(ReactEvent.Media.t -> unit)
  -> ?onSuspend:(ReactEvent.Media.t -> unit)
  -> ?onTimeUpdate:(ReactEvent.Media.t -> unit)
  -> ?onVolumeChange:(ReactEvent.Media.t -> unit)
  -> ?onWaiting:(ReactEvent.Media.t -> unit)
  -> ?onLoad:((* Image events *)
              ReactEvent.Image.t -> unit)
  -> ?onAnimationStart:
       (   (* duplicate *)
           (* ?onError: ReactEvent.Image.t -> unit=?*)
           (* Animation events *)
           ReactEvent.Animation.t
        -> unit)
  -> ?onAnimationEnd:(ReactEvent.Animation.t -> unit)
  -> ?onAnimationIteration:(ReactEvent.Animation.t -> unit)
  -> ?onTransitionEnd:((* Transition events *)
                       ReactEvent.Transition.t -> unit)
  -> ?accentHeight:(* svg *)
                   string
  -> ?accumulate:string
  -> ?additive:string
  -> ?alignmentBaseline:string
  -> ?allowReorder:string
  -> ?alphabetic:string
  -> ?amplitude:string
  -> ?arabicForm:string
  -> ?ascent:string
  -> ?attributeName:string
  -> ?attributeType:string
  -> ?autoReverse:string
  -> ?azimuth:string
  -> ?baseFrequency:string
  -> ?baseProfile:string
  -> ?baselineShift:string
  -> ?bbox:string
  -> ?begin_:(string[@js "begin"])
  -> ?bias:(* use this one. Previous one is deprecated *)
           string
  -> ?by:string
  -> ?calcMode:string
  -> ?capHeight:string
  -> ?clip:string
  -> ?clipPath:string
  -> ?clipPathUnits:string
  -> ?clipRule:string
  -> ?colorInterpolation:string
  -> ?colorInterpolationFilters:string
  -> ?colorProfile:string
  -> ?colorRendering:string
  -> ?contentScriptType:string
  -> ?contentStyleType:string
  -> ?cursor:string
  -> ?cx:string
  -> ?cy:string
  -> ?d:string
  -> ?decelerate:string
  -> ?descent:string
  -> ?diffuseConstant:string
  -> ?direction:string
  -> ?display:string
  -> ?divisor:string
  -> ?dominantBaseline:string
  -> ?dur:string
  -> ?dx:string
  -> ?dy:string
  -> ?edgeMode:string
  -> ?elevation:string
  -> ?enableBackground:string
  -> ?end_:(string[@js "end"])
  -> ?exponent:(* use this one. Previous one is deprecated *)
               string
  -> ?externalResourcesRequired:string
  -> ?fill:string
  -> ?fillOpacity:string
  -> ?fillRule:string
  -> ?filter:string
  -> ?filterRes:string
  -> ?filterUnits:string
  -> ?floodColor:string
  -> ?floodOpacity:string
  -> ?focusable:string
  -> ?fontFamily:string
  -> ?fontSize:string
  -> ?fontSizeAdjust:string
  -> ?fontStretch:string
  -> ?fontStyle:string
  -> ?fontVariant:string
  -> ?fontWeight:string
  -> ?fomat:string
  -> ?from:string
  -> ?fx:string
  -> ?fy:string
  -> ?g1:string
  -> ?g2:string
  -> ?glyphName:string
  -> ?glyphOrientationHorizontal:string
  -> ?glyphOrientationVertical:string
  -> ?glyphRef:string
  -> ?gradientTransform:string
  -> ?gradientUnits:string
  -> ?hanging:string
  -> ?horizAdvX:string
  -> ?horizOriginX:string
  -> ?ideographic:string
  -> ?imageRendering:string
  -> ?in_:(string[@js "in"])
  -> ?in2:(* use this one. Previous one is deprecated *)
          string
  -> ?intercept:string
  -> ?k:string
  -> ?k1:string
  -> ?k2:string
  -> ?k3:string
  -> ?k4:string
  -> ?kernelMatrix:string
  -> ?kernelUnitLength:string
  -> ?kerning:string
  -> ?keyPoints:string
  -> ?keySplines:string
  -> ?keyTimes:string
  -> ?lengthAdjust:string
  -> ?letterSpacing:string
  -> ?lightingColor:string
  -> ?limitingConeAngle:string
  -> ?local:string
  -> ?markerEnd:string
  -> ?markerHeight:string
  -> ?markerMid:string
  -> ?markerStart:string
  -> ?markerUnits:string
  -> ?markerWidth:string
  -> ?mask:string
  -> ?maskContentUnits:string
  -> ?maskUnits:string
  -> ?mathematical:string
  -> ?mode:string
  -> ?numOctaves:string
  -> ?offset:string
  -> ?opacity:string
  -> ?operator:string
  -> ?order:string
  -> ?orient:string
  -> ?orientation:string
  -> ?origin:string
  -> ?overflow:string
  -> ?overflowX:string
  -> ?overflowY:string
  -> ?overlinePosition:string
  -> ?overlineThickness:string
  -> ?paintOrder:string
  -> ?panose1:string
  -> ?pathLength:string
  -> ?patternContentUnits:string
  -> ?patternTransform:string
  -> ?patternUnits:string
  -> ?pointerEvents:string
  -> ?points:string
  -> ?pointsAtX:string
  -> ?pointsAtY:string
  -> ?pointsAtZ:string
  -> ?preserveAlpha:string
  -> ?preserveAspectRatio:string
  -> ?primitiveUnits:string
  -> ?r:string
  -> ?radius:string
  -> ?refX:string
  -> ?refY:string
  -> ?renderingIntent:string
  -> ?repeatCount:string
  -> ?repeatDur:string
  -> ?requiredExtensions:string
  -> ?requiredFeatures:string
  -> ?restart:string
  -> ?result:string
  -> ?rotate:string
  -> ?rx:string
  -> ?ry:string
  -> ?scale:string
  -> ?seed:string
  -> ?shapeRendering:string
  -> ?slope:string
  -> ?spacing:string
  -> ?specularConstant:string
  -> ?specularExponent:string
  -> ?speed:string
  -> ?spreadMethod:string
  -> ?startOffset:string
  -> ?stdDeviation:string
  -> ?stemh:string
  -> ?stemv:string
  -> ?stitchTiles:string
  -> ?stopColor:string
  -> ?stopOpacity:string
  -> ?strikethroughPosition:string
  -> ?strikethroughThickness:string
  -> ?string:string
  -> ?stroke:string
  -> ?strokeDasharray:string
  -> ?strokeDashoffset:string
  -> ?strokeLinecap:string
  -> ?strokeLinejoin:string
  -> ?strokeMiterlimit:string
  -> ?strokeOpacity:string
  -> ?strokeWidth:string
  -> ?surfaceScale:string
  -> ?systemLanguage:string
  -> ?tableValues:string
  -> ?targetX:string
  -> ?targetY:string
  -> ?textAnchor:string
  -> ?textDecoration:string
  -> ?textLength:string
  -> ?textRendering:string
  -> ?to_:(string[@js "to"])
  -> ?transform:(* use this one. Previous one is deprecated *)
                string
  -> ?u1:string
  -> ?u2:string
  -> ?underlinePosition:string
  -> ?underlineThickness:string
  -> ?unicode:string
  -> ?unicodeBidi:string
  -> ?unicodeRange:string
  -> ?unitsPerEm:string
  -> ?vAlphabetic:string
  -> ?vHanging:string
  -> ?vIdeographic:string
  -> ?vMathematical:string
  -> ?values:string
  -> ?vectorEffect:string
  -> ?version:string
  -> ?vertAdvX:string
  -> ?vertAdvY:string
  -> ?vertOriginX:string
  -> ?vertOriginY:string
  -> ?viewBox:string
  -> ?viewTarget:string
  -> ?visibility:string (* width::string? => *)
  -> ?widths:string
  -> ?wordSpacing:string
  -> ?writingMode:string
  -> ?x:string
  -> ?x1:string
  -> ?x2:string
  -> ?xChannelSelector:string
  -> ?xHeight:string
  -> ?xlinkActuate:string
  -> ?xlinkArcrole:string
  -> ?xlinkHref:string
  -> ?xlinkRole:string
  -> ?xlinkShow:string
  -> ?xlinkTitle:string
  -> ?xlinkType:string
  -> ?xmlns:string
  -> ?xmlnsXlink:string
  -> ?xmlBase:string
  -> ?xmlLang:string
  -> ?xmlSpace:string
  -> ?y:string
  -> ?y1:string
  -> ?y2:string
  -> ?yChannelSelector:string
  -> ?z:string
  -> ?zoomAndPan:string (* RDFa *)
  -> ?about:string
  -> ?datatype:string
  -> ?inlist:string
  -> ?prefix:string
  -> ?property:string
  -> ?resource:string
  -> ?typeof:string
  -> ?vocab:
       string
       (* react-specific *)
       (* -> ?dangerouslySetInnerHTML: {. "__html": string} *)
  -> ?suppressContentEditableWarning:bool
  -> unit
  -> domProps
  [@@js.builder]

val createDOMElementVariadic :
     string
  -> props:
       domProps
       (* props has to be non-optional as otherwise gen_js_api will put an empty list and React will break *)
  -> (React.element list[@js.variadic])
  -> React.element
  [@@js.global "__LIB__react.createElement"]

val forwardRef :
  ('props -> domRef option -> React.element) -> 'props React.component
  [@@js.custom
    (* Important: we don't want to use an arrow type to represent components (i.e. (Ojs.t -> element)) as the component function
       would get wrapped inside caml_js_wrap_callback_strict in the resulting code *)
    val forwardRefInternal : Ojs.t -> Ojs.t
      [@@js.global "__LIB__react.forwardRef"]

    let forwardRef = Obj.magic forwardRefInternal

    (* TODO: Is there a way to avoid magic? *)]

module Style : sig
  type t = style

  val make :
       ?azimuth:string
    -> ?background:string
    -> ?backgroundAttachment:string
    -> ?backgroundColor:string
    -> ?backgroundImage:string
    -> ?backgroundPosition:string
    -> ?backgroundRepeat:string
    -> ?border:string
    -> ?borderCollapse:string
    -> ?borderColor:string
    -> ?borderSpacing:string
    -> ?borderStyle:string
    -> ?borderTop:string
    -> ?borderRight:string
    -> ?borderBottom:string
    -> ?borderLeft:string
    -> ?borderTopColor:string
    -> ?borderRightColor:string
    -> ?borderBottomColor:string
    -> ?borderLeftColor:string
    -> ?borderTopStyle:string
    -> ?borderRightStyle:string
    -> ?borderBottomStyle:string
    -> ?borderLeftStyle:string
    -> ?borderTopWidth:string
    -> ?borderRightWidth:string
    -> ?borderBottomWidth:string
    -> ?borderLeftWidth:string
    -> ?borderWidth:string
    -> ?bottom:string
    -> ?captionSide:string
    -> ?clear:string
    -> ?clip:string
    -> ?color:string
    -> ?content:string
    -> ?counterIncrement:string
    -> ?counterReset:string
    -> ?cue:string
    -> ?cueAfter:string
    -> ?cueBefore:string
    -> ?cursor:string
    -> ?direction:string
    -> ?display:string
    -> ?elevation:string
    -> ?emptyCells:string
    -> ?float:string
    -> ?font:string
    -> ?fontFamily:string
    -> ?fontSize:string
    -> ?fontSizeAdjust:string
    -> ?fontStretch:string
    -> ?fontStyle:string
    -> ?fontVariant:string
    -> ?fontWeight:string
    -> ?height:string
    -> ?left:string
    -> ?letterSpacing:string
    -> ?lineHeight:string
    -> ?listStyle:string
    -> ?listStyleImage:string
    -> ?listStylePosition:string
    -> ?listStyleType:string
    -> ?margin:string
    -> ?marginTop:string
    -> ?marginRight:string
    -> ?marginBottom:string
    -> ?marginLeft:string
    -> ?markerOffset:string
    -> ?marks:string
    -> ?maxHeight:string
    -> ?maxWidth:string
    -> ?minHeight:string
    -> ?minWidth:string
    -> ?orphans:string
    -> ?outline:string
    -> ?outlineColor:string
    -> ?outlineStyle:string
    -> ?outlineWidth:string
    -> ?overflow:string
    -> ?overflowX:string
    -> ?overflowY:string
    -> ?padding:string
    -> ?paddingTop:string
    -> ?paddingRight:string
    -> ?paddingBottom:string
    -> ?paddingLeft:string
    -> ?page:string
    -> ?pageBreakAfter:string
    -> ?pageBreakBefore:string
    -> ?pageBreakInside:string
    -> ?pause:string
    -> ?pauseAfter:string
    -> ?pauseBefore:string
    -> ?pitch:string
    -> ?pitchRange:string
    -> ?playDuring:string
    -> ?position:string
    -> ?quotes:string
    -> ?richness:string
    -> ?right:string
    -> ?size:string
    -> ?speak:string
    -> ?speakHeader:string
    -> ?speakNumeral:string
    -> ?speakPunctuation:string
    -> ?speechRate:string
    -> ?stress:string
    -> ?tableLayout:string
    -> ?textAlign:string
    -> ?textDecoration:string
    -> ?textIndent:string
    -> ?textShadow:string
    -> ?textTransform:string
    -> ?top:string
    -> ?unicodeBidi:string
    -> ?verticalAlign:string
    -> ?visibility:string
    -> ?voiceFamily:string
    -> ?volume:string
    -> ?whiteSpace:string
    -> ?widows:string
    -> ?width:string
    -> ?wordSpacing:string
    -> ?zIndex:
         string
         (* Below properties based on https://www.w3.org/Style/CSS/all-properties *)
         (* Color Level 3 - REC *)
    -> ?opacity:
         string
         (* Backgrounds and Borders Level 3 - CR *)
         (* backgroundRepeat - already defined by CSS2Properties *)
         (* backgroundAttachment - already defined by CSS2Properties *)
    -> ?backgroundOrigin:string
    -> ?backgroundSize:string
    -> ?backgroundClip:string
    -> ?borderRadius:string
    -> ?borderTopLeftRadius:string
    -> ?borderTopRightRadius:string
    -> ?borderBottomLeftRadius:string
    -> ?borderBottomRightRadius:string
    -> ?borderImage:string
    -> ?borderImageSource:string
    -> ?borderImageSlice:string
    -> ?borderImageWidth:string
    -> ?borderImageOutset:string
    -> ?borderImageRepeat:string
    -> ?boxShadow:string (* Multi-column Layout - CR *)
    -> ?columns:string
    -> ?columnCount:string
    -> ?columnFill:string
    -> ?columnGap:string
    -> ?columnRule:string
    -> ?columnRuleColor:string
    -> ?columnRuleStyle:string
    -> ?columnRuleWidth:string
    -> ?columnSpan:string
    -> ?columnWidth:string
    -> ?breakAfter:string
    -> ?breakBefore:string
    -> ?breakInside:string (* Speech - CR *)
    -> ?rest:string
    -> ?restAfter:string
    -> ?restBefore:string
    -> ?speakAs:string
    -> ?voiceBalance:string
    -> ?voiceDuration:string
    -> ?voicePitch:string
    -> ?voiceRange:string
    -> ?voiceRate:string
    -> ?voiceStress:string
    -> ?voiceVolume:string (* Image Values and Replaced Content Level 3 - CR *)
    -> ?objectFit:string
    -> ?objectPosition:string
    -> ?imageResolution:string
    -> ?imageOrientation:string (* Flexible Box Layout - CR *)
    -> ?alignContent:string
    -> ?alignItems:string
    -> ?alignSelf:string
    -> ?flex:string
    -> ?flexBasis:string
    -> ?flexDirection:string
    -> ?flexFlow:string
    -> ?flexGrow:string
    -> ?flexShrink:string
    -> ?flexWrap:string
    -> ?justifyContent:string
    -> ?order:
         string
         (* Text Decoration Level 3 - CR *)
         (* textDecoration - already defined by CSS2Properties *)
    -> ?textDecorationColor:string
    -> ?textDecorationLine:string
    -> ?textDecorationSkip:string
    -> ?textDecorationStyle:string
    -> ?textEmphasis:string
    -> ?textEmphasisColor:string
    -> ?textEmphasisPosition:string
    -> ?textEmphasisStyle:
         string (* textShadow - already defined by CSS2Properties *)
    -> ?textUnderlinePosition:string (* Fonts Level 3 - CR *)
    -> ?fontFeatureSettings:string
    -> ?fontKerning:string
    -> ?fontLanguageOverride:
         string
         (* fontSizeAdjust - already defined by CSS2Properties *)
         (* fontStretch - already defined by CSS2Properties *)
    -> ?fontSynthesis:string
    -> ?forntVariantAlternates:string
    -> ?fontVariantCaps:string
    -> ?fontVariantEastAsian:string
    -> ?fontVariantLigatures:string
    -> ?fontVariantNumeric:string
    -> ?fontVariantPosition:string (* Cascading and Inheritance Level 3 - CR *)
    -> ?all:string (* Writing Modes Level 3 - CR *)
    -> ?glyphOrientationVertical:string
    -> ?textCombineUpright:string
    -> ?textOrientation:string
    -> ?writingMode:string (* Shapes Level 1 - CR *)
    -> ?shapeImageThreshold:string
    -> ?shapeMargin:string
    -> ?shapeOutside:string (* Masking Level 1 - CR *)
    -> ?clipPath:string
    -> ?clipRule:string
    -> ?mask:string
    -> ?maskBorder:string
    -> ?maskBorderMode:string
    -> ?maskBorderOutset:string
    -> ?maskBorderRepeat:string
    -> ?maskBorderSlice:string
    -> ?maskBorderSource:string
    -> ?maskBorderWidth:string
    -> ?maskClip:string
    -> ?maskComposite:string
    -> ?maskImage:string
    -> ?maskMode:string
    -> ?maskOrigin:string
    -> ?maskPosition:string
    -> ?maskRepeat:string
    -> ?maskSize:string
    -> ?maskType:string (* Compositing and Blending Level 1 - CR *)
    -> ?backgroundBlendMode:string
    -> ?isolation:string
    -> ?mixBlendMode:string (* Fragmentation Level 3 - CR *)
    -> ?boxDecorationBreak:
         string
         (* breakAfter - already defined by Multi-column Layout *)
         (* breakBefore - already defined by Multi-column Layout *)
         (* breakInside - already defined by Multi-column Layout *)
         (* Basic User Interface Level 3 - CR *)
    -> ?boxSizing:string
    -> ?caretColor:string
    -> ?navDown:string
    -> ?navLeft:string
    -> ?navRight:string
    -> ?navUp:string
    -> ?outlineOffset:string
    -> ?resize:string
    -> ?textOverflow:string (* Grid Layout Level 1 - CR *)
    -> ?grid:string
    -> ?gridArea:string
    -> ?gridAutoColumns:string
    -> ?gridAutoFlow:string
    -> ?gridAutoRows:string
    -> ?gridColumn:string
    -> ?gridColumnEnd:string
    -> ?gridColumnGap:string
    -> ?gridColumnStart:string
    -> ?gridGap:string
    -> ?gridRow:string
    -> ?gridRowEnd:string
    -> ?gridRowGap:string
    -> ?gridRowStart:string
    -> ?gridTemplate:string
    -> ?gridTemplateAreas:string
    -> ?gridTemplateColumns:string
    -> ?gridTemplateRows:string (* Will Change Level 1 - CR *)
    -> ?willChange:string (* Text Level 3 - LC *)
    -> ?hangingPunctuation:string
    -> ?hyphens:string (* letterSpacing - already defined by CSS2Properties *)
    -> ?lineBreak:string
    -> ?overflowWrap:string
    -> ?tabSize:string (* textAlign - already defined by CSS2Properties *)
    -> ?textAlignLast:string
    -> ?textJustify:string
    -> ?wordBreak:string
    -> ?wordWrap:string (* Animations - WD *)
    -> ?animation:string
    -> ?animationDelay:string
    -> ?animationDirection:string
    -> ?animationDuration:string
    -> ?animationFillMode:string
    -> ?animationIterationCount:string
    -> ?animationName:string
    -> ?animationPlayState:string
    -> ?animationTimingFunction:string (* Transitions - WD *)
    -> ?transition:string
    -> ?transitionDelay:string
    -> ?transitionDuration:string
    -> ?transitionProperty:string
    -> ?transitionTimingFunction:string (* Transforms Level 1 - WD *)
    -> ?backfaceVisibility:string
    -> ?perspective:string
    -> ?perspectiveOrigin:string
    -> ?transform:string
    -> ?transformOrigin:string
    -> ?transformStyle:
         string
         (* Box Alignment Level 3 - WD *)
         (* alignContent - already defined by Flexible Box Layout *)
         (* alignItems - already defined by Flexible Box Layout *)
    -> ?justifyItems:string
    -> ?justifySelf:string
    -> ?placeContent:string
    -> ?placeItems:string
    -> ?placeSelf:string (* Basic User Interface Level 4 - FPWD *)
    -> ?appearance:string
    -> ?caret:string
    -> ?caretAnimation:string
    -> ?caretShape:string
    -> ?userSelect:string (* Overflow Level 3 - WD *)
    -> ?maxLines:string (* Basix Box Model - WD *)
    -> ?marqueeDirection:string
    -> ?marqueeLoop:string
    -> ?marqueeSpeed:string
    -> ?marqueeStyle:string
    -> ?overflowStyle:string
    -> ?rotation:string
    -> ?rotationPoint:string (* SVG 1.1 - REC *)
    -> ?alignmentBaseline:string
    -> ?baselineShift:string
    -> ?clip:string
    -> ?clipPath:string
    -> ?clipRule:string
    -> ?colorInterpolation:string
    -> ?colorInterpolationFilters:string
    -> ?colorProfile:string
    -> ?colorRendering:string
    -> ?cursor:string
    -> ?dominantBaseline:string
    -> ?fill:string
    -> ?fillOpacity:string
    -> ?fillRule:string
    -> ?filter:string
    -> ?floodColor:string
    -> ?floodOpacity:string
    -> ?glyphOrientationHorizontal:string
    -> ?glyphOrientationVertical:string
    -> ?imageRendering:string
    -> ?kerning:string
    -> ?lightingColor:string
    -> ?markerEnd:string
    -> ?markerMid:string
    -> ?markerStart:string
    -> ?pointerEvents:string
    -> ?shapeRendering:string
    -> ?stopColor:string
    -> ?stopOpacity:string
    -> ?stroke:string
    -> ?strokeDasharray:string
    -> ?strokeDashoffset:string
    -> ?strokeLinecap:string
    -> ?strokeLinejoin:string
    -> ?strokeMiterlimit:string
    -> ?strokeOpacity:string
    -> ?strokeWidth:string
    -> ?textAnchor:string
    -> ?textRendering:string (* Ruby Layout Level 1 - WD *)
    -> ?rubyAlign:string
    -> ?rubyMerge:string
    -> ?rubyPosition:
         string
         (* Lists and Counters Level 3 - WD *)
         (* listStyle - already defined by CSS2Properties *)
         (* listStyleImage - already defined by CSS2Properties *)
         (* listStylePosition - already defined by CSS2Properties *)
         (* listStyleType - already defined by CSS2Properties *)
         (* counterIncrement - already defined by CSS2Properties *)
         (* counterReset - already defined by CSS2Properties *)
         (* Not added yet
          * -------------
          * Generated Content for Paged Media - WD
          * Generated Content Level 3 - WD
          * Line Grid Level 1 - WD
          * Regions - WD
          * Inline Layout Level 3 - WD
          * Round Display Level 1 - WD
          * Image Values and Replaced Content Level 4 - WD
          * Positioned Layout Level 3 - WD
          * Filter Effects Level 1 -  -WD
          * Exclusions Level 1 - WD
          * Text Level 4 - FPWD
          * SVG Markers - FPWD
          * Motion Path Level 1 - FPWD
          * Color Level 4 - FPWD
          * SVG Strokes - FPWD
          * Table Level 3 - FPWD
          *)
    -> unit
    -> style
    [@@js.builder]

  (* CSS2Properties: https://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSS2Properties *)
  (* let combine: (style, style) -> style =
       (a, b) -> {
         let a: Js.t({..}) = Obj.magic(a);
         let b: Js.t({..}) = Obj.magic(b);
         Js.Obj.assign(Js.Obj.assign(Js.Obj.empty(), a), b) |> Obj.magic;
       };
     let unsafeAddProp: (style, string string) -> style =
       (style, property, value) -> {
         let propStyle: style = {
           let dict = Js.Dict.empty();
           Js.Dict.set(dict, property, value);
           Obj.magic(dict);
         };
         combine(style, propStyle);
       }; *)
end
