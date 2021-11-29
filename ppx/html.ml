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

let commonDOMAttributes =
  [ (* dangerouslySetInnerHTML?: {
           __html: string;
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
  [ (* /** Identifies the currently active element when DOM focus is on a composite widget, textbox, group, or application. */
        'aria-activedescendant'?: string;
        /** Indicates whether assistive technologies will present all, or only parts of, the changed region based on the change notifications defined by the aria-relevant attribute. */
        'aria-atomic'?: boolean | 'false' | 'true';
        /**
     * Indicates whether inputting text could trigger display of one or more predictions of the user's intended value for an input and specifies how predictions would be
     * presented if they are made.
     */
        'aria-autocomplete'?: 'none' | 'inline' | 'list' | 'both';
        /** Indicates an element is being modified and that assistive technologies MAY want to wait until the modifications are complete before exposing them to the user. */
        'aria-busy'?: boolean | 'false' | 'true';
        /**
     * Indicates the current "checked" state of checkboxes, radio buttons, and other widgets.
     * @see aria-pressed @see aria-selected.
     */
        'aria-checked'?: boolean | 'false' | 'mixed' | 'true';
        /**
     * Defines the total number of columns in a table, grid, or treegrid.
     * @see aria-colindex.
     */
        'aria-colcount'?: number;
        /**
     * Defines an element's column index or position with respect to the total number of columns within a table, grid, or treegrid.
     * @see aria-colcount @see aria-colspan.
     */
        'aria-colindex'?: number;
        /**
     * Defines the number of columns spanned by a cell or gridcell within a table, grid, or treegrid.
     * @see aria-colindex @see aria-rowspan.
     */
        'aria-colspan'?: number;
        /**
     * Identifies the element (or elements) whose contents or presence are controlled by the current element.
     * @see aria-owns.
     */
        'aria-controls'?: string;
        /** Indicates the element that represents the current item within a container or set of related elements. */
        'aria-current'?: boolean | 'false' | 'true' | 'page' | 'step' | 'location' | 'date' | 'time';
        /**
     * Identifies the element (or elements) that describes the object.
     * @see aria-labelledby
     */
        'aria-describedby'?: string;
        /**
     * Identifies the element that provides a detailed, extended description for the object.
     * @see aria-describedby.
     */
        'aria-details'?: string;
        /**
     * Indicates that the element is perceivable but disabled, so it is not editable or otherwise operable.
     * @see aria-hidden @see aria-readonly.
     */
        'aria-disabled'?: boolean | 'false' | 'true';
        /**
     * Indicates what functions can be performed when a dragged object is released on the drop target.
     * @deprecated in ARIA 1.1
     */
        'aria-dropeffect'?: 'none' | 'copy' | 'execute' | 'link' | 'move' | 'popup';
        /**
     * Identifies the element that provides an error message for the object.
     * @see aria-invalid @see aria-describedby.
     */
        'aria-errormessage'?: string;
        /** Indicates whether the element, or another grouping element it controls, is currently expanded or collapsed. */
        'aria-expanded'?: boolean | 'false' | 'true';
        /**
     * Identifies the next element (or elements) in an alternate reading order of content which, at the user's discretion,
     * allows assistive technology to override the general default of reading in document source order.
     */
        'aria-flowto'?: string;
        /**
     * Indicates an element's "grabbed" state in a drag-and-drop operation.
     * @deprecated in ARIA 1.1
     */
        'aria-grabbed'?: boolean | 'false' | 'true';
        /** Indicates the availability and type of interactive popup element, such as menu or dialog, that can be triggered by an element. */
        'aria-haspopup'?: boolean | 'false' | 'true' | 'menu' | 'listbox' | 'tree' | 'grid' | 'dialog';
        /**
     * Indicates whether the element is exposed to an accessibility API.
     * @see aria-disabled.
     */
        'aria-hidden'?: boolean | 'false' | 'true';
        /**
     * Indicates the entered value does not conform to the format expected by the application.
     * @see aria-errormessage.
     */
        'aria-invalid'?: boolean | 'false' | 'true' | 'grammar' | 'spelling';
        /** Indicates keyboard shortcuts that an author has implemented to activate or give focus to an element. */
        'aria-keyshortcuts'?: string;
        /**
     * Defines a string value that labels the current element.
     * @see aria-labelledby.
     */
        'aria-label'?: string;
        /**
     * Identifies the element (or elements) that labels the current element.
     * @see aria-describedby.
     */
        'aria-labelledby'?: string;
        /** Defines the hierarchical level of an element within a structure. */
        'aria-level'?: number;
        /** Indicates that an element will be updated, and describes the types of updates the user agents, assistive technologies, and user can expect from the live region. */
        'aria-live'?: 'off' | 'assertive' | 'polite';
        /** Indicates whether an element is modal when displayed. */
        'aria-modal'?: boolean | 'false' | 'true';
        /** Indicates whether a text box accepts multiple lines of input or only a single line. */
        'aria-multiline'?: boolean | 'false' | 'true';
        /** Indicates that the user may select more than one item from the current selectable descendants. */
        'aria-multiselectable'?: boolean | 'false' | 'true';
        /** Indicates whether the element's orientation is horizontal, vertical, or unknown/ambiguous. */
        'aria-orientation'?: 'horizontal' | 'vertical';
        /**
     * Identifies an element (or elements) in order to define a visual, functional, or contextual parent/child relationship
     * between DOM elements where the DOM hierarchy cannot be used to represent the relationship.
     * @see aria-controls.
     */
        'aria-owns'?: string;
        /**
     * Defines a short hint (a word or short phrase) intended to aid the user with data entry when the control has no value.
     * A hint could be a sample value or a brief description of the expected format.
     */
        'aria-placeholder'?: string;
        /**
     * Defines an element's number or position in the current set of listitems or treeitems. Not required if all elements in the set are present in the DOM.
     * @see aria-setsize.
     */
        'aria-posinset'?: number;
        /**
     * Indicates the current "pressed" state of toggle buttons.
     * @see aria-checked @see aria-selected.
     */
        'aria-pressed'?: boolean | 'false' | 'mixed' | 'true';
        /**
     * Indicates that the element is not editable, but is otherwise operable.
     * @see aria-disabled.
     */
        'aria-readonly'?: boolean | 'false' | 'true';
        /**
     * Indicates what notifications the user agent will trigger when the accessibility tree within a live region is modified.
     * @see aria-atomic.
     */
        'aria-relevant'?: 'additions' | 'additions removals' | 'additions text' | 'all' | 'removals' | 'removals additions' | 'removals text' | 'text' | 'text additions' | 'text removals';
        /** Indicates that user input is required on the element before a form may be submitted. */
        'aria-required'?: boolean | 'false' | 'true';
        /** Defines a human-readable, author-localized description for the role of an element. */
        'aria-roledescription'?: string;
        /**
     * Defines the total number of rows in a table, grid, or treegrid.
     * @see aria-rowindex.
     */
        'aria-rowcount'?: number;
        /**
     * Defines an element's row index or position with respect to the total number of rows within a table, grid, or treegrid.
     * @see aria-rowcount @see aria-rowspan.
     */
        'aria-rowindex'?: number;
        /**
     * Defines the number of rows spanned by a cell or gridcell within a table, grid, or treegrid.
     * @see aria-rowindex @see aria-colspan.
     */
        'aria-rowspan'?: number;
        /**
     * Indicates the current "selected" state of various widgets.
     * @see aria-checked @see aria-pressed.
     */
        'aria-selected'?: boolean | 'false' | 'true';
        /**
     * Defines the number of items in the current set of listitems or treeitems. Not required if all elements in the set are present in the DOM.
     * @see aria-posinset.
     */
        'aria-setsize'?: number;
        /** Indicates if items in a table or grid are sorted in ascending or descending order. */
        'aria-sort'?: 'none' | 'ascending' | 'descending' | 'other';
        /** Defines the maximum allowed value for a range widget. */
        'aria-valuemax'?: number;
        /** Defines the minimum allowed value for a range widget. */
        'aria-valuemin'?: number;
        /**
     * Defines the current value for a range widget.
     * @see aria-valuetext.
     */
        'aria-valuenow'?: number;
        /** Defines the human readable text alternative of aria-valuenow for a range widget. */
        'aria-valuetext'?: string; *) ]

(* All the WAI-ARIA 1.1 role attribute values from https://www.w3.org/TR/wai-aria-1.1/#role_definitions *)
type ariaRole = string
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
   | Custom of string *)

let attributesHTML = []

(* <T> extends AriaAttributes, DOMAttributes<T> { *)
(* React-specific Attributes *)
(* defaultChecked?: boolean;
   defaultValue?: string | number | ReadonlyArray<string>;
   suppressContentEditableWarning?: boolean;
   suppressHydrationWarning?: boolean; *)

(* Standard HTML Attributes *)
(* accessKey?: string;
        className?: string;
        contentEditable?: Booleanish | "inherit";
        contextMenu?: string;
        dir?: string;
        draggable?: Booleanish;
        hidden?: boolean;
        id?: string;
        lang?: string;
        placeholder?: string;
        slot?: string;
        spellCheck?: Booleanish;
        style?: CSSProperties;
        tabIndex?: number;
        title?: string;
        translate?: 'yes' | 'no';

        // Unknown
        radioGroup?: string; // <command>, <menuitem>

        // WAI-ARIA
        role?: AriaRole;

        // RDFa Attributes
        about?: string;
        datatype?: string;
        inlist?: any;
        prefix?: string;
        property?: string;
        resource?: string;
        typeof?: string;
        vocab?: string;

        // Non-standard Attributes
        autoCapitalize?: string;
        autoCorrect?: string;
        autoSave?: string;
        color?: string;
        itemProp?: string;
        itemScope?: boolean;
        itemType?: string;
        itemID?: string;
        itemRef?: string;
        results?: number;
        security?: string;
        unselectable?: 'on' | 'off';

        // Living Standard
        /**
 * Hints at the type of data that might be entered by the user while editing the element or its contents
 * @see https://html.spec.whatwg.org/multipage/interaction.html#input-modalities:-the-inputmode-attribute
 */
        inputMode?: 'none' | 'text' | 'tel' | 'url' | 'email' | 'numeric' | 'decimal' | 'search';
        /**
 * Specify that a standard HTML element should behave like a defined custom built-in element
 * @see https://html.spec.whatwg.org/multipage/custom-elements.html#attr-is
 */
        is?: string; *)

let allHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       // Standard HTML Attributes
       accept?: string;
       acceptCharset?: string;
       action?: string;
       allowFullScreen?: boolean;
       allowTransparency?: boolean;
       alt?: string;
       as?: string;
       async?: boolean;
       autoComplete?: string;
       autoFocus?: boolean;
       autoPlay?: boolean;
       capture?: boolean | string;
       cellPadding?: number | string;
       cellSpacing?: number | string;
       charSet?: string;
       challenge?: string;
       checked?: boolean;
       cite?: string;
       classID?: string;
       cols?: number;
       colSpan?: number;
       content?: string;
       controls?: boolean;
       coords?: string;
       crossOrigin?: string;
       data?: string;
       dateTime?: string;
       default?: boolean;
       defer?: boolean;
       disabled?: boolean;
       download?: any;
       encType?: string;
       form?: string;
       formAction?: string;
       formEncType?: string;
       formMethod?: string;
       formNoValidate?: boolean;
       formTarget?: string;
       frameBorder?: number | string;
       headers?: string;
       height?: number | string;
       high?: number;
       href?: string;
       hrefLang?: string;
       htmlFor?: string;
       httpEquiv?: string;
       integrity?: string;
       keyParams?: string;
       keyType?: string;
       kind?: string;
       label?: string;
       list?: string;
       loop?: boolean;
       low?: number;
       manifest?: string;
       marginHeight?: number;
       marginWidth?: number;
       max?: number | string;
       maxLength?: number;
       media?: string;
       mediaGroup?: string;
       method?: string;
       min?: number | string;
       minLength?: number;
       multiple?: boolean;
       muted?: boolean;
       name?: string;
       nonce?: string;
       noValidate?: boolean;
       open?: boolean;
       optimum?: number;
       pattern?: string;
       placeholder?: string;
       playsInline?: boolean;
       poster?: string;
       preload?: string;
       readOnly?: boolean;
       rel?: string;
       required?: boolean;
       reversed?: boolean;
       rows?: number;
       rowSpan?: number;
       sandbox?: string;
       scope?: string;
       scoped?: boolean;
       scrolling?: string;
       seamless?: boolean;
       selected?: boolean;
       shape?: string;
       size?: number;
       sizes?: string;
       span?: number;
       src?: string;
       srcDoc?: string;
       srcLang?: string;
       srcSet?: string;
       start?: number;
       step?: number | string;
       summary?: string;
       target?: string;
       type?: string;
       useMap?: string;
       value?: string | ReadonlyArray<string> | number;
       width?: number | string;
       wmode?: string;
       wrap?: string;
   } *)

type attributeReferrerPolicy = string
(* | Empty
   | NoReferrer
   | NoReferrerWhenDowngrade
   | Origin
   | OriginWhenCrossOrigin
   | SameOrigin
   | StrictOrigin
   | StrictOriginWhenCrossOrigin
   | UnsafeUrl *)

type attributeAnchorTarget = string
(* | Self
   | Blank
   | Parent
   | Top
   | Custom of string *)

let anchorHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       download?: any;
       href?: string;
       hrefLang?: string;
       media?: string;
       ping?: string;
       rel?: string;
       target?: HTMLAttributeAnchorTarget;
       type?: string;
       referrerPolicy?: HTMLAttributeReferrerPolicy;
   } *)

let audioHTMLAttributes = [] (* <T> extends MediaHTMLAttributes<T> {} *)

let areaHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       alt?: string;
       coords?: string;
       download?: any;
       href?: string;
       hrefLang?: string;
       media?: string;
       referrerPolicy?: HTMLAttributeReferrerPolicy;
       rel?: string;
       shape?: string;
       target?: string;
   } *)

let baseHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       href?: string;
       target?: string;
   } *)

let blockquoteHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       cite?: string;
   } *)

let buttonHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       autoFocus?: boolean;
       disabled?: boolean;
       form?: string;
       formAction?: string;
       formEncType?: string;
       formMethod?: string;
       formNoValidate?: boolean;
       formTarget?: string;
       name?: string;
       type?: 'submit' | 'reset' | 'button';
       value?: string | ReadonlyArray<string> | number;
   } *)

let canvasHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       height?: number | string;
       width?: number | string;
   } *)

let colHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       span?: number;
       width?: number | string;
   } *)

let colgroupHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       span?: number;
   } *)

let dataHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       value?: string | ReadonlyArray<string> | number;
   } *)

let detailsHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       open?: boolean;
       onToggle?: ReactEventHandler<T>;
   } *)

let delHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       cite?: string;
       dateTime?: string;
   } *)

let dialogHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       open?: boolean;
   } *)

let embedHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       height?: number | string;
       src?: string;
       type?: string;
       width?: number | string;
   } *)

let fieldsetHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       disabled?: boolean;
       form?: string;
       name?: string;
   } *)

let formHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       acceptCharset?: string;
       action?: string;
       autoComplete?: string;
       encType?: string;
       method?: string;
       name?: string;
       noValidate?: boolean;
       target?: string;
   } *)

let htmlHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       manifest?: string;
   } *)

let iframeHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       allow?: string;
       allowFullScreen?: boolean;
       allowTransparency?: boolean;
       /** @deprecated */
       frameBorder?: number | string;
       height?: number | string;
       loading?: "eager" | "lazy";
       /** @deprecated */
       marginHeight?: number;
       /** @deprecated */
       marginWidth?: number;
       name?: string;
       referrerPolicy?: HTMLAttributeReferrerPolicy;
       sandbox?: string;
       /** @deprecated */
       scrolling?: string;
       seamless?: boolean;
       src?: string;
       srcDoc?: string;
       width?: number | string;
   } *)

let imgHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       alt?: string;
       crossOrigin?: "anonymous" | "use-credentials" | "";
       decoding?: "async" | "auto" | "sync";
       height?: number | string;
       loading?: "eager" | "lazy";
       referrerPolicy?: HTMLAttributeReferrerPolicy;
       sizes?: string;
       src?: string;
       srcSet?: string;
       useMap?: string;
       width?: number | string;
   } *)

let insHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       cite?: string;
       dateTime?: string;
   } *)

type inputTypeAttribute = string
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
        | (string & {});  *)

let inputHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       accept?: string;
       alt?: string;
       autoComplete?: string;
       autoFocus?: boolean;
       capture?: boolean | string; // https://www.w3.org/TR/html-media-capture/#the-capture-attribute
       checked?: boolean;
       crossOrigin?: string;
       disabled?: boolean;
       form?: string;
       formAction?: string;
       formEncType?: string;
       formMethod?: string;
       formNoValidate?: boolean;
       formTarget?: string;
       height?: number | string;
       list?: string;
       max?: number | string;
       maxLength?: number;
       min?: number | string;
       minLength?: number;
       multiple?: boolean;
       name?: string;
       pattern?: string;
       placeholder?: string;
       readOnly?: boolean;
       required?: boolean;
       size?: number;
       src?: string;
       step?: number | string;
       type?: HTMLInputTypeAttribute;
       value?: string | ReadonlyArray<string> | number;
       width?: number | string;

       onChange?: ChangeEventHandler<T>;
   } *)

let keygenHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       autoFocus?: boolean;
       challenge?: string;
       disabled?: boolean;
       form?: string;
       keyType?: string;
       keyParams?: string;
       name?: string;
   } *)

let labelHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       form?: string;
       htmlFor?: string;
   } *)

let liHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       value?: string | ReadonlyArray<string> | number;
   } *)

let linkHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       as?: string;
       crossOrigin?: string;
       href?: string;
       hrefLang?: string;
       integrity?: string;
       imageSrcSet?: string;
       media?: string;
       referrerPolicy?: HTMLAttributeReferrerPolicy;
       rel?: string;
       sizes?: string;
       type?: string;
       charSet?: string;
   } *)

let mapHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       name?: string;
   } *)

let menuHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       type?: string;
   } *)

let mediaHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       autoPlay?: boolean;
       controls?: boolean;
       controlsList?: string;
       crossOrigin?: string;
       loop?: boolean;
       mediaGroup?: string;
       muted?: boolean;
       playsInline?: boolean;
       preload?: string;
       src?: string;
   } *)

let metaHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       charSet?: string;
       content?: string;
       httpEquiv?: string;
       name?: string;
       media?: string;
   } *)

let meterHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       form?: string;
       high?: number;
       low?: number;
       max?: number | string;
       min?: number | string;
       optimum?: number;
       value?: string | ReadonlyArray<string> | number;
   } *)

let quoteHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       cite?: string;
   } *)

let objectHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       classID?: string;
       data?: string;
       form?: string;
       height?: number | string;
       name?: string;
       type?: string;
       useMap?: string;
       width?: number | string;
       wmode?: string;
   } *)

let olHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       reversed?: boolean;
       start?: number;
       type?: '1' | 'a' | 'A' | 'i' | 'I';
   } *)

let optgroupHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       disabled?: boolean;
       label?: string;
   } *)

let optionHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       disabled?: boolean;
       label?: string;
       selected?: boolean;
       value?: string | ReadonlyArray<string> | number;
   } *)

let outputHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       form?: string;
       htmlFor?: string;
       name?: string;
   } *)

let paramHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       name?: string;
       value?: string | ReadonlyArray<string> | number;
   } *)

let progressHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       max?: number | string;
       value?: string | ReadonlyArray<string> | number;
   } *)

let slotHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       name?: string;
   } *)

let scriptHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       async?: boolean;
       /** @deprecated */
       charSet?: string;
       crossOrigin?: string;
       defer?: boolean;
       integrity?: string;
       noModule?: boolean;
       nonce?: string;
       referrerPolicy?: HTMLAttributeReferrerPolicy;
       src?: string;
       type?: string;
   } *)

let selectHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       autoComplete?: string;
       autoFocus?: boolean;
       disabled?: boolean;
       form?: string;
       multiple?: boolean;
       name?: string;
       required?: boolean;
       size?: number;
       value?: string | ReadonlyArray<string> | number;
       onChange?: ChangeEventHandler<T>;
   } *)

let sourceHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       height?: number | string;
       media?: string;
       sizes?: string;
       src?: string;
       srcSet?: string;
       type?: string;
       width?: number | string;
   } *)

let styleHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       media?: string;
       nonce?: string;
       scoped?: boolean;
       type?: string;
   } *)

let tableHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       cellPadding?: number | string;
       cellSpacing?: number | string;
       summary?: string;
       width?: number | string;
   } *)

let textareaHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       autoComplete?: string;
       autoFocus?: boolean;
       cols?: number;
       dirName?: string;
       disabled?: boolean;
       form?: string;
       maxLength?: number;
       minLength?: number;
       name?: string;
       placeholder?: string;
       readOnly?: boolean;
       required?: boolean;
       rows?: number;
       value?: string | ReadonlyArray<string> | number;
       wrap?: string;

       onChange?: ChangeEventHandler<T>;
   } *)

let tdHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       align?: "left" | "center" | "right" | "justify" | "char";
       colSpan?: number;
       headers?: string;
       rowSpan?: number;
       scope?: string;
       abbr?: string;
       height?: number | string;
       width?: number | string;
       valign?: "top" | "middle" | "bottom" | "baseline";
   } *)

let thHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       align?: "left" | "center" | "right" | "justify" | "char";
       colSpan?: number;
       headers?: string;
       rowSpan?: number;
       scope?: string;
       abbr?: string;
   } *)

let timeHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       dateTime?: string;
   } *)

let trackHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       default?: boolean;
       kind?: string;
       label?: string;
       src?: string;
       srcLang?: string;
   } *)

let videoHTMLAttributes = []
(* <T> extends MediaHTMLAttributes<T> {
       height?: number | string;
       playsInline?: boolean;
       poster?: string;
       width?: number | string;
       disablePictureInPicture?: boolean;
   } *)

(* // this list is "complete" in that it contains every SVG attribute
   // that React supports, but the types can be improved.
   // Full list here: https://facebook.github.io/react/docs/dom-elements.html
   //
   // The three broad type categories are (in order of restrictiveness):
   //   - "number | string"
   //   - "string"
   //   - union of string literals *)
let sVGAttributes = []
(* <T> extends AriaAttributes, DOMAttributes<T> {
       // Attributes which also defined in HTMLAttributes
       // See comment in SVGDOMPropertyConfig.js
       className?: string;
       color?: string;
       height?: number | string;
       id?: string;
       lang?: string;
       max?: number | string;
       media?: string;
       method?: string;
       min?: number | string;
       name?: string;
       style?: CSSProperties;
       target?: string;
       type?: string;
       width?: number | string;

       // Other HTML properties supported by SVG elements in browsers
       role?: AriaRole;
       tabIndex?: number;
       crossOrigin?: "anonymous" | "use-credentials" | "";

       // SVG Specific attributes
       accentHeight?: number | string;
       accumulate?: "none" | "sum";
       additive?: "replace" | "sum";
       alignmentBaseline?: "auto" | "baseline" | "before-edge" | "text-before-edge" | "middle" | "central" | "after-edge" |
       "text-after-edge" | "ideographic" | "alphabetic" | "hanging" | "mathematical" | "inherit";
       allowReorder?: "no" | "yes";
       alphabetic?: number | string;
       amplitude?: number | string;
       arabicForm?: "initial" | "medial" | "terminal" | "isolated";
       ascent?: number | string;
       attributeName?: string;
       attributeType?: string;
       autoReverse?: Booleanish;
       azimuth?: number | string;
       baseFrequency?: number | string;
       baselineShift?: number | string;
       baseProfile?: number | string;
       bbox?: number | string;
       begin?: number | string;
       bias?: number | string;
       by?: number | string;
       calcMode?: number | string;
       capHeight?: number | string;
       clip?: number | string;
       clipPath?: string;
       clipPathUnits?: number | string;
       clipRule?: number | string;
       colorInterpolation?: number | string;
       colorInterpolationFilters?: "auto" | "sRGB" | "linearRGB" | "inherit";
       colorProfile?: number | string;
       colorRendering?: number | string;
       contentScriptType?: number | string;
       contentStyleType?: number | string;
       cursor?: number | string;
       cx?: number | string;
       cy?: number | string;
       d?: string;
       decelerate?: number | string;
       descent?: number | string;
       diffuseConstant?: number | string;
       direction?: number | string;
       display?: number | string;
       divisor?: number | string;
       dominantBaseline?: number | string;
       dur?: number | string;
       dx?: number | string;
       dy?: number | string;
       edgeMode?: number | string;
       elevation?: number | string;
       enableBackground?: number | string;
       end?: number | string;
       exponent?: number | string;
       externalResourcesRequired?: Booleanish;
       fill?: string;
       fillOpacity?: number | string;
       fillRule?: "nonzero" | "evenodd" | "inherit";
       filter?: string;
       filterRes?: number | string;
       filterUnits?: number | string;
       floodColor?: number | string;
       floodOpacity?: number | string;
       focusable?: Booleanish | "auto";
       fontFamily?: string;
       fontSize?: number | string;
       fontSizeAdjust?: number | string;
       fontStretch?: number | string;
       fontStyle?: number | string;
       fontVariant?: number | string;
       fontWeight?: number | string;
       format?: number | string;
       fr?: number | string;
       from?: number | string;
       fx?: number | string;
       fy?: number | string;
       g1?: number | string;
       g2?: number | string;
       glyphName?: number | string;
       glyphOrientationHorizontal?: number | string;
       glyphOrientationVertical?: number | string;
       glyphRef?: number | string;
       gradientTransform?: string;
       gradientUnits?: string;
       hanging?: number | string;
       horizAdvX?: number | string;
       horizOriginX?: number | string;
       href?: string;
       ideographic?: number | string;
       imageRendering?: number | string;
       in2?: number | string;
       in?: string;
       intercept?: number | string;
       k1?: number | string;
       k2?: number | string;
       k3?: number | string;
       k4?: number | string;
       k?: number | string;
       kernelMatrix?: number | string;
       kernelUnitLength?: number | string;
       kerning?: number | string;
       keyPoints?: number | string;
       keySplines?: number | string;
       keyTimes?: number | string;
       lengthAdjust?: number | string;
       letterSpacing?: number | string;
       lightingColor?: number | string;
       limitingConeAngle?: number | string;
       local?: number | string;
       markerEnd?: string;
       markerHeight?: number | string;
       markerMid?: string;
       markerStart?: string;
       markerUnits?: number | string;
       markerWidth?: number | string;
       mask?: string;
       maskContentUnits?: number | string;
       maskUnits?: number | string;
       mathematical?: number | string;
       mode?: number | string;
       numOctaves?: number | string;
       offset?: number | string;
       opacity?: number | string;
       operator?: number | string;
       order?: number | string;
       orient?: number | string;
       orientation?: number | string;
       origin?: number | string;
       overflow?: number | string;
       overlinePosition?: number | string;
       overlineThickness?: number | string;
       paintOrder?: number | string;
       panose1?: number | string;
       path?: string;
       pathLength?: number | string;
       patternContentUnits?: string;
       patternTransform?: number | string;
       patternUnits?: string;
       pointerEvents?: number | string;
       points?: string;
       pointsAtX?: number | string;
       pointsAtY?: number | string;
       pointsAtZ?: number | string;
       preserveAlpha?: Booleanish;
       preserveAspectRatio?: string;
       primitiveUnits?: number | string;
       r?: number | string;
       radius?: number | string;
       refX?: number | string;
       refY?: number | string;
       renderingIntent?: number | string;
       repeatCount?: number | string;
       repeatDur?: number | string;
       requiredExtensions?: number | string;
       requiredFeatures?: number | string;
       restart?: number | string;
       result?: string;
       rotate?: number | string;
       rx?: number | string;
       ry?: number | string;
       scale?: number | string;
       seed?: number | string;
       shapeRendering?: number | string;
       slope?: number | string;
       spacing?: number | string;
       specularConstant?: number | string;
       specularExponent?: number | string;
       speed?: number | string;
       spreadMethod?: string;
       startOffset?: number | string;
       stdDeviation?: number | string;
       stemh?: number | string;
       stemv?: number | string;
       stitchTiles?: number | string;
       stopColor?: string;
       stopOpacity?: number | string;
       strikethroughPosition?: number | string;
       strikethroughThickness?: number | string;
       string?: number | string;
       stroke?: string;
       strokeDasharray?: string | number;
       strokeDashoffset?: string | number;
       strokeLinecap?: "butt" | "round" | "square" | "inherit";
       strokeLinejoin?: "miter" | "round" | "bevel" | "inherit";
       strokeMiterlimit?: number | string;
       strokeOpacity?: number | string;
       strokeWidth?: number | string;
       surfaceScale?: number | string;
       systemLanguage?: number | string;
       tableValues?: number | string;
       targetX?: number | string;
       targetY?: number | string;
       textAnchor?: string;
       textDecoration?: number | string;
       textLength?: number | string;
       textRendering?: number | string;
       to?: number | string;
       transform?: string;
       u1?: number | string;
       u2?: number | string;
       underlinePosition?: number | string;
       underlineThickness?: number | string;
       unicode?: number | string;
       unicodeBidi?: number | string;
       unicodeRange?: number | string;
       unitsPerEm?: number | string;
       vAlphabetic?: number | string;
       values?: string;
       vectorEffect?: number | string;
       version?: string;
       vertAdvY?: number | string;
       vertOriginX?: number | string;
       vertOriginY?: number | string;
       vHanging?: number | string;
       vIdeographic?: number | string;
       viewBox?: string;
       viewTarget?: number | string;
       visibility?: number | string;
       vMathematical?: number | string;
       widths?: number | string;
       wordSpacing?: number | string;
       writingMode?: number | string;
       x1?: number | string;
       x2?: number | string;
       x?: number | string;
       xChannelSelector?: string;
       xHeight?: number | string;
       xlinkActuate?: string;
       xlinkArcrole?: string;
       xlinkHref?: string;
       xlinkRole?: string;
       xlinkShow?: string;
       xlinkTitle?: string;
       xlinkType?: string;
       xmlBase?: string;
       xmlLang?: string;
       xmlns?: string;
       xmlnsXlink?: string;
       xmlSpace?: string;
       y1?: number | string;
       y2?: number | string;
       y?: number | string;
       yChannelSelector?: string;
       z?: number | string;
       zoomAndPan?: string;
   } *)

let webViewHTMLAttributes = []
(* <T> extends HTMLAttributes<T> {
       allowFullScreen?: boolean;
       allowpopups?: boolean;
       autoFocus?: boolean;
       autosize?: boolean;
       blinkfeatures?: string;
       disableblinkfeatures?: string;
       disableguestresize?: boolean;
       disablewebsecurity?: boolean;
       guestinstance?: string;
       httpreferrer?: string;
       nodeintegration?: boolean;
       partition?: string;
       plugins?: boolean;
       preload?: string;
       src?: string;
       useragent?: string;
       webpreferences?: string;
   } *)

let reactSVG = []
(* {
       animate: SVGFactory;
       circle: SVGFactory;
       clipPath: SVGFactory;
       defs: SVGFactory;
       desc: SVGFactory;
       ellipse: SVGFactory;
       feBlend: SVGFactory;
       feColorMatrix: SVGFactory;
       feComponentTransfer: SVGFactory;
       feComposite: SVGFactory;
       feConvolveMatrix: SVGFactory;
       feDiffuseLighting: SVGFactory;
       feDisplacementMap: SVGFactory;
       feDistantLight: SVGFactory;
       feDropShadow: SVGFactory;
       feFlood: SVGFactory;
       feFuncA: SVGFactory;
       feFuncB: SVGFactory;
       feFuncG: SVGFactory;
       feFuncR: SVGFactory;
       feGaussianBlur: SVGFactory;
       feImage: SVGFactory;
       feMerge: SVGFactory;
       feMergeNode: SVGFactory;
       feMorphology: SVGFactory;
       feOffset: SVGFactory;
       fePointLight: SVGFactory;
       feSpecularLighting: SVGFactory;
       feSpotLight: SVGFactory;
       feTile: SVGFactory;
       feTurbulence: SVGFactory;
       filter: SVGFactory;
       foreignObject: SVGFactory;
       g: SVGFactory;
       image: SVGFactory;
       line: SVGFactory;
       linearGradient: SVGFactory;
       marker: SVGFactory;
       mask: SVGFactory;
       metadata: SVGFactory;
       path: SVGFactory;
       pattern: SVGFactory;
       polygon: SVGFactory;
       polyline: SVGFactory;
       radialGradient: SVGFactory;
       rect: SVGFactory;
       stop: SVGFactory;
       svg: SVGFactory;
       switch: SVGFactory;
       symbol: SVGFactory;
       text: SVGFactory;
       textPath: SVGFactory;
       tspan: SVGFactory;
       use: SVGFactory;
       view: SVGFactory;
   } *)

(* //
   // Browser Interfaces
   // https://github.com/nikeee/2048-typescript/blob/master/2048/js/touch.d.ts
   // ---------------------------------------------------------------------- *)

let abstractView = []
(* {
       styleMedia: StyleMedia;
       document: Document;
   } *)

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
   } *)

let touchList = []
(* {
       [index: number]: Touch;
       length: number;
       item(index: number): Touch;
       identifiedTouch(identifier: number): Touch;
   } *)

(* // Error Interfaces *)
let errorInfo = []
(* {
       /**
        * Captures which component contained the exception, and its ancestors.
        */
       componentStack: string;
   } *)

let htmlElements =
  [ (* HTML *)
    { tag= "a"
    ; attributes=
        [ (* attributesHTML + <React.AnchorHTMLAttributes<HTMLAnchorElement>, HTMLAnchorElement> *) ]
    }
  ; (*
a: DetailedHTMLFactory<AnchorHTMLAttributes<HTMLAnchorElement>, HTMLAnchorElement>;
        abbr: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        address: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        area: DetailedHTMLFactory<AreaHTMLAttributes<HTMLAreaElement>, HTMLAreaElement>;
        article: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        aside: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        audio: DetailedHTMLFactory<AudioHTMLAttributes<HTMLAudioElement>, HTMLAudioElement>;
        b: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        base: DetailedHTMLFactory<BaseHTMLAttributes<HTMLBaseElement>, HTMLBaseElement>;
        bdi: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        bdo: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        big: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        blockquote: DetailedHTMLFactory<BlockquoteHTMLAttributes<HTMLElement>, HTMLElement>;
        body: DetailedHTMLFactory<HTMLAttributes<HTMLBodyElement>, HTMLBodyElement>;
        br: DetailedHTMLFactory<HTMLAttributes<HTMLBRElement>, HTMLBRElement>;
        button: DetailedHTMLFactory<ButtonHTMLAttributes<HTMLButtonElement>, HTMLButtonElement>;
        canvas: DetailedHTMLFactory<CanvasHTMLAttributes<HTMLCanvasElement>, HTMLCanvasElement>;
        caption: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        cite: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        code: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        col: DetailedHTMLFactory<ColHTMLAttributes<HTMLTableColElement>, HTMLTableColElement>;
        colgroup: DetailedHTMLFactory<ColgroupHTMLAttributes<HTMLTableColElement>, HTMLTableColElement>;
        data: DetailedHTMLFactory<DataHTMLAttributes<HTMLDataElement>, HTMLDataElement>;
        datalist: DetailedHTMLFactory<HTMLAttributes<HTMLDataListElement>, HTMLDataListElement>;
        dd: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        del: DetailedHTMLFactory<DelHTMLAttributes<HTMLElement>, HTMLElement>;
        details: DetailedHTMLFactory<DetailsHTMLAttributes<HTMLElement>, HTMLElement>;
        dfn: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        dialog: DetailedHTMLFactory<DialogHTMLAttributes<HTMLDialogElement>, HTMLDialogElement>;
        div: DetailedHTMLFactory<HTMLAttributes<HTMLDivElement>, HTMLDivElement>;
        dl: DetailedHTMLFactory<HTMLAttributes<HTMLDListElement>, HTMLDListElement>;
        dt: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        em: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        embed: DetailedHTMLFactory<EmbedHTMLAttributes<HTMLEmbedElement>, HTMLEmbedElement>;
        fieldset: DetailedHTMLFactory<FieldsetHTMLAttributes<HTMLFieldSetElement>, HTMLFieldSetElement>;
        figcaption: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        figure: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        footer: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        form: DetailedHTMLFactory<FormHTMLAttributes<HTMLFormElement>, HTMLFormElement>;
        h1: DetailedHTMLFactory<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
        h2: DetailedHTMLFactory<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
        h3: DetailedHTMLFactory<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
        h4: DetailedHTMLFactory<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
        h5: DetailedHTMLFactory<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
        h6: DetailedHTMLFactory<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
        head: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLHeadElement>;
        header: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        hgroup: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        hr: DetailedHTMLFactory<HTMLAttributes<HTMLHRElement>, HTMLHRElement>;
        html: DetailedHTMLFactory<HtmlHTMLAttributes<HTMLHtmlElement>, HTMLHtmlElement>;
        i: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        iframe: DetailedHTMLFactory<IframeHTMLAttributes<HTMLIFrameElement>, HTMLIFrameElement>;
        img: DetailedHTMLFactory<ImgHTMLAttributes<HTMLImageElement>, HTMLImageElement>;
        input: DetailedHTMLFactory<InputHTMLAttributes<HTMLInputElement>, HTMLInputElement>;
        ins: DetailedHTMLFactory<InsHTMLAttributes<HTMLModElement>, HTMLModElement>;
        kbd: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        keygen: DetailedHTMLFactory<KeygenHTMLAttributes<HTMLElement>, HTMLElement>;
        label: DetailedHTMLFactory<LabelHTMLAttributes<HTMLLabelElement>, HTMLLabelElement>;
        legend: DetailedHTMLFactory<HTMLAttributes<HTMLLegendElement>, HTMLLegendElement>;
        li: DetailedHTMLFactory<LiHTMLAttributes<HTMLLIElement>, HTMLLIElement>;
        link: DetailedHTMLFactory<LinkHTMLAttributes<HTMLLinkElement>, HTMLLinkElement>;
        main: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        map: DetailedHTMLFactory<MapHTMLAttributes<HTMLMapElement>, HTMLMapElement>;
        mark: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        menu: DetailedHTMLFactory<MenuHTMLAttributes<HTMLElement>, HTMLElement>;
        menuitem: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        meta: DetailedHTMLFactory<MetaHTMLAttributes<HTMLMetaElement>, HTMLMetaElement>;
        meter: DetailedHTMLFactory<MeterHTMLAttributes<HTMLElement>, HTMLElement>;
        nav: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        noscript: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        object: DetailedHTMLFactory<ObjectHTMLAttributes<HTMLObjectElement>, HTMLObjectElement>;
        ol: DetailedHTMLFactory<OlHTMLAttributes<HTMLOListElement>, HTMLOListElement>;
        optgroup: DetailedHTMLFactory<OptgroupHTMLAttributes<HTMLOptGroupElement>, HTMLOptGroupElement>;
        option: DetailedHTMLFactory<OptionHTMLAttributes<HTMLOptionElement>, HTMLOptionElement>;
        output: DetailedHTMLFactory<OutputHTMLAttributes<HTMLElement>, HTMLElement>;
        p: DetailedHTMLFactory<HTMLAttributes<HTMLParagraphElement>, HTMLParagraphElement>;
        param: DetailedHTMLFactory<ParamHTMLAttributes<HTMLParamElement>, HTMLParamElement>;
        picture: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        pre: DetailedHTMLFactory<HTMLAttributes<HTMLPreElement>, HTMLPreElement>;
        progress: DetailedHTMLFactory<ProgressHTMLAttributes<HTMLProgressElement>, HTMLProgressElement>;
        q: DetailedHTMLFactory<QuoteHTMLAttributes<HTMLQuoteElement>, HTMLQuoteElement>;
        rp: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        rt: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        ruby: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        s: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        samp: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        slot: DetailedHTMLFactory<SlotHTMLAttributes<HTMLSlotElement>, HTMLSlotElement>;
        script: DetailedHTMLFactory<ScriptHTMLAttributes<HTMLScriptElement>, HTMLScriptElement>;
        section: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        select: DetailedHTMLFactory<SelectHTMLAttributes<HTMLSelectElement>, HTMLSelectElement>;
        small: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        source: DetailedHTMLFactory<SourceHTMLAttributes<HTMLSourceElement>, HTMLSourceElement>;
        span: DetailedHTMLFactory<HTMLAttributes<HTMLSpanElement>, HTMLSpanElement>;
        strong: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        style: DetailedHTMLFactory<StyleHTMLAttributes<HTMLStyleElement>, HTMLStyleElement>;
        sub: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        summary: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        sup: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        table: DetailedHTMLFactory<TableHTMLAttributes<HTMLTableElement>, HTMLTableElement>;
        template: DetailedHTMLFactory<HTMLAttributes<HTMLTemplateElement>, HTMLTemplateElement>;
        tbody: DetailedHTMLFactory<HTMLAttributes<HTMLTableSectionElement>, HTMLTableSectionElement>;
        td: DetailedHTMLFactory<TdHTMLAttributes<HTMLTableDataCellElement>, HTMLTableDataCellElement>;
        textarea: DetailedHTMLFactory<TextareaHTMLAttributes<HTMLTextAreaElement>, HTMLTextAreaElement>;
        tfoot: DetailedHTMLFactory<HTMLAttributes<HTMLTableSectionElement>, HTMLTableSectionElement>;
        th: DetailedHTMLFactory<ThHTMLAttributes<HTMLTableHeaderCellElement>, HTMLTableHeaderCellElement>;
        thead: DetailedHTMLFactory<HTMLAttributes<HTMLTableSectionElement>, HTMLTableSectionElement>;
        time: DetailedHTMLFactory<TimeHTMLAttributes<HTMLElement>, HTMLElement>;
        title: DetailedHTMLFactory<HTMLAttributes<HTMLTitleElement>, HTMLTitleElement>;
        tr: DetailedHTMLFactory<HTMLAttributes<HTMLTableRowElement>, HTMLTableRowElement>;
        track: DetailedHTMLFactory<TrackHTMLAttributes<HTMLTrackElement>, HTMLTrackElement>;
        u: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        ul: DetailedHTMLFactory<HTMLAttributes<HTMLUListElement>, HTMLUListElement>;
        "var": DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        video: DetailedHTMLFactory<VideoHTMLAttributes<HTMLVideoElement>, HTMLVideoElement>;
        wbr: DetailedHTMLFactory<HTMLAttributes<HTMLElement>, HTMLElement>;
        webview: DetailedHTMLFactory<WebViewHTMLAttributes<HTMLWebViewElement>, HTMLWebViewElement>;
  abbr: attributesHTML + <HTMLElement>, HTMLElement>;
       address: attributesHTML + <HTMLElement>, HTMLElement>;
       area: attributesHTML + <React.AreaHTMLAttributes<HTMLAreaElement>, HTMLAreaElement>;
       article: attributesHTML + <HTMLElement>, HTMLElement>;
       aside: attributesHTML + <HTMLElement>, HTMLElement>;
       audio: attributesHTML + <React.AudioHTMLAttributes<HTMLAudioElement>, HTMLAudioElement>;
       b: attributesHTML + <HTMLElement>, HTMLElement>;
       base: attributesHTML + <React.BaseHTMLAttributes<HTMLBaseElement>, HTMLBaseElement>;
       bdi: attributesHTML + <HTMLElement>, HTMLElement>;
       bdo: attributesHTML + <HTMLElement>, HTMLElement>;
       big: attributesHTML + <HTMLElement>, HTMLElement>;
       blockquote: attributesHTML + <React.BlockquoteHTMLAttributes<HTMLElement>, HTMLElement>;
       body: attributesHTML + <HTMLBodyElement>, HTMLBodyElement>;
       br: attributesHTML + <HTMLBRElement>, HTMLBRElement>;
       button: attributesHTML + <React.ButtonHTMLAttributes<HTMLButtonElement>, HTMLButtonElement>;
       canvas: attributesHTML + <React.CanvasHTMLAttributes<HTMLCanvasElement>, HTMLCanvasElement>;
       caption: attributesHTML + <HTMLElement>, HTMLElement>;
       cite: attributesHTML + <HTMLElement>, HTMLElement>;
       code: attributesHTML + <HTMLElement>, HTMLElement>;
       col: attributesHTML + <React.ColHTMLAttributes<HTMLTableColElement>, HTMLTableColElement>;
       colgroup: attributesHTML + <React.ColgroupHTMLAttributes<HTMLTableColElement>, HTMLTableColElement>;
       data: attributesHTML + <React.DataHTMLAttributes<HTMLDataElement>, HTMLDataElement>;
       datalist: attributesHTML + <HTMLDataListElement>, HTMLDataListElement>;
       dd: attributesHTML + <HTMLElement>, HTMLElement>;
       del: attributesHTML + <React.DelHTMLAttributes<HTMLElement>, HTMLElement>;
       details: attributesHTML + <React.DetailsHTMLAttributes<HTMLElement>, HTMLElement>;
       dfn: attributesHTML + <HTMLElement>, HTMLElement>;
       dialog: attributesHTML + <React.DialogHTMLAttributes<HTMLDialogElement>, HTMLDialogElement>;
       div: attributesHTML + <HTMLDivElement>, HTMLDivElement>;
       dl: attributesHTML + <HTMLDListElement>, HTMLDListElement>;
       dt: attributesHTML + <HTMLElement>, HTMLElement>;
       em: attributesHTML + <HTMLElement>, HTMLElement>;
       embed: attributesHTML + <React.EmbedHTMLAttributes<HTMLEmbedElement>, HTMLEmbedElement>;
       fieldset: attributesHTML + <React.FieldsetHTMLAttributes<HTMLFieldSetElement>, HTMLFieldSetElement>;
       figcaption: attributesHTML + <HTMLElement>, HTMLElement>;
       figure: attributesHTML + <HTMLElement>, HTMLElement>;
       footer: attributesHTML + <HTMLElement>, HTMLElement>;
       form: attributesHTML + <React.FormHTMLAttributes<HTMLFormElement>, HTMLFormElement>;
       h1: attributesHTML + <HTMLHeadingElement>, HTMLHeadingElement>;
       h2: attributesHTML + <HTMLHeadingElement>, HTMLHeadingElement>;
       h3: attributesHTML + <HTMLHeadingElement>, HTMLHeadingElement>;
       h4: attributesHTML + <HTMLHeadingElement>, HTMLHeadingElement>;
       h5: attributesHTML + <HTMLHeadingElement>, HTMLHeadingElement>;
       h6: attributesHTML + <HTMLHeadingElement>, HTMLHeadingElement>;
       head: attributesHTML + <HTMLHeadElement>, HTMLHeadElement>;
       header: attributesHTML + <HTMLElement>, HTMLElement>;
       hgroup: attributesHTML + <HTMLElement>, HTMLElement>;
       hr: attributesHTML + <HTMLHRElement>, HTMLHRElement>;
       html: attributesHTML + <React.HtmlHTMLAttributes<HTMLHtmlElement>, HTMLHtmlElement>;
       i: attributesHTML + <HTMLElement>, HTMLElement>;
       iframe: attributesHTML + <React.IframeHTMLAttributes<HTMLIFrameElement>, HTMLIFrameElement>;
       img: attributesHTML + <React.ImgHTMLAttributes<HTMLImageElement>, HTMLImageElement>;
       input: attributesHTML + <React.InputHTMLAttributes<HTMLInputElement>, HTMLInputElement>;
       ins: attributesHTML + <React.InsHTMLAttributes<HTMLModElement>, HTMLModElement>;
       kbd: attributesHTML + <HTMLElement>, HTMLElement>;
       keygen: attributesHTML + <React.KeygenHTMLAttributes<HTMLElement>, HTMLElement>;
       label: attributesHTML + <React.LabelHTMLAttributes<HTMLLabelElement>, HTMLLabelElement>;
       legend: attributesHTML + <HTMLLegendElement>, HTMLLegendElement>;
       li: attributesHTML + <React.LiHTMLAttributes<HTMLLIElement>, HTMLLIElement>;
       link: attributesHTML + <React.LinkHTMLAttributes<HTMLLinkElement>, HTMLLinkElement>;
       main: attributesHTML + <HTMLElement>, HTMLElement>;
       map: attributesHTML + <React.MapHTMLAttributes<HTMLMapElement>, HTMLMapElement>;
       mark: attributesHTML + <HTMLElement>, HTMLElement>;
       menu: attributesHTML + <React.MenuHTMLAttributes<HTMLElement>, HTMLElement>;
       menuitem: attributesHTML + <HTMLElement>, HTMLElement>;
       meta: attributesHTML + <React.MetaHTMLAttributes<HTMLMetaElement>, HTMLMetaElement>;
       meter: attributesHTML + <React.MeterHTMLAttributes<HTMLElement>, HTMLElement>;
       nav: attributesHTML + <HTMLElement>, HTMLElement>;
       noindex: attributesHTML + <HTMLElement>, HTMLElement>;
       noscript: attributesHTML + <HTMLElement>, HTMLElement>;
       object_: attributesHTML + <React.ObjectHTMLAttributes<HTMLObjectElement>, HTMLObjectElement>;
       ol: attributesHTML + <React.OlHTMLAttributes<HTMLOListElement>, HTMLOListElement>;
       optgroup: attributesHTML + <React.OptgroupHTMLAttributes<HTMLOptGroupElement>, HTMLOptGroupElement>;
       option: attributesHTML + <React.OptionHTMLAttributes<HTMLOptionElement>, HTMLOptionElement>;
       output: attributesHTML + <React.OutputHTMLAttributes<HTMLElement>, HTMLElement>;
       p: attributesHTML + <HTMLParagraphElement>, HTMLParagraphElement>;
       param: attributesHTML + <React.ParamHTMLAttributes<HTMLParamElement>, HTMLParamElement>;
       picture: attributesHTML + <HTMLElement>, HTMLElement>;
       pre: attributesHTML + <HTMLPreElement>, HTMLPreElement>;
       progress: attributesHTML + <React.ProgressHTMLAttributes<HTMLProgressElement>, HTMLProgressElement>;
       q: attributesHTML + <React.QuoteHTMLAttributes<HTMLQuoteElement>, HTMLQuoteElement>;
       rp: attributesHTML + <HTMLElement>, HTMLElement>;
       rt: attributesHTML + <HTMLElement>, HTMLElement>;
       ruby: attributesHTML + <HTMLElement>, HTMLElement>;
       s: attributesHTML + <HTMLElement>, HTMLElement>;
       samp: attributesHTML + <HTMLElement>, HTMLElement>;
       slot: attributesHTML + <React.SlotHTMLAttributes<HTMLSlotElement>, HTMLSlotElement>;
       script: attributesHTML + <React.ScriptHTMLAttributes<HTMLScriptElement>, HTMLScriptElement>;
       section: attributesHTML + <HTMLElement>, HTMLElement>;
       select: attributesHTML + <React.SelectHTMLAttributes<HTMLSelectElement>, HTMLSelectElement>;
       small: attributesHTML + <HTMLElement>, HTMLElement>;
       source: attributesHTML + <React.SourceHTMLAttributes<HTMLSourceElement>, HTMLSourceElement>;
       span: attributesHTML + <HTMLSpanElement>, HTMLSpanElement>;
       strong: attributesHTML + <HTMLElement>, HTMLElement>;
       style: attributesHTML + <React.StyleHTMLAttributes<HTMLStyleElement>, HTMLStyleElement>;
       sub: attributesHTML + <HTMLElement>, HTMLElement>;
       summary: attributesHTML + <HTMLElement>, HTMLElement>;
       sup: attributesHTML + <HTMLElement>, HTMLElement>;
       table: attributesHTML + <React.TableHTMLAttributes<HTMLTableElement>, HTMLTableElement>;
       template: attributesHTML + <HTMLTemplateElement>, HTMLTemplateElement>;
       tbody: attributesHTML + <HTMLTableSectionElement>, HTMLTableSectionElement>;
       td: attributesHTML + <React.TdHTMLAttributes<HTMLTableDataCellElement>, HTMLTableDataCellElement>;
       textarea: attributesHTML + <React.TextareaHTMLAttributes<HTMLTextAreaElement>, HTMLTextAreaElement>;
       tfoot: attributesHTML + <HTMLTableSectionElement>, HTMLTableSectionElement>;
       th: attributesHTML + <React.ThHTMLAttributes<HTMLTableHeaderCellElement>, HTMLTableHeaderCellElement>;
       thead: attributesHTML + <HTMLTableSectionElement>, HTMLTableSectionElement>;
       time: attributesHTML + <React.TimeHTMLAttributes<HTMLElement>, HTMLElement>;
       title: attributesHTML + <HTMLTitleElement>, HTMLTitleElement>;
       tr: attributesHTML + <HTMLTableRowElement>, HTMLTableRowElement>;
       track: attributesHTML + <React.TrackHTMLAttributes<HTMLTrackElement>, HTMLTrackElement>;
       u: attributesHTML + <HTMLElement>, HTMLElement>;
       ul: attributesHTML + <HTMLUListElement>, HTMLUListElement>;
       "var": attributesHTML + <HTMLElement>, HTMLElement>;
       video: attributesHTML + <React.VideoHTMLAttributes<HTMLVideoElement>, HTMLVideoElement>;
       wbr: attributesHTML + <HTMLElement>, HTMLElement>;
       webview: attributesHTML + <React.WebViewHTMLAttributes<HTMLWebViewElement>, HTMLWebViewElement>;
    *)
    (* SVG *)
    {tag= "svg"; attributes= [ (* React.SVGProps<SVGSVGElement> *) ]}
    (* animate: React.SVGProps<SVGElement>; (* TODO: It is SVGAnimateElement but is not in TypeScript's lib.dom.d.ts for now. *)
       animateMotion: React.SVGProps<SVGElement>;
       animateTransform: React.SVGProps<SVGElement>; (* TODO: It is SVGAnimateTransformElement but is not in TypeScript's lib.dom.d.ts for now. *)
       circle: React.SVGProps<SVGCircleElement>;
       clipPath: React.SVGProps<SVGClipPathElement>;
       defs: React.SVGProps<SVGDefsElement>;
       desc: React.SVGProps<SVGDescElement>;
       ellipse: React.SVGProps<SVGEllipseElement>;
       feBlend: React.SVGProps<SVGFEBlendElement>;
       feColorMatrix: React.SVGProps<SVGFEColorMatrixElement>;
       feComponentTransfer: React.SVGProps<SVGFEComponentTransferElement>;
       feComposite: React.SVGProps<SVGFECompositeElement>;
       feConvolveMatrix: React.SVGProps<SVGFEConvolveMatrixElement>;
       feDiffuseLighting: React.SVGProps<SVGFEDiffuseLightingElement>;
       feDisplacementMap: React.SVGProps<SVGFEDisplacementMapElement>;
       feDistantLight: React.SVGProps<SVGFEDistantLightElement>;
       feDropShadow: React.SVGProps<SVGFEDropShadowElement>;
       feFlood: React.SVGProps<SVGFEFloodElement>;
       feFuncA: React.SVGProps<SVGFEFuncAElement>;
       feFuncB: React.SVGProps<SVGFEFuncBElement>;
       feFuncG: React.SVGProps<SVGFEFuncGElement>;
       feFuncR: React.SVGProps<SVGFEFuncRElement>;
       feGaussianBlur: React.SVGProps<SVGFEGaussianBlurElement>;
       feImage: React.SVGProps<SVGFEImageElement>;
       feMerge: React.SVGProps<SVGFEMergeElement>;
       feMergeNode: React.SVGProps<SVGFEMergeNodeElement>;
       feMorphology: React.SVGProps<SVGFEMorphologyElement>;
       feOffset: React.SVGProps<SVGFEOffsetElement>;
       fePointLight: React.SVGProps<SVGFEPointLightElement>;
       feSpecularLighting: React.SVGProps<SVGFESpecularLightingElement>;
       feSpotLight: React.SVGProps<SVGFESpotLightElement>;
       feTile: React.SVGProps<SVGFETileElement>;
       feTurbulence: React.SVGProps<SVGFETurbulenceElement>;
       filter: React.SVGProps<SVGFilterElement>;
       foreignObject: React.SVGProps<SVGForeignObjectElement>;
       g: React.SVGProps<SVGGElement>;
       image: React.SVGProps<SVGImageElement>;
       line: React.SVGProps<SVGLineElement>;
       linearGradient: React.SVGProps<SVGLinearGradientElement>;
       marker: React.SVGProps<SVGMarkerElement>;
       mask: React.SVGProps<SVGMaskElement>;
       metadata: React.SVGProps<SVGMetadataElement>;
       mpath: React.SVGProps<SVGElement>;
       path: React.SVGProps<SVGPathElement>;
       pattern: React.SVGProps<SVGPatternElement>;
       polygon: React.SVGProps<SVGPolygonElement>;
       polyline: React.SVGProps<SVGPolylineElement>;
       radialGradient: React.SVGProps<SVGRadialGradientElement>;
       rect: React.SVGProps<SVGRectElement>;
       stop: React.SVGProps<SVGStopElement>;
       switch: React.SVGProps<SVGSwitchElement>;
       symbol: React.SVGProps<SVGSymbolElement>;
       text: React.SVGProps<SVGTextElement>;
       textPath: React.SVGProps<SVGTextPathElement>;
       tspan: React.SVGProps<SVGTSpanElement>;
       use: React.SVGProps<SVGUseElement>;
       view: React.SVGProps<SVGViewElement>; *) ]
