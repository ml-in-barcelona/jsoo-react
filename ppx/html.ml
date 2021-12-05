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

type element = {tag: string; attributes: attribute list}

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
  [ (* dangerouslySetInnerHTML?: {
           __html: String;
       };

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
    { name= "ariaActivedescendant"
    ; htmlName= "aria-activedescendant"
    ; type_= String }
  ; (* Indicates whether assistive technologies will present all, or only parts of, the changed region based on the change notifications defined by the aria-relevant attribute. *)
    { name= "ariaAtomic"
    ; htmlName= "aria-atomic"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates whether inputting text could trigger display of one or more predictions of the user's intended value for an input and specifies how predictions would be
     * presented if they are made.
     *)
    { name= "ariaAutocomplete"
    ; htmlName= "aria-autocomplete"
    ; type_= String (* 'none' | 'inline' | 'list' | 'both' *) }
  ; (* Indicates an element is being modified and that assistive technologies MAY want to wait until the modifications are complete before exposing them to the user. *)
    { name= "ariaBusy"
    ; htmlName= "aria-busy"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates the current "checked" state of checkboxes, radio buttons, and other widgets.
     * @see aria-pressed @see aria-selected.
     *)
    { name= "ariaChecked"
    ; htmlName= "aria-checked"
    ; type_= String (* Bool | 'false' | 'mixed' | 'true' *) }
  ; (*
     * Defines the total number of columns in a table, grid, or treegrid.
     * @see aria-colindex.
     *)
    {name= "ariaColcount"; htmlName= "aria-colcount"; type_= Int}
  ; (*
     * Defines an element's column index or position with respect to the total number of columns within a table, grid, or treegrid.
     * @see aria-colcount @see aria-colspan.
     *)
    {name= "ariaColindex"; htmlName= "aria-colindex"; type_= Int}
  ; (*
     * Defines the number of columns spanned by a cell or gridcell within a table, grid, or treegrid.
     * @see aria-colindex @see aria-rowspan.
     *)
    {name= "ariaColspan"; htmlName= "aria-colspan"; type_= Int}
  ; (*
     * Identifies the element (or elements) whose contents or presence are controlled by the current element.
     * @see aria-owns.
     *)
    {name= "ariaControls"; htmlName= "aria-controls"; type_= String}
  ; (* Indicates the element that represents the current item within a container or set of related elements. *)
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
    {name= "ariaDescribedby"; htmlName= "aria-describedby"; type_= String}
  ; (*
     * Identifies the element that provides a detailed, extended description for the object.
     * @see aria-describedby.
     *)
    {name= "ariaDetails"; htmlName= "aria-details"; type_= String}
  ; (*
     * Indicates that the element is perceivable but disabled, so it is not editable or otherwise operable.
     * @see aria-hidden @see aria-readonly.
     *)
    { name= "ariaDisabled"
    ; htmlName= "aria-disabled"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates what functions can be performed when a dragged object is released on the drop target.
     * @deprecated in ARIA 1.1
     *)
    { name= "ariaDropeffect"
    ; htmlName= "aria-dropeffect"
    ; type_=
        String (* 'none' | 'copy' | 'execute' | 'link' | 'move' | 'popup' *) }
  ; (*
     * Identifies the element that provides an error message for the object.
     * @see aria-invalid @see aria-describedby.
     *)
    {name= "ariaErrormessage"; htmlName= "aria-errormessage"; type_= String}
  ; (* Indicates whether the element, or another grouping element it controls, is currently expanded or collapsed. *)
    { name= "ariaExpanded"
    ; htmlName= "aria-expanded"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Identifies the next element (or elements) in an alternate reading order of content which, at the user's discretion,
     * allows assistive technology to override the general default of reading in document source order.
     *)
    {name= "ariaFlowto"; htmlName= "aria-flowto"; type_= String}
  ; (*
     * Indicates an element's "grabbed" state in a drag-and-drop operation.
     * @deprecated in ARIA 1.1
     *)
    { name= "ariaGrabbed"
    ; htmlName= "aria-grabbed"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (* Indicates the availability and type of interactive popup element, such as menu or dialog, that can be triggered by an element. *)
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
    { name= "ariaHidden"
    ; htmlName= "aria-hidden"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates the entered value does not conform to the format expected by the application.
     * @see aria-errormessage.
     *)
    { name= "ariaInvalid"
    ; htmlName= "aria-invalid"
    ; type_= String (* Bool | 'false' | 'true' |  'grammar' | 'spelling'; *) }
  ; (* Indicates keyboard shortcuts that an author has implemented to activate or give focus to an element. *)
    {name= "ariaKeyshortcuts"; htmlName= "aria-keyshortcuts"; type_= String}
  ; (*
     * Defines a String value that labels the current element.
     * @see aria-labelledby.
     *)
    {name= "ariaLabel"; htmlName= "aria-label"; type_= String}
  ; (*
     * Identifies the element (or elements) that labels the current element.
     * @see aria-describedby.
     *)
    {name= "ariaLabelledby"; htmlName= "aria-labelledby"; type_= String}
  ; (*Defines the hierarchical level of an element within a structure. *)
    {name= "ariaLevel"; htmlName= "aria-level"; type_= Int}
  ; (* Indicates that an element will be updated, and describes the types of updates the user agents, assistive technologies, and user can expect from the live region. *)
    { name= "ariaLive"
    ; htmlName= "aria-live"
    ; type_= String (* 'off' | 'assertive' | 'polite' *) }
  ; (* Indicates whether an element is modal when displayed. *)
    { name= "ariaModal"
    ; htmlName= "aria-modal"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (* Indicates whether a text box accepts multiple lines of input or only a single line. *)
    { name= "ariaMultiline"
    ; htmlName= "aria-multiline"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (* Indicates that the user may select more than one item from the current selectable descendants. *)
    { name= "ariaMultiselectable"
    ; htmlName= "aria-multiselectable"
    ; type_= String (* Bool |  'false' | 'true' *) }
  ; (* Indicates whether the element's orientation is horizontal, vertical, or unknown/ambiguous. *)
    { name= "ariaOrientation"
    ; htmlName= "aria-orientation"
    ; type_= String (* 'horizontal' | 'vertical' *) }
  ; (*
     * Identifies an element (or elements) in order to define a visual, functional, or contextual parent/child relationship
     * between DOM elements where the DOM hierarchy cannot be used to represent the relationship.
     * @see aria-controls.
     *)
    {name= "ariaOwns"; htmlName= "aria-owns"; type_= String}
  ; (*
     * Defines a short hint (a word or short phrase) intended to aid the user with data entry when the control has no value.
     * A hint could be a sample value or a brief description of the expected format.
     *)
    {name= "ariaPlaceholder"; htmlName= "aria-placeholder"; type_= String}
  ; (*
     * Defines an element's number or position in the current set of listitems or treeitems. Not required if all elements in the set are present in the DOM.
     * @see aria-setsize.
     *)
    {name= "ariaPosinset"; htmlName= "aria-posinset"; type_= Int}
  ; (*
     * Indicates the current "pressed" state of toggle buttons.
     * @see aria-checked @see aria-selected.
     *)
    { name= "ariaPressed"
    ; htmlName= "aria-pressed"
    ; type_= String (* Bool | 'false' | 'mixed' | 'true' *) }
  ; (*
     * Indicates that the element is not editable, but is otherwise operable.
     * @see aria-disabled.
     *)
    { name= "ariaReadonly"
    ; htmlName= "aria-readonly"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Indicates what notifications the user agent will trigger when the accessibility tree within a live region is modified.
     * @see aria-atomic.
     *)
    { name= "ariaRelevant"
    ; htmlName= "aria-relevant"
    ; type_=
        String
        (* 'additions' | 'additions removals' | 'additions text' | 'all' | 'removals' | 'removals additions' | 'removals text' | 'text' | 'text additions' | 'text removals' *)
    }
  ; (* Indicates that user input is required on the element before a form may be submitted. *)
    { name= "ariaRequired"
    ; htmlName= "aria-required"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*Defines a human-readable, author-localized description for the role of an element. *)
    { name= "ariaRoledescription"
    ; htmlName= "aria-roledescription"
    ; type_= String }
  ; (*
     * Defines the total number of rows in a table, grid, or treegrid.
     * @see aria-rowindex.
     *)
    {name= "ariaRowcount"; htmlName= "aria-rowcount"; type_= Int}
  ; (*
     * Defines an element's row index or position with respect to the total number of rows within a table, grid, or treegrid.
     * @see aria-rowcount @see aria-rowspan.
     *)
    {name= "ariaRowindex"; htmlName= "aria-rowindex"; type_= Int}
  ; (*
     * Defines the number of rows spanned by a cell or gridcell within a table, grid, or treegrid.
     * @see aria-rowindex @see aria-colspan.
     *)
    {name= "ariaRowspan"; htmlName= "aria-rowspan"; type_= Int}
  ; (*
     * Indicates the current "selected" state of various widgets.
     * @see aria-checked @see aria-pressed.
     *)
    { name= "ariaSelected"
    ; htmlName= "aria-selected"
    ; type_= String (* Bool | 'false' | 'true' *) }
  ; (*
     * Defines the number of items in the current set of listitems or treeitems. Not required if all elements in the set are present in the DOM.
     * @see aria-posinset.
     *)
    {name= "ariaSetsize"; htmlName= "aria-setsize"; type_= Int}
  ; (* Indicates if items in a table or grid are sorted in ascending or descending order. *)
    { name= "ariaSort"
    ; htmlName= "aria-sort"
    ; type_= String (* 'none' | 'ascending' | 'descending' | 'other' *) }
  ; (*Defines the maximum allowed value for a range widget. *)
    {name= "ariaValuemax"; htmlName= "aria-valuemax"; type_= Int}
  ; (*Defines the minimum allowed value for a range widget. *)
    {name= "ariaValuemin"; htmlName= "aria-valuemin"; type_= Int}
  ; (*
     * Defines the current value for a range widget.
     * @see aria-valuetext.
     *)
    {name= "ariaValuenow"; htmlName= "aria-valuenow"; type_= Int}
  ; (*Defines the human readable text alternative of aria-valuenow for a range widget. *)
    {name= "ariaValuetext"; htmlName= "aria-valuetext"; type_= String} ]

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
    {name= "defaultChecked"; type_= Bool; htmlName= ""}
  ; { name= "defaultValue"
    ; type_= String (* | number | ReadonlyArray<String> *)
    ; htmlName= "" }
  ; {name= "suppressContentEditableWarning"; type_= Bool; htmlName= ""}
  ; {name= "suppressHydrationWarning"; type_= Bool; htmlName= ""}
  ; (* Standard HTML Attributes *)
    {name= "accessKey"; type_= String; htmlName= ""}
  ; {name= "className"; type_= String; htmlName= ""}
  ; {name= "contentEditable"; type_= String (* | "inherit" *); htmlName= ""}
  ; {name= "contextMenu"; type_= String; htmlName= ""}
  ; {name= "dir"; type_= String; htmlName= ""}
  ; {name= "draggable"; type_= String (* Booleanish *); htmlName= ""}
  ; {name= "hidden"; type_= Bool; htmlName= ""}
  ; {name= "id"; type_= String; htmlName= ""}
  ; {name= "lang"; type_= String; htmlName= ""}
  ; {name= "placeholder"; type_= String; htmlName= ""}
  ; {name= "slot"; type_= String; htmlName= ""}
  ; {name= "spellCheck"; type_= String (* Booleanish *); htmlName= ""}
  ; {name= "style"; type_= Style; htmlName= ""}
  ; {name= "tabIndex"; type_= Int; htmlName= ""}
  ; {name= "title"; type_= String; htmlName= ""}
  ; {name= "translate"; type_= String (* 'yes' | 'no' *); htmlName= ""}
  ; (* Unknown *)
    {name= "radioGroup"; type_= String; htmlName= ""}
  ; (* <command>, <menuitem> *)

    (* WAI-ARIA *)
    {name= "role"; type_= ariaRole; htmlName= ""}
  ; (* RDFa Attributes *)
    {name= "about"; type_= String; htmlName= ""}
  ; {name= "datatype"; type_= String; htmlName= ""}
  ; {name= "inlist"; type_= String (* any *); htmlName= ""}
  ; {name= "prefix"; type_= String; htmlName= ""}
  ; {name= "property"; type_= String; htmlName= ""}
  ; {name= "resource"; type_= String; htmlName= ""}
  ; {name= "typeof"; type_= String; htmlName= ""}
  ; {name= "vocab"; type_= String; htmlName= ""}
  ; (* Non-standard Attributes *)
    {name= "autoCapitalize"; type_= String; htmlName= ""}
  ; {name= "autoCorrect"; type_= String; htmlName= ""}
  ; {name= "autoSave"; type_= String; htmlName= ""}
  ; {name= "color"; type_= String; htmlName= ""}
  ; {name= "itemProp"; type_= String; htmlName= ""}
  ; {name= "itemScope"; type_= Bool; htmlName= ""}
  ; {name= "itemType"; type_= String; htmlName= ""}
  ; {name= "itemID"; type_= String; htmlName= ""}
  ; {name= "itemRef"; type_= String; htmlName= ""}
  ; {name= "results"; type_= Int; htmlName= ""}
  ; {name= "security"; type_= String; htmlName= ""}
  ; {name= "unselectable"; type_= String (* 'on' | 'off' *); htmlName= ""}
  ; (* Living Standard

       * Hints at the type of data that might be entered by the user while editing the element or its contents
       * @see https://html.spec.whatwg.org/multipage/interaction.html#input-modalities:-the-inputmode-attribute *)
    { name= "inputMode"
    ; type_=
        String
        (* 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search' *)
    ; htmlName= "" }
  ; (* * Specify that a standard HTML element should behave like a defined custom built-in element
       * @see https://html.spec.whatwg.org/multipage/custom-elements.html#attr-is *)
    {name= "is"; type_= String; htmlName= ""} ]

let allHTMLAttributes =
  [ (* Standard HTML Attributes *)
    {name= "accept"; type_= String; htmlName= ""}
  ; {name= "acceptCharset"; type_= String; htmlName= ""}
  ; {name= "action"; type_= String; htmlName= ""}
  ; {name= "allowFullScreen"; type_= Bool; htmlName= ""}
  ; {name= "allowTransparency"; type_= Bool; htmlName= ""}
  ; {name= "alt"; type_= String; htmlName= ""}
  ; {name= "as"; type_= String; htmlName= ""}
  ; {name= "async"; type_= Bool; htmlName= ""}
  ; {name= "autoComplete"; type_= String; htmlName= ""}
  ; {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; {name= "autoPlay"; type_= Bool; htmlName= ""}
  ; {name= "capture"; type_= (* Bool |  *) String; htmlName= ""}
  ; {name= "cellPadding"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "cellSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "charSet"; type_= String; htmlName= ""}
  ; {name= "challenge"; type_= String; htmlName= ""}
  ; {name= "checked"; type_= Bool; htmlName= ""}
  ; {name= "cite"; type_= String; htmlName= ""}
  ; {name= "classID"; type_= String; htmlName= ""}
  ; {name= "cols"; type_= Int (* number *); htmlName= ""}
  ; {name= "colSpan"; type_= Int (* number *); htmlName= ""}
  ; {name= "content"; type_= String; htmlName= ""}
  ; {name= "controls"; type_= Bool; htmlName= ""}
  ; {name= "coords"; type_= String; htmlName= ""}
  ; {name= "crossOrigin"; type_= String; htmlName= ""}
  ; {name= "data"; type_= String; htmlName= ""}
  ; {name= "dateTime"; type_= String; htmlName= ""}
  ; {name= "default"; type_= Bool; htmlName= ""}
  ; {name= "defer"; type_= Bool; htmlName= ""}
  ; {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "download"; type_= String (* any *); htmlName= ""}
  ; {name= "encType"; type_= String; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "formAction"; type_= String; htmlName= ""}
  ; {name= "formEncType"; type_= String; htmlName= ""}
  ; {name= "formMethod"; type_= String; htmlName= ""}
  ; {name= "formNoValidate"; type_= Bool; htmlName= ""}
  ; {name= "formTarget"; type_= String; htmlName= ""}
  ; {name= "frameBorder"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "headers"; type_= String; htmlName= ""}
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "high"; type_= Int (* number *); htmlName= ""}
  ; {name= "href"; type_= String; htmlName= ""}
  ; {name= "hrefLang"; type_= String; htmlName= ""}
  ; {name= "htmlFor"; type_= String; htmlName= ""}
  ; {name= "httpEquiv"; type_= String; htmlName= ""}
  ; {name= "integrity"; type_= String; htmlName= ""}
  ; {name= "keyParams"; type_= String; htmlName= ""}
  ; {name= "keyType"; type_= String; htmlName= ""}
  ; {name= "kind"; type_= String; htmlName= ""}
  ; {name= "label"; type_= String; htmlName= ""}
  ; {name= "list"; type_= String; htmlName= ""}
  ; {name= "loop"; type_= Bool; htmlName= ""}
  ; {name= "low"; type_= Int (* number *); htmlName= ""}
  ; {name= "manifest"; type_= String; htmlName= ""}
  ; {name= "marginHeight"; type_= Int (* number *); htmlName= ""}
  ; {name= "marginWidth"; type_= Int (* number *); htmlName= ""}
  ; {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "maxLength"; type_= Int (* number *); htmlName= ""}
  ; {name= "media"; type_= String; htmlName= ""}
  ; {name= "mediaGroup"; type_= String; htmlName= ""}
  ; {name= "method"; type_= String; htmlName= ""}
  ; {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "minLength"; type_= Int (* number *); htmlName= ""}
  ; {name= "multiple"; type_= Bool; htmlName= ""}
  ; {name= "muted"; type_= Bool; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "nonce"; type_= String; htmlName= ""}
  ; {name= "noValidate"; type_= Bool; htmlName= ""}
  ; {name= "open"; type_= Bool; htmlName= ""}
  ; {name= "optimum"; type_= Int (* number *); htmlName= ""}
  ; {name= "pattern"; type_= String; htmlName= ""}
  ; {name= "placeholder"; type_= String; htmlName= ""}
  ; {name= "playsInline"; type_= Bool; htmlName= ""}
  ; {name= "poster"; type_= String; htmlName= ""}
  ; {name= "preload"; type_= String; htmlName= ""}
  ; {name= "readOnly"; type_= Bool; htmlName= ""}
  ; {name= "rel"; type_= String; htmlName= ""}
  ; {name= "required"; type_= Bool; htmlName= ""}
  ; {name= "reversed"; type_= Bool; htmlName= ""}
  ; {name= "rows"; type_= Int (* number *); htmlName= ""}
  ; {name= "rowSpan"; type_= Int (* number *); htmlName= ""}
  ; {name= "sandbox"; type_= String; htmlName= ""}
  ; {name= "scope"; type_= String; htmlName= ""}
  ; {name= "scoped"; type_= Bool; htmlName= ""}
  ; {name= "scrolling"; type_= String; htmlName= ""}
  ; {name= "seamless"; type_= Bool; htmlName= ""}
  ; {name= "selected"; type_= Bool; htmlName= ""}
  ; {name= "shape"; type_= String; htmlName= ""}
  ; {name= "size"; type_= Int (* number *); htmlName= ""}
  ; {name= "sizes"; type_= String; htmlName= ""}
  ; {name= "span"; type_= Int (* number *); htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "srcDoc"; type_= String; htmlName= ""}
  ; {name= "srcLang"; type_= String; htmlName= ""}
  ; {name= "srcSet"; type_= String; htmlName= ""}
  ; {name= "start"; type_= Int (* number *); htmlName= ""}
  ; {name= "step"; type_= (* number | *) String; htmlName= ""}
  ; {name= "summary"; type_= String; htmlName= ""}
  ; {name= "target"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""}
  ; {name= "useMap"; type_= String; htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" }
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "wmode"; type_= String; htmlName= ""}
  ; {name= "wrap"; type_= String; htmlName= ""} ]

let anchorHTMLAttributes =
  [ {name= "download"; type_= String (* any; *); htmlName= "download"}
  ; {name= "href"; type_= String; htmlName= "href"}
  ; {name= "hrefLang"; type_= String; htmlName= "hrefLang"}
  ; {name= "media"; type_= String; htmlName= "media"}
  ; {name= "ping"; type_= String; htmlName= "ping"}
  ; {name= "rel"; type_= String; htmlName= "rel"}
  ; {name= "target"; type_= attributeAnchorTarget; htmlName= "target"}
  ; {name= "type"; type_= String; htmlName= "type"}
  ; { name= "referrerPolicy"
    ; type_= attributeReferrerPolicy
    ; htmlName= "referrerPolicy" } ]

let audioHTMLAttributes = [] (* MediaHTMLAttributes*)

let areaHTMLAttributes =
  [ {name= "alt"; type_= String; htmlName= "alt"}
  ; {name= "coords"; type_= String; htmlName= "coords"}
  ; {name= "download"; type_= String (* any *); htmlName= "download"}
  ; {name= "href"; type_= String; htmlName= "href"}
  ; {name= "hrefLang"; type_= String; htmlName= "hrefLang"}
  ; {name= "media"; type_= String; htmlName= "media"}
  ; { name= "referrerPolicy"
    ; type_= attributeReferrerPolicy
    ; htmlName= "referrerPolicy" }
  ; {name= "rel"; type_= String; htmlName= "rel"}
  ; {name= "shape"; type_= String; htmlName= "shape"}
  ; {name= "target"; type_= String; htmlName= "target"} ]

let baseHTMLAttributes =
  [ {name= "href"; type_= String; htmlName= ""}
  ; {name= "target"; type_= String; htmlName= ""} ]

let blockquoteHTMLAttributes = [{name= "cite"; type_= String; htmlName= ""}]

let buttonHTMLAttributes =
  [ {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "formAction"; type_= String; htmlName= ""}
  ; {name= "formEncType"; type_= String; htmlName= ""}
  ; {name= "formMethod"; type_= String; htmlName= ""}
  ; {name= "formNoValidate"; type_= Bool; htmlName= ""}
  ; {name= "formTarget"; type_= String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; { name= "type"
    ; type_= String (* 'submit' | 'reset' | 'button' *)
    ; htmlName= "" }
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let canvasHTMLAttributes =
  [ {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let colHTMLAttributes =
  [ {name= "span"; type_= Int (* number *); htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let colgroupHTMLAttributes =
  [{name= "span"; type_= Int (* number *); htmlName= ""}]

let dataHTMLAttributes =
  [ { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let detailsHTMLAttributes =
  [ {name= "open"; type_= Bool; htmlName= ""}
    (* { name="onToggle"; type_= ReactEventHandler<T>; htmlName="" }; *) ]

let delHTMLAttributes =
  [ {name= "cite"; type_= String; htmlName= ""}
  ; {name= "dateTime"; type_= String; htmlName= ""} ]

let dialogHTMLAttributes = [{name= "open"; type_= Bool; htmlName= ""}]

let embedHTMLAttributes =
  [ {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let fieldsetHTMLAttributes =
  [ {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""} ]

let formHTMLAttributes =
  [ {name= "acceptCharset"; type_= String; htmlName= ""}
  ; {name= "action"; type_= String; htmlName= ""}
  ; {name= "autoComplete"; type_= String; htmlName= ""}
  ; {name= "encType"; type_= String; htmlName= ""}
  ; {name= "method"; type_= String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "noValidate"; type_= Bool; htmlName= ""}
  ; {name= "target"; type_= String; htmlName= ""} ]

let htmlHTMLAttributes = [{name= "manifest"; type_= String; htmlName= ""}]

let iframeHTMLAttributes =
  [ {name= "allow"; type_= String; htmlName= ""}
  ; {name= "allowFullScreen"; type_= Bool; htmlName= ""}
  ; {name= "allowTransparency"; type_= Bool; htmlName= ""}
  ; (* @deprecated *)
    {name= "frameBorder"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "loading"; type_= String (* "eager" | "lazy" *); htmlName= ""}
  ; (* @deprecated *)
    {name= "marginHeight"; type_= Int (* number *); htmlName= ""}
  ; (* @deprecated *)
    {name= "marginWidth"; type_= Int (* number *); htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "referrerPolicy"; type_= attributeReferrerPolicy; htmlName= ""}
  ; {name= "sandbox"; type_= String; htmlName= ""}
  ; (* @deprecated *)
    {name= "scrolling"; type_= String; htmlName= ""}
  ; {name= "seamless"; type_= Bool; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "srcDoc"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let imgHTMLAttributes =
  [ {name= "alt"; type_= String; htmlName= ""}
  ; { name= "crossOrigin"
    ; type_= String (* "anonymous" | "use-credentials" | "" *)
    ; htmlName= "" }
  ; { name= "decoding"
    ; type_= String (* "async" | "auto" | "sync" *)
    ; htmlName= "" }
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "loading"; type_= String (* "eager" | "lazy" *); htmlName= ""}
  ; {name= "referrerPolicy"; type_= attributeReferrerPolicy; htmlName= ""}
  ; {name= "sizes"; type_= String; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "srcSet"; type_= String; htmlName= ""}
  ; {name= "useMap"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let insHTMLAttributes =
  [ {name= "cite"; type_= String; htmlName= ""}
  ; {name= "dateTime"; type_= String; htmlName= ""} ]

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
  [ {name= "accept"; type_= String; htmlName= ""}
  ; {name= "alt"; type_= String; htmlName= ""}
  ; {name= "autoComplete"; type_= String; htmlName= ""}
  ; {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; { name= "capture"
    ; type_= (* Bool | *) String
    ; (* https://www.w3.org/TR/html-media-capture/ *) htmlName= "" }
  ; {name= "checked"; type_= Bool; htmlName= ""}
  ; {name= "crossOrigin"; type_= String; htmlName= ""}
  ; {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "formAction"; type_= String; htmlName= ""}
  ; {name= "formEncType"; type_= String; htmlName= ""}
  ; {name= "formMethod"; type_= String; htmlName= ""}
  ; {name= "formNoValidate"; type_= Bool; htmlName= ""}
  ; {name= "formTarget"; type_= String; htmlName= ""}
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "list"; type_= String; htmlName= ""}
  ; {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "maxLength"; type_= Int (* number *); htmlName= ""}
  ; {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "minLength"; type_= Int (* number *); htmlName= ""}
  ; {name= "multiple"; type_= Bool; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "pattern"; type_= String; htmlName= ""}
  ; {name= "placeholder"; type_= String; htmlName= ""}
  ; {name= "readOnly"; type_= Bool; htmlName= ""}
  ; {name= "required"; type_= Bool; htmlName= ""}
  ; {name= "size"; type_= Int (* number *); htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "step"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "type"; type_= inputTypeAttribute; htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" }
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""}
    (* { name="onChange"; type_= ChangeEventHandler<T>; htmlName="" }; *) ]

let keygenHTMLAttributes =
  [ {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; {name= "challenge"; type_= String; htmlName= ""}
  ; {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "keyType"; type_= String; htmlName= ""}
  ; {name= "keyParams"; type_= String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""} ]

let labelHTMLAttributes =
  [ {name= "form"; type_= String; htmlName= ""}
  ; {name= "htmlFor"; type_= String; htmlName= ""} ]

let liHTMLAttributes =
  [ { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let linkHTMLAttributes =
  [ {name= "as"; type_= String; htmlName= ""}
  ; {name= "crossOrigin"; type_= String; htmlName= ""}
  ; {name= "href"; type_= String; htmlName= ""}
  ; {name= "hrefLang"; type_= String; htmlName= ""}
  ; {name= "integrity"; type_= String; htmlName= ""}
  ; {name= "imageSrcSet"; type_= String; htmlName= ""}
  ; {name= "media"; type_= String; htmlName= ""}
  ; {name= "referrerPolicy"; type_= attributeReferrerPolicy; htmlName= ""}
  ; {name= "rel"; type_= String; htmlName= ""}
  ; {name= "sizes"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""}
  ; {name= "charSet"; type_= String; htmlName= ""} ]

let mapHTMLAttributes = [{name= "name"; type_= String; htmlName= ""}]

let menuHTMLAttributes = [{name= "type"; type_= String; htmlName= ""}]

let mediaHTMLAttributes =
  [ {name= "autoPlay"; type_= Bool; htmlName= ""}
  ; {name= "controls"; type_= Bool; htmlName= ""}
  ; {name= "controlsList"; type_= String; htmlName= ""}
  ; {name= "crossOrigin"; type_= String; htmlName= ""}
  ; {name= "loop"; type_= Bool; htmlName= ""}
  ; {name= "mediaGroup"; type_= String; htmlName= ""}
  ; {name= "muted"; type_= Bool; htmlName= ""}
  ; {name= "playsInline"; type_= Bool; htmlName= ""}
  ; {name= "preload"; type_= String; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""} ]

let metaHTMLAttributes =
  [ {name= "charSet"; type_= String; htmlName= ""}
  ; {name= "content"; type_= String; htmlName= ""}
  ; {name= "httpEquiv"; type_= String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "media"; type_= String; htmlName= ""} ]

let meterHTMLAttributes =
  [ {name= "form"; type_= String; htmlName= ""}
  ; {name= "high"; type_= Int (* number *); htmlName= ""}
  ; {name= "low"; type_= Int (* number *); htmlName= ""}
  ; {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "optimum"; type_= Int (* number *); htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let quoteHTMLAttributes = [{name= "cite"; type_= String; htmlName= ""}]

let objectHTMLAttributes =
  [ {name= "classID"; type_= String; htmlName= ""}
  ; {name= "data"; type_= String; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""}
  ; {name= "useMap"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "wmode"; type_= String; htmlName= ""} ]

let olHTMLAttributes =
  [ {name= "reversed"; type_= Bool; htmlName= ""}
  ; {name= "start"; type_= Int (* number *); htmlName= ""}
  ; {name= "type"; type_= String (* '1' | 'a' | 'A' | 'i' | 'I' *); htmlName= ""}
  ]

let optgroupHTMLAttributes =
  [ {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "label"; type_= String; htmlName= ""} ]

let optionHTMLAttributes =
  [ {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "label"; type_= String; htmlName= ""}
  ; {name= "selected"; type_= Bool; htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let outputHTMLAttributes =
  [ {name= "form"; type_= String; htmlName= ""}
  ; {name= "htmlFor"; type_= String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""} ]

let paramHTMLAttributes =
  [ {name= "name"; type_= String; htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let progressHTMLAttributes =
  [ {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" } ]

let slotHTMLAttributes = [{name= "name"; type_= String; htmlName= ""}]

let scriptHTMLAttributes =
  [ {name= "async"; type_= Bool; htmlName= ""}
  ; (* @deprecated *)
    {name= "charSet"; type_= String; htmlName= ""}
  ; {name= "crossOrigin"; type_= String; htmlName= ""}
  ; {name= "defer"; type_= Bool; htmlName= ""}
  ; {name= "integrity"; type_= String; htmlName= ""}
  ; {name= "noModule"; type_= Bool; htmlName= ""}
  ; {name= "nonce"; type_= String; htmlName= ""}
  ; {name= "referrerPolicy"; type_= attributeReferrerPolicy; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""} ]

let selectHTMLAttributes =
  [ {name= "autoComplete"; type_= String; htmlName= ""}
  ; {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "multiple"; type_= Bool; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "required"; type_= Bool; htmlName= ""}
  ; {name= "size"; type_= Int (* number *); htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" }
    (* { name="onChange"; type_= ChangeEventHandler<T>; htmlName="" }; *) ]

let sourceHTMLAttributes =
  [ {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "media"; type_= String; htmlName= ""}
  ; {name= "sizes"; type_= String; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "srcSet"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let styleHTMLAttributes =
  [ {name= "media"; type_= String; htmlName= ""}
  ; {name= "nonce"; type_= String; htmlName= ""}
  ; {name= "scoped"; type_= Bool; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""} ]

let tableHTMLAttributes =
  [ {name= "cellPadding"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "cellSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "summary"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""} ]

let textareaHTMLAttributes =
  [ {name= "autoComplete"; type_= String; htmlName= ""}
  ; {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; {name= "cols"; type_= Int (* number *); htmlName= ""}
  ; {name= "dirName"; type_= String; htmlName= ""}
  ; {name= "disabled"; type_= Bool; htmlName= ""}
  ; {name= "form"; type_= String; htmlName= ""}
  ; {name= "maxLength"; type_= Int (* number *); htmlName= ""}
  ; {name= "minLength"; type_= Int (* number *); htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "placeholder"; type_= String; htmlName= ""}
  ; {name= "readOnly"; type_= Bool; htmlName= ""}
  ; {name= "required"; type_= Bool; htmlName= ""}
  ; {name= "rows"; type_= Int (* number *); htmlName= ""}
  ; { name= "value"
    ; type_= String (* | ReadonlyArray<String> | number *)
    ; htmlName= "" }
  ; {name= "wrap"; type_= String; htmlName= ""}
    (* { name="onChange"; type_= ChangeEventHandler<T>; htmlName="" }; *) ]

let tdHTMLAttributes =
  [ { name= "align"
    ; type_=
        String (* type_= "left" | "center" | "right" | "justify" | "char" *)
    ; htmlName= "" }
  ; {name= "colSpan"; type_= Int (* number *); htmlName= ""}
  ; {name= "headers"; type_= String; htmlName= ""}
  ; {name= "rowSpan"; type_= Int (* number *); htmlName= ""}
  ; {name= "scope"; type_= String; htmlName= ""}
  ; {name= "abbr"; type_= String; htmlName= ""}
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "valign"
    ; type_= String (* "top" | "middle" | "bottom" | "baseline" *)
    ; htmlName= "" } ]

let thHTMLAttributes =
  [ { name= "align"
    ; type_= String (* "left" | "center" | "right" | "justify" | "char" *)
    ; htmlName= "" }
  ; {name= "colSpan"; type_= Int (* number *); htmlName= ""}
  ; {name= "headers"; type_= String; htmlName= ""}
  ; {name= "rowSpan"; type_= Int (* number *); htmlName= ""}
  ; {name= "scope"; type_= String; htmlName= ""}
  ; {name= "abbr"; type_= String; htmlName= ""} ]

let timeHTMLAttributes = [{name= "dateTime"; type_= String; htmlName= ""}]

let trackHTMLAttributes =
  [ {name= "default"; type_= Bool; htmlName= ""}
  ; {name= "kind"; type_= String; htmlName= ""}
  ; {name= "label"; type_= String; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "srcLang"; type_= String; htmlName= ""} ]

(* MediaHTMLAttributes*)
let videoHTMLAttributes =
  [ {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "playsInline"; type_= Bool; htmlName= ""}
  ; {name= "poster"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "disablePictureInPicture"; type_= Bool; htmlName= ""} ]

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
    {name= "className"; type_= String; htmlName= ""}
  ; {name= "color"; type_= String; htmlName= ""}
  ; {name= "height"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "id"; type_= String; htmlName= ""}
  ; {name= "lang"; type_= String; htmlName= ""}
  ; {name= "max"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "media"; type_= String; htmlName= ""}
  ; {name= "method"; type_= String; htmlName= ""}
  ; {name= "min"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "name"; type_= String; htmlName= ""}
  ; {name= "style"; type_= Style; htmlName= ""}
  ; {name= "target"; type_= String; htmlName= ""}
  ; {name= "type"; type_= String; htmlName= ""}
  ; {name= "width"; type_= (* number |  *) String; htmlName= ""}
  ; (* Other HTML properties supported by SVG elements in browsers *)
    {name= "role"; type_= ariaRole; htmlName= ""}
  ; {name= "tabIndex"; type_= Int (* number *); htmlName= ""}
  ; { name= "crossOrigin"
    ; type_= String (* "anonymous" | "use-credentials" | "" *)
    ; htmlName= "" }
  ; (* SVG Specific attributes *)
    {name= "accentHeight"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "accumulate"; type_= String (* type_= "none" | "sum" *); htmlName= ""}
  ; { name= "additive"
    ; type_= String (* type_= "replace" | "sum" *)
    ; htmlName= "" }
  ; { name= "alignmentBaseline"
    ; type_= String
    ; (* type_= "auto" | "baseline" | "before-edge" | "text-before-edge" | "middle" | "central" | "after-edge"
         "text-after-edge" | "ideographic" | "alphabetic" | "hanging" | "mathematical" | "inherit"; *)
      htmlName= "" }
  ; {name= "allowReorder"; type_= String (* type_= "no" | "yes" *); htmlName= ""}
  ; {name= "alphabetic"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "amplitude"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "arabicForm"
    ; type_= String (* type_= "initial" | "medial" | "terminal" | "isolated" *)
    ; htmlName= "" }
  ; {name= "ascent"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "attributeName"; type_= String; htmlName= ""}
  ; {name= "attributeType"; type_= String; htmlName= ""}
  ; {name= "autoReverse"; type_= String (* Booleanish *); htmlName= ""}
  ; {name= "azimuth"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "baseFrequency"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "baselineShift"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "baseProfile"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "bbox"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "begin"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "bias"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "by"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "calcMode"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "capHeight"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "clip"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "clipPath"; type_= String; htmlName= ""}
  ; {name= "clipPathUnits"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "clipRule"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "colorInterpolation"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "colorInterpolationFilters"
    ; type_= String (* type_= "auto" | "sRGB" | "linearRGB" | "inherit" *)
    ; htmlName= "" }
  ; {name= "colorProfile"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "colorRendering"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "contentScriptType"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "contentStyleType"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "cursor"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "cx"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "cy"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "d"; type_= String; htmlName= ""}
  ; {name= "decelerate"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "descent"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "diffuseConstant"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "direction"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "display"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "divisor"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "dominantBaseline"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "dur"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "dx"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "dy"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "edgeMode"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "elevation"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "enableBackground"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "end"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "exponent"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "externalResourcesRequired"
    ; type_= String (* Booleanish *)
    ; htmlName= "" }
  ; {name= "fill"; type_= String; htmlName= ""}
  ; {name= "fillOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "fillRule"
    ; type_= String (* type_= "nonzero" | "evenodd" | "inherit" *)
    ; htmlName= "" }
  ; {name= "filter"; type_= String; htmlName= ""}
  ; {name= "filterRes"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "filterUnits"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "floodColor"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "floodOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "focusable"; type_= String (* Booleanish | "auto" *); htmlName= ""}
  ; {name= "fontFamily"; type_= String; htmlName= ""}
  ; {name= "fontSize"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fontSizeAdjust"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fontStretch"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fontStyle"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fontVariant"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fontWeight"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "format"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fr"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "from"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fx"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "fy"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "g1"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "g2"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "glyphName"; type_= (* number |  *) String; htmlName= ""}
  ; { name= "glyphOrientationHorizontal"
    ; type_= (* number |  *) String
    ; htmlName= "" }
  ; { name= "glyphOrientationVertical"
    ; type_= (* number |  *) String
    ; htmlName= "" }
  ; {name= "glyphRef"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "gradientTransform"; type_= String; htmlName= ""}
  ; {name= "gradientUnits"; type_= String; htmlName= ""}
  ; {name= "hanging"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "horizAdvX"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "horizOriginX"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "href"; type_= String; htmlName= ""}
  ; {name= "ideographic"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "imageRendering"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "in2"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "in"; type_= String; htmlName= ""}
  ; {name= "intercept"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "k1"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "k2"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "k3"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "k4"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "k"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "kernelMatrix"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "kernelUnitLength"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "kerning"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "keyPoints"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "keySplines"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "keyTimes"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "lengthAdjust"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "letterSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "lightingColor"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "limitingConeAngle"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "local"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "markerEnd"; type_= String; htmlName= ""}
  ; {name= "markerHeight"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "markerMid"; type_= String; htmlName= ""}
  ; {name= "markerStart"; type_= String; htmlName= ""}
  ; {name= "markerUnits"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "markerWidth"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "mask"; type_= String; htmlName= ""}
  ; {name= "maskContentUnits"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "maskUnits"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "mathematical"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "mode"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "numOctaves"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "offset"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "opacity"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "operator"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "order"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "orient"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "orientation"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "origin"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "overflow"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "overlinePosition"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "overlineThickness"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "paintOrder"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "panose1"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "path"; type_= String; htmlName= ""}
  ; {name= "pathLength"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "patternContentUnits"; type_= String; htmlName= ""}
  ; {name= "patternTransform"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "patternUnits"; type_= String; htmlName= ""}
  ; {name= "pointerEvents"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "points"; type_= String; htmlName= ""}
  ; {name= "pointsAtX"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "pointsAtY"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "pointsAtZ"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "preserveAlpha"; type_= String (* Booleanish *); htmlName= ""}
  ; {name= "preserveAspectRatio"; type_= String; htmlName= ""}
  ; {name= "primitiveUnits"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "r"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "radius"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "refX"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "refY"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "renderingIntent"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "repeatCount"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "repeatDur"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "requiredExtensions"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "requiredFeatures"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "restart"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "result"; type_= String; htmlName= ""}
  ; {name= "rotate"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "rx"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "ry"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "scale"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "seed"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "shapeRendering"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "slope"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "spacing"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "specularConstant"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "specularExponent"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "speed"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "spreadMethod"; type_= String; htmlName= ""}
  ; {name= "startOffset"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "stdDeviation"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "stemh"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "stemv"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "stitchTiles"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "stopColor"; type_= String; htmlName= ""}
  ; {name= "stopOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "strikethroughPosition"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "strikethroughThickness"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "String"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "stroke"; type_= String; htmlName= ""}
  ; {name= "strokeDasharray"; type_= String (* | number *); htmlName= ""}
  ; {name= "strokeDashoffset"; type_= String (* | number *); htmlName= ""}
  ; { name= "strokeLinecap"
    ; type_= String (* type_= "butt" | "round" | "square" | "inherit" *)
    ; htmlName= "" }
  ; { name= "strokeLinejoin"
    ; type_= String (* type_= "miter" | "round" | "bevel" | "inherit" *)
    ; htmlName= "" }
  ; {name= "strokeMiterlimit"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "strokeOpacity"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "strokeWidth"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "surfaceScale"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "systemLanguage"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "tableValues"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "targetX"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "targetY"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "textAnchor"; type_= String; htmlName= ""}
  ; {name= "textDecoration"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "textLength"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "textRendering"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "to"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "transform"; type_= String; htmlName= ""}
  ; {name= "u1"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "u2"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "underlinePosition"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "underlineThickness"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "unicode"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "unicodeBidi"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "unicodeRange"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "unitsPerEm"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "vAlphabetic"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "values"; type_= String; htmlName= ""}
  ; {name= "vectorEffect"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "version"; type_= String; htmlName= ""}
  ; {name= "vertAdvY"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "vertOriginX"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "vertOriginY"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "vHanging"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "vIdeographic"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "viewBox"; type_= String; htmlName= ""}
  ; {name= "viewTarget"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "visibility"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "vMathematical"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "widths"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "wordSpacing"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "writingMode"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "x1"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "x2"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "x"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "xChannelSelector"; type_= String; htmlName= ""}
  ; {name= "xHeight"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "xlinkActuate"; type_= String; htmlName= ""}
  ; {name= "xlinkArcrole"; type_= String; htmlName= ""}
  ; {name= "xlinkHref"; type_= String; htmlName= ""}
  ; {name= "xlinkRole"; type_= String; htmlName= ""}
  ; {name= "xlinkShow"; type_= String; htmlName= ""}
  ; {name= "xlinkTitle"; type_= String; htmlName= ""}
  ; {name= "xlinkType"; type_= String; htmlName= ""}
  ; {name= "xmlBase"; type_= String; htmlName= ""}
  ; {name= "xmlLang"; type_= String; htmlName= ""}
  ; {name= "xmlns"; type_= String; htmlName= ""}
  ; {name= "xmlnsXlink"; type_= String; htmlName= ""}
  ; {name= "xmlSpace"; type_= String; htmlName= ""}
  ; {name= "y1"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "y2"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "y"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "yChannelSelector"; type_= String; htmlName= ""}
  ; {name= "z"; type_= (* number |  *) String; htmlName= ""}
  ; {name= "zoomAndPan"; type_= String; htmlName= ""} ]

let webViewHTMLAttributes =
  [ {name= "allowFullScreen"; type_= Bool; htmlName= ""}
  ; {name= "allowpopups"; type_= Bool; htmlName= ""}
  ; {name= "autoFocus"; type_= Bool; htmlName= ""}
  ; {name= "autosize"; type_= Bool; htmlName= ""}
  ; {name= "blinkfeatures"; type_= String; htmlName= ""}
  ; {name= "disableblinkfeatures"; type_= String; htmlName= ""}
  ; {name= "disableguestresize"; type_= Bool; htmlName= ""}
  ; {name= "disablewebsecurity"; type_= Bool; htmlName= ""}
  ; {name= "guestinstance"; type_= String; htmlName= ""}
  ; {name= "httpreferrer"; type_= String; htmlName= ""}
  ; {name= "nodeintegration"; type_= Bool; htmlName= ""}
  ; {name= "partition"; type_= String; htmlName= ""}
  ; {name= "plugins"; type_= Bool; htmlName= ""}
  ; {name= "preload"; type_= String; htmlName= ""}
  ; {name= "src"; type_= String; htmlName= ""}
  ; {name= "useragent"; type_= String; htmlName= ""}
  ; {name= "webpreferences"; type_= String; htmlName= ""} ]

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
