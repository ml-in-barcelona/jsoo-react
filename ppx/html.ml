let ( & ) = List.append

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

type element = {tag: string; attributes: prop list}

let attributeReferrerPolicy = String
(* | Empty
   | NoReferrer
   | NoReferrerWhenDowngrade
   | Origin
   | OriginWhenCrossOrigin
   | SameOrigin
   | StrictOrigin
   | StrictOriginWhenCrossOrigin
   | UnsafeUrl *)

let attributeAnchorTarget = String
(* | Self
   | Blank
   | Parent
   | Top
   | Custom of String *)

let commonDOMAttributes =
  [ (*
       // Clipboard Events
       onCopy?: ClipboardEventHandler<T>;
       onCopyCapture?: ClipboardEventHandler<T>;
       onCut?: ClipboardEventHandler<T>;
       onCutCapture?: ClipboardEventHandler<T>;
       onPaste?: ClipboardEventHandler<T>;
       onPasteCapture?: ClipboardEventHandler<T>;

       // Composition Events
       onCompositionEnd?: CompositionEventHandler<T>;
       onCompositionEndCapture?: CompositionEventHandler<T>;
       onCompositionStart?: CompositionEventHandler<T>;
       onCompositionStartCapture?: CompositionEventHandler<T>;
       onCompositionUpdate?: CompositionEventHandler<T>;
       onCompositionUpdateCapture?: CompositionEventHandler<T>;

       // Focus Events
       onFocus?: FocusEventHandler<T>;
       onFocusCapture?: FocusEventHandler<T>;
       onBlur?: FocusEventHandler<T>;
       onBlurCapture?: FocusEventHandler<T>;

       // Form Events
       onChange?: FormEventHandler<T>;
       onChangeCapture?: FormEventHandler<T>;
       onBeforeInput?: FormEventHandler<T>;
       onBeforeInputCapture?: FormEventHandler<T>;
       onInput?: FormEventHandler<T>;
       onInputCapture?: FormEventHandler<T>;
       onReset?: FormEventHandler<T>;
       onResetCapture?: FormEventHandler<T>;
       onSubmit?: FormEventHandler<T>;
       onSubmitCapture?: FormEventHandler<T>;
       onInvalid?: FormEventHandler<T>;
       onInvalidCapture?: FormEventHandler<T>;

       // Image Events
       onLoad?: ReactEventHandler<T>;
       onLoadCapture?: ReactEventHandler<T>;
       onError?: ReactEventHandler<T>; // also a Media Event
       onErrorCapture?: ReactEventHandler<T>; // also a Media Event

       // Keyboard Events
       onKeyDown?: KeyboardEventHandler<T>;
       onKeyDownCapture?: KeyboardEventHandler<T>;
       onKeyPress?: KeyboardEventHandler<T>;
       onKeyPressCapture?: KeyboardEventHandler<T>;
       onKeyUp?: KeyboardEventHandler<T>;
       onKeyUpCapture?: KeyboardEventHandler<T>;

       // Media Events
       onAbort?: ReactEventHandler<T>;
       onAbortCapture?: ReactEventHandler<T>;
       onCanPlay?: ReactEventHandler<T>;
       onCanPlayCapture?: ReactEventHandler<T>;
       onCanPlayThrough?: ReactEventHandler<T>;
       onCanPlayThroughCapture?: ReactEventHandler<T>;
       onDurationChange?: ReactEventHandler<T>;
       onDurationChangeCapture?: ReactEventHandler<T>;
       onEmptied?: ReactEventHandler<T>;
       onEmptiedCapture?: ReactEventHandler<T>;
       onEncrypted?: ReactEventHandler<T>;
       onEncryptedCapture?: ReactEventHandler<T>;
       onEnded?: ReactEventHandler<T>;
       onEndedCapture?: ReactEventHandler<T>;
       onLoadedData?: ReactEventHandler<T>;
       onLoadedDataCapture?: ReactEventHandler<T>;
       onLoadedMetadata?: ReactEventHandler<T>;
       onLoadedMetadataCapture?: ReactEventHandler<T>;
       onLoadStart?: ReactEventHandler<T>;
       onLoadStartCapture?: ReactEventHandler<T>;
       onPause?: ReactEventHandler<T>;
       onPauseCapture?: ReactEventHandler<T>;
       onPlay?: ReactEventHandler<T>;
       onPlayCapture?: ReactEventHandler<T>;
       onPlaying?: ReactEventHandler<T>;
       onPlayingCapture?: ReactEventHandler<T>;
       onProgress?: ReactEventHandler<T>;
       onProgressCapture?: ReactEventHandler<T>;
       onRateChange?: ReactEventHandler<T>;
       onRateChangeCapture?: ReactEventHandler<T>;
       onSeeked?: ReactEventHandler<T>;
       onSeekedCapture?: ReactEventHandler<T>;
       onSeeking?: ReactEventHandler<T>;
       onSeekingCapture?: ReactEventHandler<T>;
       onStalled?: ReactEventHandler<T>;
       onStalledCapture?: ReactEventHandler<T>;
       onSuspend?: ReactEventHandler<T>;
       onSuspendCapture?: ReactEventHandler<T>;
       onTimeUpdate?: ReactEventHandler<T>;
       onTimeUpdateCapture?: ReactEventHandler<T>;
       onVolumeChange?: ReactEventHandler<T>;
       onVolumeChangeCapture?: ReactEventHandler<T>;
       onWaiting?: ReactEventHandler<T>;
       onWaitingCapture?: ReactEventHandler<T>;

       // MouseEvents
       onAuxClick?: MouseEventHandler<T>;
       onAuxClickCapture?: MouseEventHandler<T>;
       onClick?: MouseEventHandler<T>;
       onClickCapture?: MouseEventHandler<T>;
       onContextMenu?: MouseEventHandler<T>;
       onContextMenuCapture?: MouseEventHandler<T>;
       onDoubleClick?: MouseEventHandler<T>;
       onDoubleClickCapture?: MouseEventHandler<T>;
       onDrag?: DragEventHandler<T>;
       onDragCapture?: DragEventHandler<T>;
       onDragEnd?: DragEventHandler<T>;
       onDragEndCapture?: DragEventHandler<T>;
       onDragEnter?: DragEventHandler<T>;
       onDragEnterCapture?: DragEventHandler<T>;
       onDragExit?: DragEventHandler<T>;
       onDragExitCapture?: DragEventHandler<T>;
       onDragLeave?: DragEventHandler<T>;
       onDragLeaveCapture?: DragEventHandler<T>;
       onDragOver?: DragEventHandler<T>;
       onDragOverCapture?: DragEventHandler<T>;
       onDragStart?: DragEventHandler<T>;
       onDragStartCapture?: DragEventHandler<T>;
       onDrop?: DragEventHandler<T>;
       onDropCapture?: DragEventHandler<T>;
       onMouseDown?: MouseEventHandler<T>;
       onMouseDownCapture?: MouseEventHandler<T>;
       onMouseEnter?: MouseEventHandler<T>;
       onMouseLeave?: MouseEventHandler<T>;
       onMouseMove?: MouseEventHandler<T>;
       onMouseMoveCapture?: MouseEventHandler<T>;
       onMouseOut?: MouseEventHandler<T>;
       onMouseOutCapture?: MouseEventHandler<T>;
       onMouseOver?: MouseEventHandler<T>;
       onMouseOverCapture?: MouseEventHandler<T>;
       onMouseUp?: MouseEventHandler<T>;
       onMouseUpCapture?: MouseEventHandler<T>;

       // Selection Events
       onSelect?: ReactEventHandler<T>;
       onSelectCapture?: ReactEventHandler<T>;

       // Touch Events
       onTouchCancel?: TouchEventHandler<T>;
       onTouchCancelCapture?: TouchEventHandler<T>;
       onTouchEnd?: TouchEventHandler<T>;
       onTouchEndCapture?: TouchEventHandler<T>;
       onTouchMove?: TouchEventHandler<T>;
       onTouchMoveCapture?: TouchEventHandler<T>;
       onTouchStart?: TouchEventHandler<T>;
       onTouchStartCapture?: TouchEventHandler<T>;

       // Pointer Events
       onPointerDown?: PointerEventHandler<T>;
       onPointerDownCapture?: PointerEventHandler<T>;
       onPointerMove?: PointerEventHandler<T>;
       onPointerMoveCapture?: PointerEventHandler<T>;
       onPointerUp?: PointerEventHandler<T>;
       onPointerUpCapture?: PointerEventHandler<T>;
       onPointerCancel?: PointerEventHandler<T>;
       onPointerCancelCapture?: PointerEventHandler<T>;
       onPointerEnter?: PointerEventHandler<T>;
       onPointerEnterCapture?: PointerEventHandler<T>;
       onPointerLeave?: PointerEventHandler<T>;
       onPointerLeaveCapture?: PointerEventHandler<T>;
       onPointerOver?: PointerEventHandler<T>;
       onPointerOverCapture?: PointerEventHandler<T>;
       onPointerOut?: PointerEventHandler<T>;
       onPointerOutCapture?: PointerEventHandler<T>;
       onGotPointerCapture?: PointerEventHandler<T>;
       onGotPointerCaptureCapture?: PointerEventHandler<T>;
       onLostPointerCapture?: PointerEventHandler<T>;
       onLostPointerCaptureCapture?: PointerEventHandler<T>;

       // UI Events
       onScroll?: UIEventHandler<T>;
       onScrollCapture?: UIEventHandler<T>;

       // Wheel Events
       onWheel?: WheelEventHandler<T>;
       onWheelCapture?: WheelEventHandler<T>;

       // Animation Events
       onAnimationStart?: AnimationEventHandler<T>;
       onAnimationStartCapture?: AnimationEventHandler<T>;
       onAnimationEnd?: AnimationEventHandler<T>;
       onAnimationEndCapture?: AnimationEventHandler<T>;
       onAnimationIteration?: AnimationEventHandler<T>;
       onAnimationIterationCapture?: AnimationEventHandler<T>;

       // Transition Events
       onTransitionEnd?: TransitionEventHandler<T>;
       onTransitionEndCapture?: TransitionEventHandler<T>; *) ]

(* All the WAI-ARIA 1.1 attributes from https://www.w3.org/TR/wai-aria-1.1/ *)
let ariaAttributes =
  [ (* Identifies the currently active element when DOM focus is on a composite widget, textbox, group, or application. *)
    Attribute
      { name= "ariaActivedescendant"
      ; htmlName= "aria-activedescendant"
      ; type_= String }
  ; (* Indicates whether assistive technologies will present all, or only parts of, the changed region based on the change notifications defined by the aria-relevant attribute. *)
    Attribute
      { name= "ariaAtomic"
      ; htmlName= "aria-atomic"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates whether inputting text could trigger display of one or more predictions of the user's intended value for an input and specifies how predictions would be
     * presented if they are made.
     *)
    Attribute
      { name= "ariaAutocomplete"
      ; htmlName= "aria-autocomplete"
      ; type_= String (* 'none' | 'inline' | 'list' | 'both' *) }
  ; (* Indicates an element is being modified and that assistive technologies MAY want to wait until the modifications are complete before exposing them to the user. *)
    Attribute
      { name= "ariaBusy"
      ; htmlName= "aria-busy"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates the current "checked" state of checkboxes, radio buttons, and other widgets.
     * @see aria-pressed @see aria-selected.
     *)
    Attribute
      { name= "ariaChecked"
      ; htmlName= "aria-checked"
      ; type_= String (* Bool | 'false' | 'mixed' | 'true' *) }
  ; (*
     * Defines the total number of columns in a table, grid, or treegrid.
     * @see aria-colindex.
     *)
    Attribute {name= "ariaColcount"; htmlName= "aria-colcount"; type_= Int}
  ; (*
     * Defines an element's column index or position with respect to the total number of columns within a table, grid, or treegrid.
     * @see aria-colcount @see aria-colspan.
     *)
    Attribute {name= "ariaColindex"; htmlName= "aria-colindex"; type_= Int}
  ; (*
     * Defines the number of columns spanned by a cell or gridcell within a table, grid, or treegrid.
     * @see aria-colindex @see aria-rowspan.
     *)
    Attribute {name= "ariaColspan"; htmlName= "aria-colspan"; type_= Int}
  ; (*
     * Identifies the element (or elements) whose contents or presence are controlled by the current element.
     * @see aria-owns.
     *)
    Attribute {name= "ariaControls"; htmlName= "aria-controls"; type_= String}
  ; (* Indicates the element that represents the current item within a container or set of related elements. *)
    Attribute
      { name= "ariaCurrent"
      ; htmlName= "aria-current"
      ; type_=
          String
          (* Bool | 'false' | 'true' |  'page' | 'step' | 'location' | 'date' | 'time' *)
      }
  ; (*
     * Identifies the element (or elements) that describes the object.
     * @see aria-labelledby
     *)
    Attribute
      {name= "ariaDescribedby"; htmlName= "aria-describedby"; type_= String}
  ; (*
     * Identifies the element that provides a detailed, extended description for the object.
     * @see aria-describedby.
     *)
    Attribute {name= "ariaDetails"; htmlName= "aria-details"; type_= String}
  ; (*
     * Indicates that the element is perceivable but disabled, so it is not editable or otherwise operable.
     * @see aria-hidden @see aria-readonly.
     *)
    Attribute
      { name= "ariaDisabled"
      ; htmlName= "aria-disabled"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates what functions can be performed when a dragged object is released on the drop target.
     * @deprecated in ARIA 1.1
     *)
    Attribute
      { name= "ariaDropeffect"
      ; htmlName= "aria-dropeffect"
      ; type_=
          String (* 'none' | 'copy' | 'execute' | 'link' | 'move' | 'popup' *)
      }
  ; (*
     * Identifies the element that provides an error message for the object.
     * @see aria-invalid @see aria-describedby.
     *)
    Attribute
      {name= "ariaErrormessage"; htmlName= "aria-errormessage"; type_= String}
  ; (* Indicates whether the element, or another grouping element it controls, is currently expanded or collapsed. *)
    Attribute
      { name= "ariaExpanded"
      ; htmlName= "aria-expanded"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Identifies the next element (or elements) in an alternate reading order of content which, at the user's discretion,
     * allows assistive technology to override the general default of reading in document source order.
     *)
    Attribute {name= "ariaFlowto"; htmlName= "aria-flowto"; type_= String}
  ; (*
     * Indicates an element's "grabbed" state in a drag-and-drop operation.
     * @deprecated in ARIA 1.1
     *)
    Attribute
      { name= "ariaGrabbed"
      ; htmlName= "aria-grabbed"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (* Indicates the availability and type of interactive popup element, such as menu or dialog, that can be triggered by an element. *)
    Attribute
      { name= "ariaHaspopup"
      ; htmlName= "aria-haspopup"
      ; type_=
          String
          (* Bool | 'false' | 'true' | 'menu' | 'listbox' | 'tree' | 'grid' | 'dialog'; *)
      }
  ; (*
     * Indicates whether the element is exposed to an accessibility API.
     * @see aria-disabled.
     *)
    Attribute
      { name= "ariaHidden"
      ; htmlName= "aria-hidden"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates the entered value does not conform to the format expected by the application.
     * @see aria-errormessage.
     *)
    Attribute
      { name= "ariaInvalid"
      ; htmlName= "aria-invalid"
      ; type_= String (* Bool | 'false' | 'true' |  'grammar' | 'spelling'; *)
      }
  ; (* Indicates keyboard shortcuts that an author has implemented to activate or give focus to an element. *)
    Attribute
      {name= "ariaKeyshortcuts"; htmlName= "aria-keyshortcuts"; type_= String}
  ; (*
     * Defines a String value that labels the current element.
     * @see aria-labelledby.
     *)
    Attribute {name= "ariaLabel"; htmlName= "aria-label"; type_= String}
  ; (*
     * Identifies the element (or elements) that labels the current element.
     * @see aria-describedby.
     *)
    Attribute
      {name= "ariaLabelledby"; htmlName= "aria-labelledby"; type_= String}
  ; (*Defines the hierarchical level of an element within a structure. *)
    Attribute {name= "ariaLevel"; htmlName= "aria-level"; type_= Int}
  ; (* Indicates that an element will be updated, and describes the types of updates the user agents, assistive technologies, and user can expect from the live region. *)
    Attribute
      { name= "ariaLive"
      ; htmlName= "aria-live"
      ; type_= String (* 'off' | 'assertive' | 'polite' *) }
  ; (* Indicates whether an element is modal when displayed. *)
    Attribute
      { name= "ariaModal"
      ; htmlName= "aria-modal"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (* Indicates whether a text box accepts multiple lines of input or only a single line. *)
    Attribute
      { name= "ariaMultiline"
      ; htmlName= "aria-multiline"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (* Indicates that the user may select more than one item from the current selectable descendants. *)
    Attribute
      { name= "ariaMultiselectable"
      ; htmlName= "aria-multiselectable"
      ; type_= String (* Bool |  'false' | 'true' *) }
  ; (* Indicates whether the element's orientation is horizontal, vertical, or unknown/ambiguous. *)
    Attribute
      { name= "ariaOrientation"
      ; htmlName= "aria-orientation"
      ; type_= String (* 'horizontal' | 'vertical' *) }
  ; (*
     * Identifies an element (or elements) in order to define a visual, functional, or contextual parent/child relationship
     * between DOM elements where the DOM hierarchy cannot be used to represent the relationship.
     * @see aria-controls.
     *)
    Attribute {name= "ariaOwns"; htmlName= "aria-owns"; type_= String}
  ; (*
     * Defines a short hint (a word or short phrase) intended to aid the user with data entry when the control has no value.
     * A hint could be a sample value or a brief description of the expected format.
     *)
    Attribute
      {name= "ariaPlaceholder"; htmlName= "aria-placeholder"; type_= String}
  ; (*
     * Defines an element's number or position in the current set of listitems or treeitems. Not required if all elements in the set are present in the DOM.
     * @see aria-setsize.
     *)
    Attribute {name= "ariaPosinset"; htmlName= "aria-posinset"; type_= Int}
  ; (*
     * Indicates the current "pressed" state of toggle buttons.
     * @see aria-checked @see aria-selected.
     *)
    Attribute
      { name= "ariaPressed"
      ; htmlName= "aria-pressed"
      ; type_= String (* Bool | 'false' | 'mixed' | 'true' *) }
  ; (*
     * Indicates that the element is not editable, but is otherwise operable.
     * @see aria-disabled.
     *)
    Attribute
      { name= "ariaReadonly"
      ; htmlName= "aria-readonly"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates what notifications the user agent will trigger when the accessibility tree within a live region is modified.
     * @see aria-atomic.
     *)
    Attribute
      { name= "ariaRelevant"
      ; htmlName= "aria-relevant"
      ; type_=
          String
          (* 'additions' | 'additions removals' | 'additions text' | 'all' | 'removals' | 'removals additions' | 'removals text' | 'text' | 'text additions' | 'text removals' *)
      }
  ; (* Indicates that user input is required on the element before a form may be submitted. *)
    Attribute
      { name= "ariaRequired"
      ; htmlName= "aria-required"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*Defines a human-readable, author-localized description for the role of an element. *)
    Attribute
      { name= "ariaRoledescription"
      ; htmlName= "aria-roledescription"
      ; type_= String }
  ; (*
     * Defines the total number of rows in a table, grid, or treegrid.
     * @see aria-rowindex.
     *)
    Attribute {name= "ariaRowcount"; htmlName= "aria-rowcount"; type_= Int}
  ; (*
     * Defines an element's row index or position with respect to the total number of rows within a table, grid, or treegrid.
     * @see aria-rowcount @see aria-rowspan.
     *)
    Attribute {name= "ariaRowindex"; htmlName= "aria-rowindex"; type_= Int}
  ; (*
     * Defines the number of rows spanned by a cell or gridcell within a table, grid, or treegrid.
     * @see aria-rowindex @see aria-colspan.
     *)
    Attribute {name= "ariaRowspan"; htmlName= "aria-rowspan"; type_= Int}
  ; (*
     * Indicates the current "selected" state of various widgets.
     * @see aria-checked @see aria-pressed.
     *)
    Attribute
      { name= "ariaSelected"
      ; htmlName= "aria-selected"
      ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Defines the number of items in the current set of listitems or treeitems. Not required if all elements in the set are present in the DOM.
     * @see aria-posinset.
     *)
    Attribute {name= "ariaSetsize"; htmlName= "aria-setsize"; type_= Int}
  ; (* Indicates if items in a table or grid are sorted in ascending or descending order. *)
    Attribute
      { name= "ariaSort"
      ; htmlName= "aria-sort"
      ; type_= String (* 'none' | 'ascending' | 'descending' | 'other' *) }
  ; (*Defines the maximum allowed value for a range widget. *)
    Attribute {name= "ariaValuemax"; htmlName= "aria-valuemax"; type_= Int}
  ; (*Defines the minimum allowed value for a range widget. *)
    Attribute {name= "ariaValuemin"; htmlName= "aria-valuemin"; type_= Int}
  ; (*
     * Defines the current value for a range widget.
     * @see aria-valuetext.
     *)
    Attribute {name= "ariaValuenow"; htmlName= "aria-valuenow"; type_= Int}
  ; (*Defines the human readable text alternative of aria-valuenow for a range widget. *)
    Attribute {name= "ariaValuetext"; htmlName= "aria-valuetext"; type_= String}
  ]

(* All the WAI-ARIA 1.1 role attribute values from https://www.w3.org/TR/wai-aria-1.1/#role_definitions *)
let ariaRole = String
(* | Alert
   | Alertdialog
   | Application
   | Article
   | Banner
   | Button
   | Cell
   | Checkbox
   | Columnheader
   | Combobox
   | Complementary
   | Contentinfo
   | Definition
   | Dialog
   | Directory
   | Document
   | Feed
   | Figure
   | Form
   | Grid
   | Gridcell
   | Group
   | Heading
   | Img
   | Link
   | List
   | Listbox
   | Listitem
   | Log
   | Main
   | Marquee
   | Math
   | Menu
   | Menubar
   | Menuitem
   | Menuitemcheckbox
   | Menuitemradio
   | Navigation
   | None
   | Note
   | Option
   | Presentation
   | Progressbar
   | Radio
   | Radiogroup
   | Region
   | Row
   | Rowgroup
   | Rowheader
   | Scrollbar
   | Search
   | Searchbox
   | Separator
   | Slider
   | Spinbutton
   | Status
   | Switch
   | Tab
   | Table
   | Tablist
   | Tabpanel
   | Term
   | Textbox
   | Timer
   | Toolbar
   | Tooltip
   | Tree
   | Treegrid
   | Treeitem
   | Custom of String *)

(* AriaAttributes, DOMAttributes*)
let attributesHTML =
  [ (* React-specific Attributes *)
    Attribute
      { name= "dangerouslySetInnerHTML"
      ; type_= InnerHtml
      ; htmlName= "dangerouslySetInnerHTML" }
  ; Attribute {name= "defaultChecked"; type_= Bool; htmlName= ""}
  ; Attribute
      { name= "defaultValue"
      ; type_= String (* | number | ReadonlyArray<String> *)
      ; htmlName= "" }
  ; Attribute {name= "suppressContentEditableWarning"; type_= Bool; htmlName= ""}
  ; Attribute {name= "suppressHydrationWarning"; type_= Bool; htmlName= ""}
  ; (* Standard HTML Attributes *)
    Attribute {name= "accessKey"; type_= String; htmlName= ""}
  ; Attribute {name= "className"; type_= String; htmlName= ""}
  ; Attribute {name= "contextMenu"; type_= String; htmlName= ""}
  ; Attribute {name= "dir"; type_= String; htmlName= ""}
  ; Attribute {name= "draggable"; type_= String (* Booleanish *); htmlName= ""}
  ; Attribute {name= "hidden"; type_= Bool; htmlName= ""}
  ; Attribute {name= "id"; type_= String; htmlName= ""}
  ; Attribute {name= "lang"; type_= String; htmlName= ""}
  ; Attribute {name= "placeholder"; type_= String; htmlName= ""}
  ; Attribute {name= "slot"; type_= String; htmlName= ""}
  ; Attribute {name= "spellCheck"; type_= String (* Booleanish *); htmlName= ""}
  ; Attribute {name= "style"; type_= Style; htmlName= ""}
  ; Attribute {name= "tabIndex"; type_= Int; htmlName= ""}
  ; Attribute {name= "title"; type_= String; htmlName= ""}
  ; Attribute {name= "translate"; type_= String (* 'yes' | 'no' *); htmlName= ""}
  ; (* Unknown *)
    Attribute {name= "radioGroup"; type_= String; htmlName= ""}
  ; (* <command>, <menuitem> *)

    (* WAI-ARIA *)
    Attribute {name= "role"; type_= ariaRole; htmlName= ""}
  ; (* RDFa Attributes *)
    Attribute {name= "about"; type_= String; htmlName= ""}
  ; Attribute {name= "datatype"; type_= String; htmlName= ""}
  ; Attribute {name= "inlist"; type_= String (* any *); htmlName= ""}
  ; Attribute {name= "prefix"; type_= String; htmlName= ""}
  ; Attribute {name= "property"; type_= String; htmlName= ""}
  ; Attribute {name= "resource"; type_= String; htmlName= ""}
  ; Attribute {name= "typeof"; type_= String; htmlName= ""}
  ; Attribute {name= "vocab"; type_= String; htmlName= ""}
  ; (* Non-standard Attributes *)
    Attribute {name= "autoCapitalize"; type_= String; htmlName= ""}
  ; Attribute {name= "autoCorrect"; type_= String; htmlName= ""}
  ; Attribute {name= "autoSave"; type_= String; htmlName= ""}
  ; Attribute {name= "color"; type_= String; htmlName= ""}
  ; Attribute {name= "itemProp"; type_= String; htmlName= ""}
  ; Attribute {name= "itemScope"; type_= Bool; htmlName= ""}
  ; Attribute {name= "itemType"; type_= String; htmlName= ""}
  ; Attribute {name= "itemID"; type_= String; htmlName= ""}
  ; Attribute {name= "itemRef"; type_= String; htmlName= ""}
  ; Attribute {name= "results"; type_= Int; htmlName= ""}
  ; Attribute {name= "security"; type_= String; htmlName= ""}
    (* Living Standard

         * Hints at the type of data that might be entered by the user while editing the element or its contents
         * @see https://html.spec.whatwg.org/multipage/interaction.html#input-modalities:-the-inputmode-attribute *)
  ; Attribute
      { name= "inputMode"
      ; type_=
          String
          (* 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search' *)
      ; htmlName= "" }
  ; (* * Specify that a standard HTML element should behave like a defined custom built-in element
       * @see https://html.spec.whatwg.org/multipage/custom-elements.html#attr-is *)
    Attribute {name= "is"; type_= String; htmlName= ""} ]

let allHTMLAttributes =
  [ (* Standard HTML Attributes *)
    Attribute {name= "accept"; type_= String; htmlName= ""}
  ; Attribute {name= "acceptCharset"; type_= String; htmlName= ""}
  ; Attribute {name= "action"; type_= String; htmlName= ""}
  ; Attribute {name= "allowFullScreen"; type_= Bool; htmlName= ""}
  ; Attribute {name= "allowTransparency"; type_= Bool; htmlName= ""}
  ; Attribute {name= "alt"; type_= String; htmlName= ""}
  ; Attribute {name= "as"; type_= String; htmlName= ""}
  ; Attribute {name= "async"; type_= Bool; htmlName= ""}
  ; Attribute {name= "autoComplete"; type_= String; htmlName= ""}
  ; Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute {name= "autoPlay"; type_= Bool; htmlName= ""}
  ; Attribute {name= "capture"; type_= (* Bool |  *) String; htmlName= ""}
  ; Attribute {name= "cellPadding"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "cellSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "charSet"; type_= String; htmlName= ""}
  ; Attribute {name= "challenge"; type_= String; htmlName= ""}
  ; Attribute {name= "checked"; type_= Bool; htmlName= ""}
  ; Attribute {name= "cite"; type_= String; htmlName= ""}
  ; Attribute {name= "classID"; type_= String; htmlName= ""}
  ; Attribute {name= "cols"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "colSpan"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "content"; type_= String; htmlName= ""}
  ; Attribute {name= "controls"; type_= Bool; htmlName= ""}
  ; Attribute {name= "coords"; type_= String; htmlName= ""}
  ; Attribute {name= "crossOrigin"; type_= String; htmlName= ""}
  ; Attribute {name= "data"; type_= String; htmlName= ""}
  ; Attribute {name= "dateTime"; type_= String; htmlName= ""}
  ; Attribute {name= "default"; type_= Bool; htmlName= ""}
  ; Attribute {name= "defer"; type_= Bool; htmlName= ""}
  ; Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "download"; type_= String (* any *); htmlName= ""}
  ; Attribute {name= "encType"; type_= String; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "formAction"; type_= String; htmlName= ""}
  ; Attribute {name= "formEncType"; type_= String; htmlName= ""}
  ; Attribute {name= "formMethod"; type_= String; htmlName= ""}
  ; Attribute {name= "formNoValidate"; type_= Bool; htmlName= ""}
  ; Attribute {name= "formTarget"; type_= String; htmlName= ""}
  ; Attribute {name= "frameBorder"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "headers"; type_= String; htmlName= ""}
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "high"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "href"; type_= String; htmlName= ""}
  ; Attribute {name= "hrefLang"; type_= String; htmlName= ""}
  ; Attribute {name= "htmlFor"; type_= String; htmlName= ""}
  ; Attribute {name= "httpEquiv"; type_= String; htmlName= ""}
  ; Attribute {name= "integrity"; type_= String; htmlName= ""}
  ; Attribute {name= "keyParams"; type_= String; htmlName= ""}
  ; Attribute {name= "keyType"; type_= String; htmlName= ""}
  ; Attribute {name= "kind"; type_= String; htmlName= ""}
  ; Attribute {name= "label"; type_= String; htmlName= ""}
  ; Attribute {name= "list"; type_= String; htmlName= ""}
  ; Attribute {name= "loop"; type_= Bool; htmlName= ""}
  ; Attribute {name= "low"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "manifest"; type_= String; htmlName= ""}
  ; Attribute {name= "marginHeight"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "marginWidth"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "maxLength"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "media"; type_= String; htmlName= ""}
  ; Attribute {name= "mediaGroup"; type_= String; htmlName= ""}
  ; Attribute {name= "method"; type_= String; htmlName= ""}
  ; Attribute {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "minLength"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "multiple"; type_= Bool; htmlName= ""}
  ; Attribute {name= "muted"; type_= Bool; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "nonce"; type_= String; htmlName= ""}
  ; Attribute {name= "noValidate"; type_= Bool; htmlName= ""}
  ; Attribute {name= "open"; type_= Bool; htmlName= ""}
  ; Attribute {name= "optimum"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "pattern"; type_= String; htmlName= ""}
  ; Attribute {name= "placeholder"; type_= String; htmlName= ""}
  ; Attribute {name= "playsInline"; type_= Bool; htmlName= ""}
  ; Attribute {name= "poster"; type_= String; htmlName= ""}
  ; Attribute {name= "preload"; type_= String; htmlName= ""}
  ; Attribute {name= "readOnly"; type_= Bool; htmlName= ""}
  ; Attribute {name= "rel"; type_= String; htmlName= ""}
  ; Attribute {name= "required"; type_= Bool; htmlName= ""}
  ; Attribute {name= "reversed"; type_= Bool; htmlName= ""}
  ; Attribute {name= "rows"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "rowSpan"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "sandbox"; type_= String; htmlName= ""}
  ; Attribute {name= "scope"; type_= String; htmlName= ""}
  ; Attribute {name= "scoped"; type_= Bool; htmlName= ""}
  ; Attribute {name= "scrolling"; type_= String; htmlName= ""}
  ; Attribute {name= "seamless"; type_= Bool; htmlName= ""}
  ; Attribute {name= "selected"; type_= Bool; htmlName= ""}
  ; Attribute {name= "shape"; type_= String; htmlName= ""}
  ; Attribute {name= "size"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "sizes"; type_= String; htmlName= ""}
  ; Attribute {name= "span"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "srcDoc"; type_= String; htmlName= ""}
  ; Attribute {name= "srcLang"; type_= String; htmlName= ""}
  ; Attribute {name= "srcSet"; type_= String; htmlName= ""}
  ; Attribute {name= "start"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "step"; type_= (* number | *) String; htmlName= ""}
  ; Attribute {name= "summary"; type_= String; htmlName= ""}
  ; Attribute {name= "target"; type_= String; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""}
  ; Attribute {name= "useMap"; type_= String; htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" }
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "wmode"; type_= String; htmlName= ""}
  ; Attribute {name= "wrap"; type_= String; htmlName= ""} ]

let anchorHTMLAttributes =
  [ Attribute {name= "download"; type_= String (* any; *); htmlName= "download"}
  ; Attribute {name= "href"; type_= String; htmlName= "href"}
  ; Attribute {name= "hrefLang"; type_= String; htmlName= "hrefLang"}
  ; Attribute {name= "media"; type_= String; htmlName= "media"}
  ; Attribute {name= "ping"; type_= String; htmlName= "ping"}
  ; Attribute {name= "rel"; type_= String; htmlName= "rel"}
  ; Attribute {name= "target"; type_= attributeAnchorTarget; htmlName= "target"}
  ; Attribute {name= "type"; type_= String; htmlName= "type"}
  ; Attribute
      { name= "referrerPolicy"
      ; type_= attributeReferrerPolicy
      ; htmlName= "referrerPolicy" } ]

let audioHTMLAttributes = [] (* MediaHTMLAttributes*)

let areaHTMLAttributes =
  [ Attribute {name= "alt"; type_= String; htmlName= "alt"}
  ; Attribute {name= "coords"; type_= String; htmlName= "coords"}
  ; Attribute {name= "download"; type_= String (* any *); htmlName= "download"}
  ; Attribute {name= "href"; type_= String; htmlName= "href"}
  ; Attribute {name= "hrefLang"; type_= String; htmlName= "hrefLang"}
  ; Attribute {name= "media"; type_= String; htmlName= "media"}
  ; Attribute
      { name= "referrerPolicy"
      ; type_= attributeReferrerPolicy
      ; htmlName= "referrerPolicy" }
  ; Attribute {name= "rel"; type_= String; htmlName= "rel"}
  ; Attribute {name= "shape"; type_= String; htmlName= "shape"}
  ; Attribute {name= "target"; type_= String; htmlName= "target"} ]

let baseHTMLAttributes =
  [ Attribute {name= "href"; type_= String; htmlName= ""}
  ; Attribute {name= "target"; type_= String; htmlName= ""} ]

let blockquoteHTMLAttributes =
  [Attribute {name= "cite"; type_= String; htmlName= ""}]

let buttonHTMLAttributes =
  [ Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "formAction"; type_= String; htmlName= ""}
  ; Attribute {name= "formEncType"; type_= String; htmlName= ""}
  ; Attribute {name= "formMethod"; type_= String; htmlName= ""}
  ; Attribute {name= "formNoValidate"; type_= Bool; htmlName= ""}
  ; Attribute {name= "formTarget"; type_= String; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute
      { name= "type"
      ; type_= String (* 'submit' | 'reset' | 'button' *)
      ; htmlName= "" }
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let canvasHTMLAttributes =
  [ Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let colHTMLAttributes =
  [ Attribute {name= "span"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let colgroupHTMLAttributes =
  [Attribute {name= "span"; type_= Int (* number *); htmlName= ""}]

let dataHTMLAttributes =
  [ Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let detailsHTMLAttributes =
  [ Attribute {name= "open"; type_= Bool; htmlName= "open"}
    (* { name="onToggle"; type_= ReactEventHandler<T>; htmlName="" }; *) ]

let delHTMLAttributes =
  [ Attribute {name= "cite"; type_= String; htmlName= "cite"}
  ; Attribute {name= "dateTime"; type_= String; htmlName= "dateTime"} ]

let dialogHTMLAttributes =
  [Attribute {name= "open"; type_= Bool; htmlName= "open"}]

let embedHTMLAttributes =
  [ Attribute {name= "height"; type_= (* number |  *) String; htmlName= "height"}
  ; Attribute {name= "src"; type_= String; htmlName= "src"}
  ; Attribute {name= "type"; type_= String; htmlName= "type"}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= "width"}
  ]

let fieldsetHTMLAttributes =
  [ Attribute {name= "disabled"; type_= Bool; htmlName= "disabled"}
  ; Attribute {name= "form"; type_= String; htmlName= "form"}
  ; Attribute {name= "name"; type_= String; htmlName= "name"} ]

let formHTMLAttributes =
  [ Attribute {name= "acceptCharset"; type_= String; htmlName= "acceptCharset"}
  ; Attribute {name= "action"; type_= String; htmlName= "action"}
  ; Attribute {name= "autoComplete"; type_= String; htmlName= "autoComplete"}
  ; Attribute {name= "encType"; type_= String; htmlName= "encType"}
  ; Attribute {name= "method"; type_= String; htmlName= "method"}
  ; Attribute {name= "name"; type_= String; htmlName= "name"}
  ; Attribute {name= "noValidate"; type_= Bool; htmlName= "noValidate"}
  ; Attribute {name= "target"; type_= String; htmlName= "target"} ]

let htmlHTMLAttributes =
  [Attribute {name= "manifest"; type_= String; htmlName= ""}]

let iframeHTMLAttributes =
  [ Attribute {name= "allow"; type_= String; htmlName= ""}
  ; Attribute {name= "allowFullScreen"; type_= Bool; htmlName= ""}
  ; Attribute {name= "allowTransparency"; type_= Bool; htmlName= ""}
  ; (* @deprecated *)
    Attribute {name= "frameBorder"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; (* @deprecated *)
    Attribute {name= "marginHeight"; type_= Int (* number *); htmlName= ""}
  ; (* @deprecated *)
    Attribute {name= "marginWidth"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "sandbox"; type_= String; htmlName= ""}
  ; (* @deprecated *)
    Attribute {name= "scrolling"; type_= String; htmlName= ""}
  ; Attribute {name= "seamless"; type_= Bool; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "srcDoc"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let imgHTMLAttributes =
  [ Attribute {name= "alt"; type_= String; htmlName= ""}
  ; Attribute
      { name= "crossOrigin"
      ; type_= String (* "anonymous" | "use-credentials" | "" *)
      ; htmlName= "" }
  ; Attribute
      { name= "decoding"
      ; type_= String (* "async" | "auto" | "sync" *)
      ; htmlName= "" }
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "sizes"; type_= String; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "srcSet"; type_= String; htmlName= ""}
  ; Attribute {name= "useMap"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let insHTMLAttributes =
  [ Attribute {name= "cite"; type_= String; htmlName= ""}
  ; Attribute {name= "dateTime"; type_= String; htmlName= ""} ]

let inputTypeAttribute = String
(*
        | 'button'
        | 'checkbox'
        | 'color'
        | 'date'
        | 'datetime-local'
        | 'email'
        | 'file'
        | 'hidden'
        | 'image'
        | 'month'
        | 'number'
        | 'password'
        | 'radio'
        | 'range'
        | 'reset'
        | 'search'
        | 'submit'
        | 'tel'
        | 'text'
        | 'time'
        | 'url'
        | 'week'
        | (String & {});  *)

let inputHTMLAttributes =
  [ Attribute {name= "accept"; type_= String; htmlName= ""}
  ; Attribute {name= "alt"; type_= String; htmlName= ""}
  ; Attribute {name= "autoComplete"; type_= String; htmlName= ""}
  ; Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute
      { name= "capture"
      ; type_= (* Bool | *) String
      ; (* https://www.w3.org/TR/html-media-capture/ *) htmlName= "" }
  ; Attribute {name= "checked"; type_= Bool; htmlName= ""}
  ; Attribute {name= "crossOrigin"; type_= String; htmlName= ""}
  ; Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "formAction"; type_= String; htmlName= ""}
  ; Attribute {name= "formEncType"; type_= String; htmlName= ""}
  ; Attribute {name= "formMethod"; type_= String; htmlName= ""}
  ; Attribute {name= "formNoValidate"; type_= Bool; htmlName= ""}
  ; Attribute {name= "formTarget"; type_= String; htmlName= ""}
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "list"; type_= String; htmlName= ""}
  ; Attribute {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "maxLength"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "minLength"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "multiple"; type_= Bool; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "pattern"; type_= String; htmlName= ""}
  ; Attribute {name= "placeholder"; type_= String; htmlName= ""}
  ; Attribute {name= "readOnly"; type_= Bool; htmlName= ""}
  ; Attribute {name= "required"; type_= Bool; htmlName= ""}
  ; Attribute {name= "size"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "step"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "type"; type_= inputTypeAttribute; htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" }
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""}
    (* { name="onChange"; type_= ChangeEventHandler<T>; htmlName="" }; *) ]

let keygenHTMLAttributes =
  [ Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute {name= "challenge"; type_= String; htmlName= ""}
  ; Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "keyType"; type_= String; htmlName= ""}
  ; Attribute {name= "keyParams"; type_= String; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""} ]

let labelHTMLAttributes =
  [ Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "htmlFor"; type_= String; htmlName= ""} ]

let liHTMLAttributes =
  [ Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let linkHTMLAttributes =
  [ Attribute {name= "as"; type_= String; htmlName= ""}
  ; Attribute {name= "crossOrigin"; type_= String; htmlName= ""}
  ; Attribute {name= "href"; type_= String; htmlName= ""}
  ; Attribute {name= "hrefLang"; type_= String; htmlName= ""}
  ; Attribute {name= "integrity"; type_= String; htmlName= ""}
  ; Attribute {name= "imageSrcSet"; type_= String; htmlName= ""}
  ; Attribute {name= "media"; type_= String; htmlName= ""}
  ; Attribute {name= "rel"; type_= String; htmlName= ""}
  ; Attribute {name= "sizes"; type_= String; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""}
  ; Attribute {name= "charSet"; type_= String; htmlName= ""} ]

let mapHTMLAttributes = [Attribute {name= "name"; type_= String; htmlName= ""}]

let menuHTMLAttributes = [Attribute {name= "type"; type_= String; htmlName= ""}]

let mediaHTMLAttributes =
  [ Attribute {name= "autoPlay"; type_= Bool; htmlName= ""}
  ; Attribute {name= "controls"; type_= Bool; htmlName= ""}
  ; Attribute {name= "controlsList"; type_= String; htmlName= ""}
  ; Attribute {name= "crossOrigin"; type_= String; htmlName= ""}
  ; Attribute {name= "loop"; type_= Bool; htmlName= ""}
  ; Attribute {name= "mediaGroup"; type_= String; htmlName= ""}
  ; Attribute {name= "muted"; type_= Bool; htmlName= ""}
  ; Attribute {name= "playsInline"; type_= Bool; htmlName= ""}
  ; Attribute {name= "preload"; type_= String; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""} ]

let metaHTMLAttributes =
  [ Attribute {name= "charSet"; type_= String; htmlName= ""}
  ; Attribute {name= "content"; type_= String; htmlName= ""}
  ; Attribute {name= "httpEquiv"; type_= String; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "media"; type_= String; htmlName= ""} ]

let meterHTMLAttributes =
  [ Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "high"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "low"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "optimum"; type_= Int (* number *); htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let quoteHTMLAttributes = [Attribute {name= "cite"; type_= String; htmlName= ""}]

let objectHTMLAttributes =
  [ Attribute {name= "classID"; type_= String; htmlName= ""}
  ; Attribute {name= "data"; type_= String; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""}
  ; Attribute {name= "useMap"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "wmode"; type_= String; htmlName= ""} ]

let olHTMLAttributes =
  [ Attribute {name= "reversed"; type_= Bool; htmlName= ""}
  ; Attribute {name= "start"; type_= Int (* number *); htmlName= ""}
  ; Attribute
      { name= "type"
      ; type_= String (* '1' | 'a' | 'A' | 'i' | 'I' *)
      ; htmlName= "" } ]

let optgroupHTMLAttributes =
  [ Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "label"; type_= String; htmlName= ""} ]

let optionHTMLAttributes =
  [ Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "label"; type_= String; htmlName= ""}
  ; Attribute {name= "selected"; type_= Bool; htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let outputHTMLAttributes =
  [ Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "htmlFor"; type_= String; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""} ]

let paramHTMLAttributes =
  [ Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let progressHTMLAttributes =
  [ Attribute {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" } ]

let slotHTMLAttributes = [Attribute {name= "name"; type_= String; htmlName= ""}]

let scriptHTMLAttributes =
  [ Attribute {name= "async"; type_= Bool; htmlName= ""}
  ; (* @deprecated *)
    Attribute {name= "charSet"; type_= String; htmlName= ""}
  ; Attribute {name= "crossOrigin"; type_= String; htmlName= ""}
  ; Attribute {name= "defer"; type_= Bool; htmlName= ""}
  ; Attribute {name= "integrity"; type_= String; htmlName= ""}
  ; Attribute {name= "noModule"; type_= Bool; htmlName= ""}
  ; Attribute {name= "nonce"; type_= String; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""} ]

let selectHTMLAttributes =
  [ Attribute {name= "autoComplete"; type_= String; htmlName= ""}
  ; Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "multiple"; type_= Bool; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "required"; type_= Bool; htmlName= ""}
  ; Attribute {name= "size"; type_= Int (* number *); htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" }
    (* { name="onChange"; type_= ChangeEventHandler<T>; htmlName="" }; *) ]

let sourceHTMLAttributes =
  [ Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "media"; type_= String; htmlName= ""}
  ; Attribute {name= "sizes"; type_= String; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "srcSet"; type_= String; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let styleHTMLAttributes =
  [ Attribute {name= "media"; type_= String; htmlName= ""}
  ; Attribute {name= "nonce"; type_= String; htmlName= ""}
  ; Attribute {name= "scoped"; type_= Bool; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""} ]

let tableHTMLAttributes =
  [ Attribute {name= "cellPadding"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "cellSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "summary"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let textareaHTMLAttributes =
  [ Attribute {name= "autoComplete"; type_= String; htmlName= ""}
  ; Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute {name= "cols"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "dirName"; type_= String; htmlName= ""}
  ; Attribute {name= "disabled"; type_= Bool; htmlName= ""}
  ; Attribute {name= "form"; type_= String; htmlName= ""}
  ; Attribute {name= "maxLength"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "minLength"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "placeholder"; type_= String; htmlName= ""}
  ; Attribute {name= "readOnly"; type_= Bool; htmlName= ""}
  ; Attribute {name= "required"; type_= Bool; htmlName= ""}
  ; Attribute {name= "rows"; type_= Int (* number *); htmlName= ""}
  ; Attribute
      { name= "value"
      ; type_= String (* | ReadonlyArray<String> | number *)
      ; htmlName= "" }
  ; Attribute {name= "wrap"; type_= String; htmlName= ""}
    (* { name="onChange"; type_= ChangeEventHandler<T>; htmlName="" }; *) ]

let tdHTMLAttributes =
  [ Attribute
      { name= "align"
      ; type_=
          String (* type_= "left" | "center" | "right" | "justify" | "char" *)
      ; htmlName= "" }
  ; Attribute {name= "colSpan"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "headers"; type_= String; htmlName= ""}
  ; Attribute {name= "rowSpan"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "scope"; type_= String; htmlName= ""}
  ; Attribute {name= "abbr"; type_= String; htmlName= ""}
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "valign"
      ; type_= String (* "top" | "middle" | "bottom" | "baseline" *)
      ; htmlName= "" } ]

let thHTMLAttributes =
  [ Attribute
      { name= "align"
      ; type_= String (* "left" | "center" | "right" | "justify" | "char" *)
      ; htmlName= "" }
  ; Attribute {name= "colSpan"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "headers"; type_= String; htmlName= ""}
  ; Attribute {name= "rowSpan"; type_= Int (* number *); htmlName= ""}
  ; Attribute {name= "scope"; type_= String; htmlName= ""}
  ; Attribute {name= "abbr"; type_= String; htmlName= ""} ]

let timeHTMLAttributes =
  [Attribute {name= "dateTime"; type_= String; htmlName= ""}]

let trackHTMLAttributes =
  [ Attribute {name= "default"; type_= Bool; htmlName= ""}
  ; Attribute {name= "kind"; type_= String; htmlName= ""}
  ; Attribute {name= "label"; type_= String; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "srcLang"; type_= String; htmlName= ""} ]

(* MediaHTMLAttributes*)
let videoHTMLAttributes =
  [ Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "playsInline"; type_= Bool; htmlName= ""}
  ; Attribute {name= "poster"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "disablePictureInPicture"; type_= Bool; htmlName= ""} ]

(* (* this list is "complete" in that it contains every SVG attribute *)
   // that React supports, but the types can be improved.
   // Full list here: https://facebook.github.io/react/docs/dom-elements.html
   //
   // The three broad type categories are (in order of restrictiveness):
   //   - "(* number |  *)String"
   //   - "String"
   //   - union of String literals *)
(* AriaAttributes, DOMAttributes*)
let svgAttributes =
  [ (* Attributes which also defined in HTMLAttributes *)
    (* See comment in SVGDOMPropertyConfig.js *)
    Attribute {name= "className"; type_= String; htmlName= ""}
  ; Attribute {name= "color"; type_= String; htmlName= ""}
  ; Attribute {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "id"; type_= String; htmlName= ""}
  ; Attribute {name= "lang"; type_= String; htmlName= ""}
  ; Attribute {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "media"; type_= String; htmlName= ""}
  ; Attribute {name= "method"; type_= String; htmlName= ""}
  ; Attribute {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "name"; type_= String; htmlName= ""}
  ; Attribute {name= "style"; type_= Style; htmlName= ""}
  ; Attribute {name= "target"; type_= String; htmlName= ""}
  ; Attribute {name= "type"; type_= String; htmlName= ""}
  ; Attribute {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; (* Other HTML properties supported by SVG elements in browsers *)
    Attribute {name= "role"; type_= ariaRole; htmlName= ""}
  ; Attribute {name= "tabIndex"; type_= Int (* number *); htmlName= ""}
  ; Attribute
      { name= "crossOrigin"
      ; type_= String (* "anonymous" | "use-credentials" | "" *)
      ; htmlName= "" }
  ; (* SVG Specific attributes *)
    Attribute {name= "accentHeight"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "accumulate"
      ; type_= String (* type_= "none" | "sum" *)
      ; htmlName= "" }
  ; Attribute
      { name= "additive"
      ; type_= String (* type_= "replace" | "sum" *)
      ; htmlName= "" }
  ; Attribute
      { name= "alignmentBaseline"
      ; type_= String
      ; (* type_= "auto" | "baseline" | "before-edge" | "text-before-edge" | "middle" | "central" | "after-edge"
           "text-after-edge" | "ideographic" | "alphabetic" | "hanging" | "mathematical" | "inherit"; *)
        htmlName= "" }
  ; Attribute
      { name= "allowReorder"
      ; type_= String (* type_= "no" | "yes" *)
      ; htmlName= "" }
  ; Attribute {name= "alphabetic"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "amplitude"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "arabicForm"
      ; type_=
          String (* type_= "initial" | "medial" | "terminal" | "isolated" *)
      ; htmlName= "" }
  ; Attribute {name= "ascent"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "attributeName"; type_= String; htmlName= ""}
  ; Attribute {name= "attributeType"; type_= String; htmlName= ""}
  ; Attribute {name= "autoReverse"; type_= String (* Booleanish *); htmlName= ""}
  ; Attribute {name= "azimuth"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "baseProfile"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "bbox"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "begin"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "bias"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "by"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "calcMode"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "capHeight"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "clip"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "clipPath"; type_= String; htmlName= ""}
  ; Attribute
      { name= "clipRule"
      ; type_= (* number | "linearRGB" | "inherit" *) String
      ; htmlName= "" }
  ; Attribute {name= "colorProfile"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "cursor"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "cx"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "cy"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "d"; type_= String; htmlName= ""}
  ; Attribute {name= "decelerate"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "descent"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "direction"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "display"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "divisor"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "dur"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "dx"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "dy"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "edgeMode"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "elevation"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "end"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "exponent"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "externalResourcesRequired"
      ; type_= String (* Booleanish *)
      ; htmlName= "" }
  ; Attribute {name= "fill"; type_= String; htmlName= ""}
  ; Attribute {name= "fillOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "fillRule"
      ; type_= String (* type_= "nonzero" | "evenodd" | "inherit" *)
      ; htmlName= "" }
  ; Attribute {name= "filter"; type_= String; htmlName= ""}
  ; Attribute {name= "filterRes"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "filterUnits"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "floodColor"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "floodOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fontFamily"; type_= String; htmlName= ""}
  ; Attribute {name= "fontSize"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fontStretch"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fontStyle"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fontVariant"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fontWeight"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "format"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fr"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "from"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fx"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "fy"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "g1"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "g2"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "glyphName"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "glyphOrientationHorizontal"
      ; type_= (* number |  *) String
      ; htmlName= "" }
  ; Attribute
      { name= "glyphOrientationVertical"
      ; type_= (* number |  *) String
      ; htmlName= "" }
  ; Attribute {name= "glyphRef"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "gradientTransform"; type_= String; htmlName= ""}
  ; Attribute {name= "gradientUnits"; type_= String; htmlName= ""}
  ; Attribute {name= "hanging"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "horizAdvX"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "horizOriginX"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "href"; type_= String; htmlName= ""}
  ; Attribute {name= "ideographic"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "in2"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "in"; type_= String; htmlName= ""}
  ; Attribute {name= "intercept"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "k1"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "k2"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "k3"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "k4"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "k"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "kernelMatrix"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "kerning"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "keyPoints"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "keySplines"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "keyTimes"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "lengthAdjust"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "local"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "markerEnd"; type_= String; htmlName= ""}
  ; Attribute {name= "markerHeight"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "markerMid"; type_= String; htmlName= ""}
  ; Attribute {name= "markerStart"; type_= String; htmlName= ""}
  ; Attribute {name= "markerUnits"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "markerWidth"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "mask"; type_= String; htmlName= ""}
  ; Attribute {name= "maskUnits"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "mathematical"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "mode"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "numOctaves"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "offset"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "opacity"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "operator"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "order"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "orient"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "orientation"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "origin"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "overflow"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "paintOrder"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "panose1"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "path"; type_= String; htmlName= ""}
  ; Attribute {name= "pathLength"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "patternContentUnits"; type_= String; htmlName= ""}
  ; Attribute {name= "patternUnits"; type_= String; htmlName= ""}
  ; Attribute {name= "points"; type_= String; htmlName= ""}
  ; Attribute {name= "pointsAtX"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "pointsAtY"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "pointsAtZ"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "preserveAspectRatio"; type_= String; htmlName= ""}
  ; Attribute {name= "r"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "radius"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "refX"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "refY"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "repeatCount"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "repeatDur"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "restart"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "result"; type_= String; htmlName= ""}
  ; Attribute {name= "rotate"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "rx"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "ry"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "scale"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "seed"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "slope"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "spacing"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "speed"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "spreadMethod"; type_= String; htmlName= ""}
  ; Attribute {name= "startOffset"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "stdDeviation"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "stemh"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "stemv"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "stitchTiles"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "stopColor"; type_= String; htmlName= ""}
  ; Attribute {name= "stopOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute
      { name= "strikethroughPosition"
      ; type_= (* number |  *) String
      ; htmlName= "" }
  ; Attribute
      { name= "strikethroughThickness"
      ; type_= (* number |  *) String
      ; htmlName= "" }
  ; Attribute {name= "String"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "stroke"; type_= String; htmlName= ""}
  ; Attribute
      { name= "strokeLinecap"
      ; type_= String (* type_= "butt" | "round" | "square" | "inherit" *)
      ; htmlName= "" }
  ; Attribute {name= "strokeWidth"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "surfaceScale"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "tableValues"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "targetX"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "targetY"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "textAnchor"; type_= String; htmlName= ""}
  ; Attribute {name= "textLength"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "to"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "transform"; type_= String; htmlName= ""}
  ; Attribute {name= "u1"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "u2"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "unicode"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "unicodeBidi"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "unicodeRange"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "unitsPerEm"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "vAlphabetic"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "values"; type_= String; htmlName= ""}
  ; Attribute {name= "vectorEffect"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "version"; type_= String; htmlName= ""}
  ; Attribute {name= "vertAdvY"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "vertOriginX"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "vertOriginY"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "vHanging"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "vIdeographic"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "viewBox"; type_= String; htmlName= ""}
  ; Attribute {name= "viewTarget"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "visibility"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "widths"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "wordSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "writingMode"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "x1"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "x2"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "x"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "xChannelSelector"; type_= String; htmlName= ""}
  ; Attribute {name= "xHeight"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "xlinkActuate"; type_= String; htmlName= ""}
  ; Attribute {name= "xlinkArcrole"; type_= String; htmlName= ""}
  ; Attribute {name= "xlinkHref"; type_= String; htmlName= ""}
  ; Attribute {name= "xlinkRole"; type_= String; htmlName= ""}
  ; Attribute {name= "xlinkShow"; type_= String; htmlName= ""}
  ; Attribute {name= "xlinkTitle"; type_= String; htmlName= ""}
  ; Attribute {name= "xlinkType"; type_= String; htmlName= ""}
  ; Attribute {name= "xmlBase"; type_= String; htmlName= ""}
  ; Attribute {name= "xmlLang"; type_= String; htmlName= ""}
  ; Attribute {name= "xmlns"; type_= String; htmlName= ""}
  ; Attribute {name= "xmlnsXlink"; type_= String; htmlName= ""}
  ; Attribute {name= "xmlSpace"; type_= String; htmlName= ""}
  ; Attribute {name= "y1"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "y2"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "y"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "yChannelSelector"; type_= String; htmlName= ""}
  ; Attribute {name= "z"; type_= (* number |  *) String; htmlName= ""}
  ; Attribute {name= "zoomAndPan"; type_= String; htmlName= ""} ]

let webViewHTMLAttributes =
  [ Attribute {name= "allowFullScreen"; type_= Bool; htmlName= ""}
  ; Attribute {name= "allowpopups"; type_= Bool; htmlName= ""}
  ; Attribute {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; Attribute {name= "autosize"; type_= Bool; htmlName= ""}
  ; Attribute {name= "blinkfeatures"; type_= String; htmlName= ""}
  ; Attribute {name= "disableblinkfeatures"; type_= String; htmlName= ""}
  ; Attribute {name= "disableguestresize"; type_= Bool; htmlName= ""}
  ; Attribute {name= "disablewebsecurity"; type_= Bool; htmlName= ""}
  ; Attribute {name= "guestinstance"; type_= String; htmlName= ""}
  ; Attribute {name= "httpreferrer"; type_= String; htmlName= ""}
  ; Attribute {name= "nodeintegration"; type_= Bool; htmlName= ""}
  ; Attribute {name= "partition"; type_= String; htmlName= ""}
  ; Attribute {name= "plugins"; type_= Bool; htmlName= ""}
  ; Attribute {name= "preload"; type_= String; htmlName= ""}
  ; Attribute {name= "src"; type_= String; htmlName= ""}
  ; Attribute {name= "useragent"; type_= String; htmlName= ""}
  ; Attribute {name= "webpreferences"; type_= String; htmlName= ""} ]

(* Browser Interfaces https://github.com/nikeee/2048-typescript/blob/master/2048/js/touch.d.ts *)
let abstractView = []
(* {
       styleMedia: StyleMedia;
       document: Document;
   ] *)

let touch = []
(* {
       identifier: number;
       target: EventTarget;
       screenX: number;
       screenY: number;
       clientX: number;
       clientY: number;
       pageX: number;
       pageY: number;
   ]
*)

let touchList = []
(* {
       [index: number]: Touch;
       length: number;
       item(index: number): Touch;
       identifiedTouch(identifier: number): Touch;
   ] *)

(* Error Interfaces *)
let errorInfo = []
(* {
      /**
       * Captures which component contained the exception, and its ancestors.
       */
      componentStack: string; *)

let htmlElements =
  [ {tag= "a"; attributes= anchorHTMLAttributes & attributesHTML}
  ; {tag= "abbr"; attributes= attributesHTML}
  ; {tag= "address"; attributes= attributesHTML}
  ; {tag= "area"; attributes= areaHTMLAttributes}
  ; {tag= "article"; attributes= attributesHTML}
  ; {tag= "aside"; attributes= attributesHTML}
  ; {tag= "audio"; attributes= audioHTMLAttributes}
  ; {tag= "b"; attributes= attributesHTML}
  ; {tag= "base"; attributes= baseHTMLAttributes}
  ; {tag= "bdi"; attributes= attributesHTML}
  ; {tag= "bdo"; attributes= attributesHTML}
  ; {tag= "big"; attributes= attributesHTML}
  ; {tag= "blockquote"; attributes= blockquoteHTMLAttributes}
  ; {tag= "body"; attributes= attributesHTML}
  ; {tag= "br"; attributes= attributesHTML}
  ; {tag= "button"; attributes= buttonHTMLAttributes}
  ; {tag= "canvas"; attributes= canvasHTMLAttributes}
  ; {tag= "caption"; attributes= attributesHTML}
  ; {tag= "cite"; attributes= attributesHTML}
  ; {tag= "code"; attributes= attributesHTML}
  ; {tag= "col"; attributes= colHTMLAttributes}
  ; {tag= "colgroup"; attributes= colgroupHTMLAttributes}
  ; {tag= "data"; attributes= dataHTMLAttributes}
  ; {tag= "datalist"; attributes= attributesHTML}
  ; {tag= "dd"; attributes= attributesHTML}
  ; {tag= "del"; attributes= delHTMLAttributes}
  ; {tag= "details"; attributes= detailsHTMLAttributes}
  ; {tag= "dfn"; attributes= attributesHTML}
  ; {tag= "dialog"; attributes= dialogHTMLAttributes}
  ; {tag= "div"; attributes= attributesHTML}
  ; {tag= "dl"; attributes= attributesHTML}
  ; {tag= "dt"; attributes= attributesHTML}
  ; {tag= "em"; attributes= attributesHTML}
  ; {tag= "embed"; attributes= embedHTMLAttributes}
  ; {tag= "fieldset"; attributes= fieldsetHTMLAttributes}
  ; {tag= "figcaption"; attributes= attributesHTML}
  ; {tag= "figure"; attributes= attributesHTML}
  ; {tag= "footer"; attributes= attributesHTML}
  ; {tag= "form"; attributes= formHTMLAttributes}
  ; {tag= "h1"; attributes= attributesHTML}
  ; {tag= "h2"; attributes= attributesHTML}
  ; {tag= "h3"; attributes= attributesHTML}
  ; {tag= "h4"; attributes= attributesHTML}
  ; {tag= "h5"; attributes= attributesHTML}
  ; {tag= "h6"; attributes= attributesHTML}
  ; {tag= "head"; attributes= attributesHTML}
  ; {tag= "header"; attributes= attributesHTML}
  ; {tag= "hgroup"; attributes= attributesHTML}
  ; {tag= "hr"; attributes= attributesHTML}
  ; {tag= "html"; attributes= htmlHTMLAttributes}
  ; {tag= "i"; attributes= attributesHTML}
  ; {tag= "iframe"; attributes= iframeHTMLAttributes}
  ; {tag= "img"; attributes= imgHTMLAttributes}
  ; {tag= "input"; attributes= inputHTMLAttributes}
  ; {tag= "ins"; attributes= insHTMLAttributes}
  ; {tag= "kbd"; attributes= attributesHTML}
  ; {tag= "keygen"; attributes= keygenHTMLAttributes}
  ; {tag= "label"; attributes= labelHTMLAttributes}
  ; {tag= "legend"; attributes= attributesHTML}
  ; {tag= "li"; attributes= liHTMLAttributes}
  ; {tag= "link"; attributes= linkHTMLAttributes}
  ; {tag= "main"; attributes= attributesHTML}
  ; {tag= "map"; attributes= mapHTMLAttributes}
  ; {tag= "mark"; attributes= attributesHTML}
  ; {tag= "menu"; attributes= menuHTMLAttributes}
  ; {tag= "menuitem"; attributes= attributesHTML}
  ; {tag= "meta"; attributes= metaHTMLAttributes}
  ; {tag= "meter"; attributes= meterHTMLAttributes}
  ; {tag= "nav"; attributes= attributesHTML}
  ; {tag= "noscript"; attributes= attributesHTML}
  ; {tag= "object"; attributes= objectHTMLAttributes}
  ; {tag= "ol"; attributes= olHTMLAttributes}
  ; {tag= "optgroup"; attributes= optgroupHTMLAttributes}
  ; {tag= "option"; attributes= optionHTMLAttributes}
  ; {tag= "output"; attributes= outputHTMLAttributes}
  ; {tag= "p"; attributes= attributesHTML}
  ; {tag= "param"; attributes= paramHTMLAttributes}
  ; {tag= "picture"; attributes= attributesHTML}
  ; {tag= "pre"; attributes= attributesHTML}
  ; {tag= "progress"; attributes= progressHTMLAttributes}
  ; {tag= "q"; attributes= quoteHTMLAttributes}
  ; {tag= "rp"; attributes= attributesHTML}
  ; {tag= "rt"; attributes= attributesHTML}
  ; {tag= "ruby"; attributes= attributesHTML}
  ; {tag= "s"; attributes= attributesHTML}
  ; {tag= "samp"; attributes= attributesHTML}
  ; {tag= "slot"; attributes= slotHTMLAttributes}
  ; {tag= "script"; attributes= scriptHTMLAttributes}
  ; {tag= "section"; attributes= attributesHTML}
  ; {tag= "select"; attributes= selectHTMLAttributes}
  ; {tag= "small"; attributes= attributesHTML}
  ; {tag= "source"; attributes= sourceHTMLAttributes}
  ; {tag= "span"; attributes= attributesHTML}
  ; {tag= "strong"; attributes= attributesHTML}
  ; {tag= "style"; attributes= styleHTMLAttributes}
  ; {tag= "sub"; attributes= attributesHTML}
  ; {tag= "summary"; attributes= attributesHTML}
  ; {tag= "sup"; attributes= attributesHTML}
  ; {tag= "table"; attributes= tableHTMLAttributes}
  ; {tag= "template"; attributes= attributesHTML}
  ; {tag= "tbody"; attributes= attributesHTML}
  ; {tag= "td"; attributes= tdHTMLAttributes}
  ; {tag= "textarea"; attributes= textareaHTMLAttributes}
  ; {tag= "tfoot"; attributes= attributesHTML}
  ; {tag= "th"; attributes= thHTMLAttributes}
  ; {tag= "thead"; attributes= attributesHTML}
  ; {tag= "time"; attributes= timeHTMLAttributes}
  ; {tag= "title"; attributes= attributesHTML}
  ; {tag= "tr"; attributes= attributesHTML}
  ; {tag= "track"; attributes= trackHTMLAttributes}
  ; {tag= "u"; attributes= attributesHTML}
  ; {tag= "ul"; attributes= attributesHTML}
  ; {tag= "var"; attributes= attributesHTML}
  ; {tag= "video"; attributes= videoHTMLAttributes}
  ; {tag= "wbr"; attributes= attributesHTML}
  ; {tag= "webview"; attributes= webViewHTMLAttributes}
  ; {tag= "abbr"; attributes= attributesHTML}
  ; {tag= "address"; attributes= attributesHTML}
  ; {tag= "area"; attributes= attributesHTML & areaHTMLAttributes}
  ; {tag= "article"; attributes= attributesHTML}
  ; {tag= "aside"; attributes= attributesHTML}
  ; {tag= "audio"; attributes= attributesHTML & audioHTMLAttributes}
  ; {tag= "b"; attributes= attributesHTML}
  ; {tag= "base"; attributes= attributesHTML & baseHTMLAttributes}
  ; {tag= "bdi"; attributes= attributesHTML}
  ; {tag= "bdo"; attributes= attributesHTML}
  ; {tag= "big"; attributes= attributesHTML}
  ; {tag= "blockquote"; attributes= attributesHTML & blockquoteHTMLAttributes}
  ; {tag= "body"; attributes= attributesHTML}
  ; {tag= "br"; attributes= attributesHTML}
  ; {tag= "button"; attributes= attributesHTML & buttonHTMLAttributes}
  ; {tag= "canvas"; attributes= attributesHTML & canvasHTMLAttributes}
  ; {tag= "caption"; attributes= attributesHTML}
  ; {tag= "cite"; attributes= attributesHTML}
  ; {tag= "code"; attributes= attributesHTML}
  ; {tag= "col"; attributes= attributesHTML & colHTMLAttributes}
  ; {tag= "colgroup"; attributes= attributesHTML & colgroupHTMLAttributes}
  ; {tag= "data"; attributes= attributesHTML & dataHTMLAttributes}
  ; {tag= "datalist"; attributes= attributesHTML}
  ; {tag= "dd"; attributes= attributesHTML}
  ; {tag= "del"; attributes= attributesHTML & delHTMLAttributes}
  ; {tag= "details"; attributes= attributesHTML & detailsHTMLAttributes}
  ; {tag= "dfn"; attributes= attributesHTML}
  ; {tag= "dialog"; attributes= attributesHTML & dialogHTMLAttributes}
  ; {tag= "div"; attributes= attributesHTML}
  ; {tag= "dl"; attributes= attributesHTML}
  ; {tag= "dt"; attributes= attributesHTML}
  ; {tag= "em"; attributes= attributesHTML}
  ; {tag= "embed"; attributes= attributesHTML & embedHTMLAttributes}
  ; {tag= "fieldset"; attributes= attributesHTML & fieldsetHTMLAttributes}
  ; {tag= "figcaption"; attributes= attributesHTML}
  ; {tag= "figure"; attributes= attributesHTML}
  ; {tag= "footer"; attributes= attributesHTML}
  ; {tag= "form"; attributes= attributesHTML & formHTMLAttributes}
  ; {tag= "h1"; attributes= attributesHTML}
  ; {tag= "h2"; attributes= attributesHTML}
  ; {tag= "h3"; attributes= attributesHTML}
  ; {tag= "h4"; attributes= attributesHTML}
  ; {tag= "h5"; attributes= attributesHTML}
  ; {tag= "h6"; attributes= attributesHTML}
  ; {tag= "head"; attributes= attributesHTML}
  ; {tag= "header"; attributes= attributesHTML}
  ; {tag= "hgroup"; attributes= attributesHTML}
  ; {tag= "hr"; attributes= attributesHTML}
  ; {tag= "html"; attributes= attributesHTML & htmlHTMLAttributes}
  ; {tag= "i"; attributes= attributesHTML}
  ; {tag= "iframe"; attributes= attributesHTML & iframeHTMLAttributes}
  ; {tag= "img"; attributes= attributesHTML & imgHTMLAttributes}
  ; {tag= "input"; attributes= attributesHTML & inputHTMLAttributes}
  ; {tag= "ins"; attributes= attributesHTML & insHTMLAttributes}
  ; {tag= "kbd"; attributes= attributesHTML}
  ; {tag= "keygen"; attributes= attributesHTML & keygenHTMLAttributes}
  ; {tag= "label"; attributes= attributesHTML & labelHTMLAttributes}
  ; {tag= "legend"; attributes= attributesHTML}
  ; {tag= "li"; attributes= attributesHTML & liHTMLAttributes}
  ; {tag= "link"; attributes= attributesHTML & linkHTMLAttributes}
  ; {tag= "main"; attributes= attributesHTML}
  ; {tag= "map"; attributes= attributesHTML & mapHTMLAttributes}
  ; {tag= "mark"; attributes= attributesHTML}
  ; {tag= "menu"; attributes= attributesHTML & menuHTMLAttributes}
  ; {tag= "menuitem"; attributes= attributesHTML}
  ; {tag= "meta"; attributes= attributesHTML & metaHTMLAttributes}
  ; {tag= "meter"; attributes= attributesHTML & meterHTMLAttributes}
  ; {tag= "nav"; attributes= attributesHTML}
  ; {tag= "noindex"; attributes= attributesHTML}
  ; {tag= "noscript"; attributes= attributesHTML}
  ; {tag= "object_"; attributes= attributesHTML & objectHTMLAttributes}
  ; {tag= "ol"; attributes= attributesHTML & olHTMLAttributes}
  ; {tag= "optgroup"; attributes= attributesHTML & optgroupHTMLAttributes}
  ; {tag= "option"; attributes= attributesHTML & optionHTMLAttributes}
  ; {tag= "output"; attributes= attributesHTML & outputHTMLAttributes}
  ; {tag= "p"; attributes= attributesHTML}
  ; {tag= "param"; attributes= attributesHTML & paramHTMLAttributes}
  ; {tag= "picture"; attributes= attributesHTML}
  ; {tag= "pre"; attributes= attributesHTML}
  ; {tag= "progress"; attributes= attributesHTML & progressHTMLAttributes}
  ; {tag= "q"; attributes= attributesHTML & quoteHTMLAttributes}
  ; {tag= "rp"; attributes= attributesHTML}
  ; {tag= "rt"; attributes= attributesHTML}
  ; {tag= "ruby"; attributes= attributesHTML}
  ; {tag= "s"; attributes= attributesHTML}
  ; {tag= "samp"; attributes= attributesHTML}
  ; {tag= "slot"; attributes= attributesHTML & slotHTMLAttributes}
  ; {tag= "script"; attributes= attributesHTML & scriptHTMLAttributes}
  ; {tag= "section"; attributes= attributesHTML}
  ; {tag= "select"; attributes= attributesHTML & selectHTMLAttributes}
  ; {tag= "small"; attributes= attributesHTML}
  ; {tag= "source"; attributes= attributesHTML & sourceHTMLAttributes}
  ; {tag= "span"; attributes= attributesHTML}
  ; {tag= "strong"; attributes= attributesHTML}
  ; {tag= "style"; attributes= attributesHTML & styleHTMLAttributes}
  ; {tag= "sub"; attributes= attributesHTML}
  ; {tag= "summary"; attributes= attributesHTML}
  ; {tag= "sup"; attributes= attributesHTML}
  ; {tag= "table"; attributes= attributesHTML & tableHTMLAttributes}
  ; {tag= "template"; attributes= attributesHTML}
  ; {tag= "tbody"; attributes= attributesHTML}
  ; {tag= "td"; attributes= attributesHTML & tdHTMLAttributes}
  ; {tag= "textarea"; attributes= attributesHTML & textareaHTMLAttributes}
  ; {tag= "tfoot"; attributes= attributesHTML}
  ; {tag= "th"; attributes= attributesHTML & thHTMLAttributes}
  ; {tag= "thead"; attributes= attributesHTML}
  ; {tag= "time"; attributes= attributesHTML & timeHTMLAttributes}
  ; {tag= "title"; attributes= attributesHTML}
  ; {tag= "tr"; attributes= attributesHTML}
  ; {tag= "track"; attributes= attributesHTML & trackHTMLAttributes}
  ; {tag= "u"; attributes= attributesHTML}
  ; {tag= "ul"; attributes= attributesHTML}
  ; {tag= "var"; attributes= attributesHTML}
  ; {tag= "video"; attributes= attributesHTML & videoHTMLAttributes}
  ; {tag= "wbr"; attributes= attributesHTML}
  ; {tag= "webview"; attributes= attributesHTML & webViewHTMLAttributes} ]

let svgElements =
  [ {tag= "svg"; attributes= svgAttributes}
  ; {tag= "animate"; attributes= svgAttributes}
  ; {tag= "animateMotion"; attributes= svgAttributes}
  ; {tag= "animateTransform"; attributes= svgAttributes}
  ; {tag= "circle"; attributes= svgAttributes}
  ; {tag= "clipPath"; attributes= svgAttributes}
  ; {tag= "defs"; attributes= svgAttributes}
  ; {tag= "desc"; attributes= svgAttributes}
  ; {tag= "ellipse"; attributes= svgAttributes}
  ; {tag= "feBlend"; attributes= svgAttributes}
  ; {tag= "feColorMatrix"; attributes= svgAttributes}
  ; {tag= "feComponentTransfer"; attributes= svgAttributes}
  ; {tag= "feComposite"; attributes= svgAttributes}
  ; {tag= "feConvolveMatrix"; attributes= svgAttributes}
  ; {tag= "feDiffuseLighting"; attributes= svgAttributes}
  ; {tag= "feDisplacementMap"; attributes= svgAttributes}
  ; {tag= "feDistantLight"; attributes= svgAttributes}
  ; {tag= "feDropShadow"; attributes= svgAttributes}
  ; {tag= "feFlood"; attributes= svgAttributes}
  ; {tag= "feFuncA"; attributes= svgAttributes}
  ; {tag= "feFuncB"; attributes= svgAttributes}
  ; {tag= "feFuncG"; attributes= svgAttributes}
  ; {tag= "feFuncR"; attributes= svgAttributes}
  ; {tag= "feGaussianBlur"; attributes= svgAttributes}
  ; {tag= "feImage"; attributes= svgAttributes}
  ; {tag= "feMerge"; attributes= svgAttributes}
  ; {tag= "feMergeNode"; attributes= svgAttributes}
  ; {tag= "feMorphology"; attributes= svgAttributes}
  ; {tag= "feOffset"; attributes= svgAttributes}
  ; {tag= "fePointLight"; attributes= svgAttributes}
  ; {tag= "feSpecularLighting"; attributes= svgAttributes}
  ; {tag= "feSpotLight"; attributes= svgAttributes}
  ; {tag= "feTile"; attributes= svgAttributes}
  ; {tag= "feTurbulence"; attributes= svgAttributes}
  ; {tag= "filter"; attributes= svgAttributes}
  ; {tag= "foreignObject"; attributes= svgAttributes}
  ; {tag= "g"; attributes= svgAttributes}
  ; {tag= "image"; attributes= svgAttributes}
  ; {tag= "line"; attributes= svgAttributes}
  ; {tag= "linearGradient"; attributes= svgAttributes}
  ; {tag= "marker"; attributes= svgAttributes}
  ; {tag= "mask"; attributes= svgAttributes}
  ; {tag= "metadata"; attributes= svgAttributes}
  ; {tag= "mpath"; attributes= svgAttributes}
  ; {tag= "path"; attributes= svgAttributes}
  ; {tag= "pattern"; attributes= svgAttributes}
  ; {tag= "polygon"; attributes= svgAttributes}
  ; {tag= "polyline"; attributes= svgAttributes}
  ; {tag= "radialGradient"; attributes= svgAttributes}
  ; {tag= "rect"; attributes= svgAttributes}
  ; {tag= "stop"; attributes= svgAttributes}
  ; {tag= "switch"; attributes= svgAttributes}
  ; {tag= "symbol"; attributes= svgAttributes}
  ; {tag= "text"; attributes= svgAttributes}
  ; {tag= "textPath"; attributes= svgAttributes}
  ; {tag= "tspan"; attributes= svgAttributes}
  ; {tag= "use"; attributes= svgAttributes}
  ; {tag= "view"; attributes= svgAttributes} ]
