module Props = struct
  include Dom_dsl_core.PropHelpers

  let accentHeight = string "accentHeight"

  let accumulate = string "accumulate"

  let additive = string "additive"

  let alignmentBaseline = string "alignmentBaseline"

  let allowReorder = string "allowReorder"

  let alphabetic = string "alphabetic"

  let amplitude = string "amplitude"

  let arabicForm = string "arabicForm"

  let ascent = string "ascent"

  let attributeName = string "attributeName"

  let attributeType = string "attributeType"

  let autoReverse = string "autoReverse"

  let azimuth = string "azimuth"

  let baseFrequency = string "baseFrequency"

  let baseProfile = string "baseProfile"

  let baselineShift = string "baselineShift"

  let bbox = string "bbox"

  let begin_ = string "begin" (* reserved keyword *)

  let bias = string "bias"

  let by = string "by"

  let calcMode = string "calcMode"

  let capHeight = string "capHeight"

  let clip = string "clip"

  let clipPath = string "clipPath"

  let clipPathUnits = string "clipPathUnits"

  let clipRule = string "clipRule"

  let colorInterpolation = string "colorInterpolation"

  let colorInterpolationFilters = string "colorInterpolationFilters"

  let colorProfile = string "colorProfile"

  let colorRendering = string "colorRendering"

  let contentScriptType = string "contentScriptType"

  let contentStyleType = string "contentStyleType"

  let cursor = string "cursor"

  let cx = string "cx"

  let cy = string "cy"

  let d = string "d"

  let decelerate = string "decelerate"

  let descent = string "descent"

  let diffuseConstant = string "diffuseConstant"

  let direction = string "direction"

  let display = string "display"

  let divisor = string "divisor"

  let dominantBaseline = string "dominantBaseline"

  let dur = string "dur"

  let dx = string "dx"

  let dy = string "dy"

  let edgeMode = string "edgeMode"

  let elevation = string "elevation"

  let enableBackground = string "enableBackground"

  let end_ = string "end" (* reserved keyword *)

  let exponent = string "exponent"

  let externalResourcesRequired = string "externalResourcesRequired"

  let fill = string "fill"

  let fillOpacity = string "fillOpacity"

  let fillRule = string "fillRule"

  let filter = string "filter"

  let filterRes = string "filterRes"

  let filterUnits = string "filterUnits"

  let floodColor = string "floodColor"

  let floodOpacity = string "floodOpacity"

  let focusable = string "focusable"

  let fontFamily = string "fontFamily"

  let fontSize = string "fontSize"

  let fontSizeAdjust = string "fontSizeAdjust"

  let fontStretch = string "fontStretch"

  let fontStyle = string "fontStyle"

  let fontVariant = string "fontVariant"

  let fontWeight = string "fontWeight"

  let fomat = string "fomat"

  let from = string "from"

  let fx = string "fx"

  let fy = string "fy"

  let g1 = string "g1"

  let g2 = string "g2"

  let glyphName = string "glyphName"

  let glyphOrientationHorizontal = string "glyphOrientationHorizontal"

  let glyphOrientationVertical = string "glyphOrientationVertical"

  let glyphRef = string "glyphRef"

  let gradientTransform = string "gradientTransform"

  let gradientUnits = string "gradientUnits"

  let hanging = string "hanging"

  let horizAdvX = string "horizAdvX"

  let horizOriginX = string "horizOriginX"

  let ideographic = string "ideographic"

  let imageRendering = string "imageRendering"

  let in_ = string "in" (* reserved keyword *)

  let in2 = string "in2"

  let intercept = string "intercept"

  let k = string "k"

  let k1 = string "k1"

  let k2 = string "k2"

  let k3 = string "k3"

  let k4 = string "k4"

  let kernelMatrix = string "kernelMatrix"

  let kernelUnitLength = string "kernelUnitLength"

  let kerning = string "kerning"

  let keyPoints = string "keyPoints"

  let keySplines = string "keySplines"

  let keyTimes = string "keyTimes"

  let lengthAdjust = string "lengthAdjust"

  let letterSpacing = string "letterSpacing"

  let lightingColor = string "lightingColor"

  let limitingConeAngle = string "limitingConeAngle"

  let local = string "local"

  let markerEnd = string "markerEnd"

  let markerHeight = string "markerHeight"

  let markerMid = string "markerMid"

  let markerStart = string "markerStart"

  let markerUnits = string "markerUnits"

  let markerWidth = string "markerWidth"

  let mask = string "mask"

  let maskContentUnits = string "maskContentUnits"

  let maskUnits = string "maskUnits"

  let mathematical = string "mathematical"

  let mode = string "mode"

  let numOctaves = string "numOctaves"

  let offset = string "offset"

  let opacity = string "opacity"

  let operator = string "operator"

  let order = string "order"

  let orient = string "orient"

  let orientation = string "orientation"

  let origin = string "origin"

  let overflow = string "overflow"

  let overflowX = string "overflowX"

  let overflowY = string "overflowY"

  let overlinePosition = string "overlinePosition"

  let overlineThickness = string "overlineThickness"

  let paintOrder = string "paintOrder"

  let panose1 = string "panose1"

  let pathLength = string "pathLength"

  let patternContentUnits = string "patternContentUnits"

  let patternTransform = string "patternTransform"

  let patternUnits = string "patternUnits"

  let pointerEvents = string "pointerEvents"

  let points = string "points"

  let pointsAtX = string "pointsAtX"

  let pointsAtY = string "pointsAtY"

  let pointsAtZ = string "pointsAtZ"

  let preserveAlpha = string "preserveAlpha"

  let preserveAspectRatio = string "preserveAspectRatio"

  let primitiveUnits = string "primitiveUnits"

  let r = string "r"

  let radius = string "radius"

  let refX = string "refX"

  let refY = string "refY"

  let renderingIntent = string "renderingIntent"

  let repeatCount = string "repeatCount"

  let repeatDur = string "repeatDur"

  let requiredExtensions = string "requiredExtensions"

  let requiredFeatures = string "requiredFeatures"

  let restart = string "restart"

  let result = string "result"

  let rotate = string "rotate"

  let rx = string "rx"

  let ry = string "ry"

  let scale = string "scale"

  let seed = string "seed"

  let shapeRendering = string "shapeRendering"

  let slope = string "slope"

  let spacing = string "spacing"

  let specularConstant = string "specularConstant"

  let specularExponent = string "specularExponent"

  let speed = string "speed"

  let spreadMethod = string "spreadMethod"

  let startOffset = string "startOffset"

  let stdDeviation = string "stdDeviation"

  let stemh = string "stemh"

  let stemv = string "stemv"

  let stitchTiles = string "stitchTiles"

  let stopColor = string "stopColor"

  let stopOpacity = string "stopOpacity"

  let strikethroughPosition = string "strikethroughPosition"

  let strikethroughThickness = string "strikethroughThickness"

  let string = string "string"

  let stroke = string "stroke"

  let strokeDasharray = string "strokeDasharray"

  let strokeDashoffset = string "strokeDashoffset"

  let strokeLinecap = string "strokeLinecap"

  let strokeLinejoin = string "strokeLinejoin"

  let strokeMiterlimit = string "strokeMiterlimit"

  let strokeOpacity = string "strokeOpacity"

  let strokeWidth = string "strokeWidth"

  let surfaceScale = string "surfaceScale"

  let systemLanguage = string "systemLanguage"

  let tableValues = string "tableValues"

  let targetX = string "targetX"

  let targetY = string "targetY"

  let textAnchor = string "textAnchor"

  let textDecoration = string "textDecoration"

  let textLength = string "textLength"

  let textRendering = string "textRendering"

  let to_ = string "to" (* reserved keyword *)

  let transform = string "transform"

  let u1 = string "u1"

  let u2 = string "u2"

  let underlinePosition = string "underlinePosition"

  let underlineThickness = string "underlineThickness"

  let unicode = string "unicode"

  let unicodeBidi = string "unicodeBidi"

  let unicodeRange = string "unicodeRange"

  let unitsPerEm = string "unitsPerEm"

  let vAlphabetic = string "vAlphabetic"

  let vHanging = string "vHanging"

  let vIdeographic = string "vIdeographic"

  let vMathematical = string "vMathematical"

  let values = string "values"

  let vectorEffect = string "vectorEffect"

  let version = string "version"

  let vertAdvX = string "vertAdvX"

  let vertAdvY = string "vertAdvY"

  let vertOriginX = string "vertOriginX"

  let vertOriginY = string "vertOriginY"

  let viewBox = string "viewBox"

  let viewTarget = string "viewTarget"

  let visibility = string "visibility"

  let widths = string "widths"

  let wordSpacing = string "wordSpacing"

  let writingMode = string "writingMode"

  let x = string "x"

  let x1 = string "x1"

  let x2 = string "x2"

  let xChannelSelector = string "xChannelSelector"

  let xHeight = string "xHeight"

  let xlinkActuate = string "xlinkActuate"

  let xlinkArcrole = string "xlinkArcrole"

  let xlinkHref = string "xlinkHref"

  let xlinkRole = string "xlinkRole"

  let xlinkShow = string "xlinkShow"

  let xlinkTitle = string "xlinkTitle"

  let xlinkType = string "xlinkType"

  let xmlns = string "xmlns"

  let xmlnsXlink = string "xmlnsXlink"

  let xmlBase = string "xmlBase"

  let xmlLang = string "xmlLang"

  let xmlSpace = string "xmlSpace"

  let y = string "y"

  let y1 = string "y1"

  let y2 = string "y2"

  let yChannelSelector = string "yChannelSelector"

  let z = string "z"

  let zoomAndPan = string "zoomAndPan"
end

include Dom_dsl_core.Helpers
include Dom_dsl_core.Common

let a = h "a"

let animate = h "animate"

let animateMotion = h "animateMotion"

let animateTransform = h "animateTransform"

let circle = h "circle"

let clipPath = h "clipPath"

let defs = h "defs"

let desc = h "desc"

let discard = h "discard"

let ellipse = h "ellipse"

let feBlend = h "feBlend"

let feColorMatrix = h "feColorMatrix"

let feComponentTransfer = h "feComponentTransfer"

let feComposite = h "feComposite"

let feConvolveMatrix = h "feConvolveMatrix"

let feDiffuseLighting = h "feDiffuseLighting"

let feDisplacementMap = h "feDisplacementMap"

let feDistantLight = h "feDistantLight"

let feDropShadow = h "feDropShadow"

let feFlood = h "feFlood"

let feFuncA = h "feFuncA"

let feFuncB = h "feFuncB"

let feFuncG = h "feFuncG"

let feFuncR = h "feFuncR"

let feGaussianBlur = h "feGaussianBlur"

let feImage = h "feImage"

let feMerge = h "feMerge"

let feMergeNode = h "feMergeNode"

let feMorphology = h "feMorphology"

let feOffset = h "feOffset"

let fePointLight = h "fePointLight"

let feSpecularLighting = h "feSpecularLighting"

let feSpotLight = h "feSpotLight"

let feTile = h "feTile"

let feTurbulence = h "feTurbulence"

let filter = h "filter"

let foreignObject = h "foreignObject"

let g = h "g"

let hatch = h "hatch"

let hatchpath = h "hatchpath"

let image = h "image"

let line = h "line"

let linearGradient = h "linearGradient"

let marker = h "marker"

let mask = h "mask"

let metadata = h "metadata"

let mpath = h "mpath"

let path = h "path"

let pattern = h "pattern"

let polygon = h "polygon"

let polyline = h "polyline"

let radialGradient = h "radialGradient"

let rect = h "rect"

let script = h "script"

let set = h "set"

let stop = h "stop"

let style = h "style"

let svg = h "svg"

let switch = h "switch"

let symbol = h "symbol"

let text = h "text"

let textPath = h "textPath"

let title = h "title"

let tspan = h "tspan"

let use = h "use"

let view = h "view"
