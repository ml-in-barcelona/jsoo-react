module Vdom_raw = Raw

(** This has 3 kinds of constructors.
    {v
      - constructors for properties / attributes for which we
        have written first class ocaml representations (so far only Style,
        Class, and Handler)

      - Those which we immediately convert into Js called Raw, which
        in turn has two cases:
        - Property for properties on the DOM
        - Attribute for attributes on the DOM

      - Hooks, which register callbacks on property addition and removal.
    v}

    Generally speaking one should avoid creating a property or attribute
    for something for which we have a first class representation.
*)

(* module Event_handler = struct
  type t =
    | T :
        { type_id : 'a Type_equal.Id.t
        ; handler : (#Dom_html.event as 'a) Js.t -> unit
        }
        -> t

  let combine
        (T { type_id = ltid; handler = lhandler })
        (T { type_id = rtid; handler = rhandler } as right)
    =
    (* If they are not the same witness, then it is a bug in virtual_dom, since
       we do not expose [on] anymore which means this library can determined the
       [Type_equal.Id] corresponding to each event. virtual_dom maintains the
       invariant that any two events with the same name will produce handlers
       that have the same [Type_equal.Id]. *)
    match Type_equal.Id.same_witness ltid rtid with
    | Some T ->
      T
        { type_id = ltid
        ; handler =
            (fun value ->
               Effect.sequence_as_sibling (lhandler value) ~unless_stopped:(fun () ->
                 rhandler value))
        }
    | None ->
      eprint_s
        [%message
          "BUG!  Type-ids for event handlers differ"
            (ltid : _ Type_equal.Id.t)
            (rtid : _ Type_equal.Id.t)];
      right
  ;;
end *)

type t =
  | Property of
      { suppress_merge_warnings : bool
      ; name : string
      ; value : Js_of_ocaml.Js.Unsafe.any
      }
  | Attribute of
      { suppress_merge_warnings : bool
      ; name : string
      ; value : Js_of_ocaml.Js.Unsafe.any
      }
  (* | Handler of
      { name : string
      ; handler : Event_handler.t
      } *)
  (* | Hook of
      { name : string
      ; hook : Hooks.t
      } *)
  (* | Style of Css_gen.t *)
  (* | Class of (string, String.comparator_witness) Set.t *)
  | Many of t list
  (* | Many_only_merge_classes_and_styles of
      t list * (Css_gen.t -> Css_gen.t) * (String.Set.t -> String.Set.t)
  | Many_without_merge of t list *)

let create name value =
  Attribute
    { suppress_merge_warnings = false; name; value = Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value) }
;;

(* let create_float name value =
  Attribute
    { suppress_merge_warnings = false
    ; name
    ; value = Js.Unsafe.inject (Dom_float.to_js_string value)
    }
;; *)

let property name value = Property { suppress_merge_warnings = false; name; value }

let string_property name value =
  Property
    { suppress_merge_warnings = false; name; value = Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.string value) }
;;

let bool_property name value =
  Property
    { suppress_merge_warnings = false; name; value = Js_of_ocaml.Js.Unsafe.inject (Js_of_ocaml.Js.bool value) }
;;

let suppress_merge_warnings = function
  | Attribute attribute -> Attribute { attribute with suppress_merge_warnings = true }
  | Property property -> Property { property with suppress_merge_warnings = true }
  | t -> t
;;

(* let create_hook name hook = Hook { name; hook } *)
let many attrs = Many attrs
(* let many_without_merge attrs = Many_without_merge attrs *)
let empty = Many []
let combine left right = Many [ left; right ]
let ( @ ) = combine

(* external ojs_of_any : Js.Unsafe.any -> Gen_js_api.Ojs.t = "%identity" *)

module Unmerged_warning_mode = struct
  type t =
    | No_warnings
    | All_warnings
    | Stop_after_quota of int

  let warning_count = ref 0
  let current = ref (Stop_after_quota 100)

  (* let warn_s s =
    incr warning_count;
    match !current with
    | No_warnings -> ()
    | All_warnings -> eprint_s s
    | Stop_after_quota quota ->
      let warning_count = !warning_count in
      if warning_count <= quota
      then (
        eprint_s s;
        if warning_count = quota
        then
          eprint_s
            [%message
              "WARNING: reached warning message quota; no more messages will be printed"
                (quota : int)])
  ;; *)

  module For_testing = struct
    let reset_warning_count () = warning_count := 0
  end
end

module SS = Set.Make(String)

type merge =
  { (* styles : Css_gen.t 
  ;*) classes : SS.t
  ;(* handlers : Event_handler.t Map.M(String).t
  ; hooks : Hooks.t Map.M(String).t*)
  }

(* let combining_map_add map key value ~combine =
  Map.update map key ~f:(function
    | Some existing_value -> combine ~key existing_value value
    | None -> value)
;; *)

let empty_merge =
  { (* styles = Css_gen.empty
  ; *)classes = SS.empty
  ; (* handlers = Map.empty (module String)
  ; hooks = Map.empty (module String)*)
  }
;;

let to_raw attr =
  let attrs = [ attr ] in
  (* When input elements have their value set to what it already is
     the cursor gets moved to the end of the field even when the user
     is editing in the middle. SoftSetHook (from ./soft-set-hook.js)
     compares before setting, avoiding the problem just like in
     https://github.com/Matt-Esch/virtual-dom/blob/947ecf92b67d25bb693a0f625fa8e90c099887d5/virtual-hyperscript/index.js#L43-L51

     note that Elm's virtual-dom includes a workaround for this so
     if we switch to that the workaround here will be unnecessary.
     https://github.com/elm-lang/virtual-dom/blob/17b30fb7de48672565d6227d33c0176f075786db/src/Native/VirtualDom.js#L434-L439
  *)
  let attrs_obj : Dom.domProps = Dom.create () in
  (* [take_second_*] is the trivial merge function (i.e. no merge at all); it
     takes two attributes of the same kind, ignores a first, and emits
     a warning if [warn_about_unmerged_attributes] is enabled. *)
  (* let take_second_styles first second =
    if not (Css_gen.is_empty first)
    then
      Unmerged_warning_mode.warn_s
        [%message
          "WARNING: not combining styles" (first : Css_gen.t) (second : Css_gen.t)];
    second
  in *)
  let take_second_classes _first second =
    (* if not (SS.is_empty first)
    then
      Unmerged_warning_mode.warn_s
        [%message
          "WARNING: not combining classes" (first : String.Set.t) (second : String.Set.t)]; *)
    second
  in
  (* let take_second_handler ~key:name _first second =
    Unmerged_warning_mode.warn_s
      [%message "WARNING: not combining handlers" (name : string)];
    second
  in
  let take_second_hook ~key:name _first second =
    Unmerged_warning_mode.warn_s [%message "WARNING: not combining hooks" (name : string)];
    second
  in *)
  (* We merge attributes when they are written to the raw attribute object,
     rather than when the user-facing merge functions ([many], [combine], and
     [@]) are called. This strategy is better in both speed and memory usage,
     since it means we do not need to concatenate the list of "unmergeable"
     attributes (Property and Attribute); instead, we can iterate through the
     tree of attributes and eagerly write unmergeable attributes to the
     attribute object as we find them. If two unmergeable attributes have the
     same name, the second will simply overwrite the first, as desired.

     In order to preserve the existing behavior of the [Multi] module (that is,
     it must be possible to merge classes and styles, but not hooks and
     handlers), we introduce the workaround constructor
     [Many_only_merge_classes_and_styles].

     There are thus three cases that each have different merge behaviors:
     - Simple lists - no merging
     - Lists wrapped in a [Many] - merges classes, styles, hooks, and handlers
     - Lists wrapped in a [Many_only_merge_classes_and_styles] - merges classes and styles

     To avoid duplicating the match expression logic, we paremeterize it by the
     merging behavior, since "no merge" really means "merge by taking the
     second one". *)
  let rec merge ~combine_hook ~combine_handler ~combine_styles ~combine_classes acc =
    List.fold_left (fun acc attr ->
      match attr with
      | Property { suppress_merge_warnings; name; value } ->
        if Raw.Attrs.has_property attrs_obj name && not suppress_merge_warnings
        then
          Unmerged_warning_mode.warn_s
            [%message "WARNING: not combining properties" (name : string)];
        (match name with
         | "value" ->
           let softSetHook x : Gen_js_api.Ojs.t = Js.Unsafe.global ## SoftSetHook x in
           let value = softSetHook value in
           Vdom_raw.Attrs.set_property attrs_obj "value" value
         | name -> Raw.Attrs.set_property attrs_obj name (ojs_of_any value));
        acc
      | Attribute { suppress_merge_warnings; name; value } ->
        if Raw.Attrs.has_attribute attrs_obj name && not suppress_merge_warnings
        then
          Unmerged_warning_mode.warn_s
            [%message "WARNING: not combining attributes" (name : string)];
        Raw.Attrs.set_attribute attrs_obj name (ojs_of_any value);
        acc
      (* | Style new_styles -> { acc with styles = combine_styles acc.styles new_styles } *)
      (* | Class new_classes ->
        { acc with classes = combine_classes acc.classes new_classes } *)
      (* | Hook { name; hook } ->
        { acc with hooks = combining_map_add acc.hooks name hook ~combine:combine_hook }
      | Handler { name; handler } ->
        { acc with
          handlers =
            combining_map_add acc.handlers name handler ~combine:combine_handler
        } *)
      | Many attrs ->
        let sub_merge =
          merge
            ~combine_hook:(fun ~key:_ -> Hooks.combine)
            ~combine_handler:(fun ~key:_ -> Event_handler.combine)
            ~combine_styles:Css_gen.combine
            ~combine_classes:Set.union
            empty_merge
            attrs
        in
        { styles = combine_styles acc.styles sub_merge.styles
        ; classes = combine_classes acc.classes sub_merge.classes
        ; handlers =
            Map.merge_skewed acc.handlers sub_merge.handlers ~combine:combine_handler
        ; hooks = Map.merge_skewed acc.hooks sub_merge.hooks ~combine:combine_hook
        }
      (* | Many_only_merge_classes_and_styles (attrs, map_styles, map_classes) ->
        let sub_merge =
          merge
            ~combine_hook:take_second_hook
            ~combine_handler:take_second_handler
            ~combine_styles:Css_gen.combine
            ~combine_classes:Set.union
            empty_merge
            attrs
        in
        { styles = map_styles (combine_styles acc.styles sub_merge.styles)
        ; classes = map_classes (combine_classes acc.classes sub_merge.classes)
        ; handlers =
            Map.merge_skewed acc.handlers sub_merge.handlers ~combine:combine_handler
        ; hooks = Map.merge_skewed acc.hooks sub_merge.hooks ~combine:combine_hook
        } *)
      (* | Many_without_merge attrs ->
        let sub_merge =
          merge
            ~combine_hook:take_second_hook
            ~combine_handler:take_second_handler
            ~combine_styles:take_second_styles
            ~combine_classes:take_second_classes
            empty_merge
            attrs
        in
        { styles = combine_styles acc.styles sub_merge.styles
        ; classes = combine_classes acc.classes sub_merge.classes
        ; handlers =
            Map.merge_skewed acc.handlers sub_merge.handlers ~combine:combine_handler
        ; hooks = Map.merge_skewed acc.hooks sub_merge.hooks ~combine:combine_hook
        } *)) acc
  in
  let merge =
    merge
      (* ~combine_hook:take_second_hook
      ~combine_handler:take_second_handler
      ~combine_styles:take_second_styles *)
      ~combine_classes:take_second_classes
      empty_merge
      attrs
  in
  Map.iteri merge.hooks ~f:(fun ~key:name ~data:hook ->
    Raw.Attrs.set_property attrs_obj name (ojs_of_any (Hooks.pack hook)));
  Map.iteri merge.handlers ~f:(fun ~key:name ~data:(Event_handler.T { handler; _ }) ->
    let f e =
      Effect.Expert.handle e (handler e);
      Js._true
    in
    Raw.Attrs.set_property
      attrs_obj
      ("on" ^ name)
      (ojs_of_any (Js.Unsafe.inject (Dom.handler f))));
  let () =
    if not (Css_gen.is_empty merge.styles)
    then (
      let props = Css_gen.to_string_list merge.styles in
      let obj = Gen_js_api.Ojs.empty_obj () in
      List.iter props ~f:(fun (k, v) ->
        Gen_js_api.Ojs.set_prop_ascii obj k (Gen_js_api.Ojs.string_to_js v));
      Raw.Attrs.set_property attrs_obj "style" obj)
  in
  let () =
    if Set.is_empty merge.classes
    then ()
    else
      Raw.Attrs.set_attribute
        attrs_obj
        "class"
        (Gen_js_api.Ojs.string_to_js (String.concat (Set.to_list merge.classes) ~sep:" "))
  in
  attrs_obj
;;

let to_raw attr =
  match attr with
  | Many [] | Many_without_merge [] -> Raw.Attrs.create ()
  | attr -> to_raw attr
;;

let style css = Style css

let valid_class_name s =
  let invalid = String.is_empty s || String.exists s ~f:Char.is_whitespace in
  not invalid
;;

let%test "valid" = valid_class_name "foo-bar"
let%test "invalid-empty" = not (valid_class_name "")
let%test "invalid-space" = not (valid_class_name "foo bar")

let class_ classname =
  if not (valid_class_name classname)
  then raise_s [%message "invalid classname" (classname : string)];
  Class (Set.singleton (module String) classname)
;;

let classes' classes = Class classes

let classes classnames =
  if not (List.for_all ~f:valid_class_name classnames)
  then raise_s [%message "invalid classnames" (classnames : string list)];
  classes' (Set.of_list (module String) classnames)
;;

let id s = create "id" s
let name s = create "name" s
let href r = create "href" r
let target s = create "target" s
let checked = create "checked" ""
let selected = create "selected" ""
let hidden = create "hidden" ""
let readonly = create "readonly" ""
let disabled = create "disabled" ""
let placeholder x = create "placeholder" x
let autofocus b = create "autofocus" (Bool.to_string b)
let for_ x = create "for" x
let type_ x = create "type" x
let value x = create "value" x
let value_prop x = string_property "value" x
let tabindex x = create "tabindex" (Int.to_string x)
let title x = create "title" x
let src x = create "src" x
let min x = create_float "min" x
let max x = create_float "max" x
let colspan x = create "colspan" (Int.to_string x)
let rowspan x = create "rowspan" (Int.to_string x)
let draggable b = create "draggable" (Bool.to_string b)

module Type_id = struct
  (* We provide a trivial [to_sexp] function since we only want
     to unify type ids and not convert types to ids *)
  let create name = Type_equal.Id.create ~name (fun _ -> Sexplib.Sexp.List [])
  let (event : Dom_html.event Type_equal.Id.t) = create "event"
  let (focus : Dom_html.focusEvent Type_equal.Id.t) = create "focusEvent"
  let (mouse : Dom_html.mouseEvent Type_equal.Id.t) = create "mouseEvent"
  let (keyboard : Dom_html.keyboardEvent Type_equal.Id.t) = create "keyboardEvent"
  let (submit : Dom_html.submitEvent Type_equal.Id.t) = create "submitEvent"
  let (mousewheel : Dom_html.mousewheelEvent Type_equal.Id.t) = create "mousewheelEvent"
  let (clipboard : Dom_html.clipboardEvent Type_equal.Id.t) = create "clipboardEvent"
  let (drag : Dom_html.dragEvent Type_equal.Id.t) = create "dragEvent"
  let (pointer : Dom_html.pointerEvent Type_equal.Id.t) = create "pointerEvent"
  let (animation : Dom_html.animationEvent Type_equal.Id.t) = create "animationEvent"
end

let on type_id name (handler : #Dom_html.event Js.t -> unit Ui_effect.t) : t =
  Handler { name; handler = T { handler; type_id } }
;;

let on_focus = on Type_id.focus "focus"
let on_blur = on Type_id.focus "blur"
let on_click = on Type_id.mouse "click"
let on_contextmenu = on Type_id.mouse "contextmenu"
let on_double_click = on Type_id.mouse "dblclick"
let on_drag = on Type_id.drag "drag"
let on_dragstart = on Type_id.drag "dragstart"
let on_dragend = on Type_id.drag "dragend"
let on_dragenter = on Type_id.drag "dragenter"
let on_dragleave = on Type_id.drag "dragleave"
let on_dragover = on Type_id.drag "dragover"
let on_drop = on Type_id.drag "drop"
let on_mousemove = on Type_id.mouse "mousemove"
let on_mouseup = on Type_id.mouse "mouseup"
let on_mousedown = on Type_id.mouse "mousedown"
let on_mouseenter = on Type_id.mouse "mouseenter"
let on_mouseleave = on Type_id.mouse "mouseleave"
let on_mouseover = on Type_id.mouse "mouseover"
let on_mouseout = on Type_id.mouse "mouseout"
let on_keyup = on Type_id.keyboard "keyup"
let on_keypress = on Type_id.keyboard "keypress"
let on_keydown = on Type_id.keyboard "keydown"
let on_scroll = on Type_id.event "scroll"
let on_submit = on Type_id.submit "submit"
let on_pointerdown = on Type_id.pointer "pointerdown"
let on_mousewheel = on Type_id.mousewheel "mousewheel"
let on_copy = on Type_id.clipboard "copy"
let on_cut = on Type_id.clipboard "cut"
let on_paste = on Type_id.clipboard "paste"
let on_reset = on Type_id.event "reset"
let on_animationend = on Type_id.animation "animationend"
let const_ignore _ = Effect.Ignore

class type value_element =
  object
    inherit Dom_html.element
    method value : Js.js_string Js.t Js.prop
  end

type value_coercion = Dom_html.element Js.t -> value_element Js.t Js.opt

let run_coercion coercion target prev =
  match prev with
  | Some _ -> prev
  | None -> Js.Opt.to_option (coercion target)
;;

let coerce_value_element target =
  let open Dom_html.CoerceTo in
  None
  |> run_coercion (input :> value_coercion) target
  |> run_coercion (select :> value_coercion) target
  |> run_coercion (textarea :> value_coercion) target
;;

let on_input_event type_id event handler =
  on type_id event (fun ev ->
    Js.Opt.case ev##.target const_ignore (fun target ->
      Option.value_map
        (coerce_value_element target)
        ~default:Effect.Ignore
        ~f:(fun target ->
          let text = Js.to_string target##.value in
          handler ev text)))
;;

let on_change = on_input_event Type_id.event "change"
let on_input = on_input_event Type_id.event "input"
let to_raw l = to_raw l

let on_file_input handler =
  on Type_id.event "input" (fun ev ->
    Js.Opt.case ev##.target const_ignore (fun target ->
      Js.Opt.case (Dom_html.CoerceTo.input target) const_ignore (fun target ->
        Js.Optdef.case target##.files const_ignore (fun files -> handler ev files))))
;;

module Always_focus_hook = struct
  module T = struct
    module State = Unit

    module Input = struct
      include Unit

      let combine () () = ()
    end

    let init () _ = ()
    let on_mount () () element = element##focus
    let update ~old_input:() ~new_input:() () _ = ()
    let destroy () () _ = ()
  end

  module Hook = Hooks.Make (T)

  let attr `Read_the_docs__this_hook_is_unpredictable =
    (* Append the id to the name of the hook to ensure that it is distinct
       from all other focus hooks. *)
    create_hook "always-focus-hook" (Hook.create ())
  ;;
end

module Single_focus_hook () = struct
  module T = struct
    module State = Unit

    let has_been_used = ref false

    module Input = struct
      type t = (unit Ui_effect.t[@sexp.opaque]) [@@deriving sexp_of]

      let combine left right = Ui_effect.Many [ left; right ]
    end

    let init _ _ = ()

    let on_mount event () element =
      if not !has_been_used
      then (
        has_been_used := true;
        element##focus;
        Effect.Expert.handle_non_dom_event_exn event)
    ;;

    let update ~old_input:_ ~new_input:_ () _ = ()
    let destroy _ () _ = ()
  end

  module Hook = Hooks.Make (T)

  let attr `Read_the_docs__this_hook_is_unpredictable ~after =
    (* Append the id to the name of the hook to ensure that it is distinct
       from all other focus hooks. *)
    create_hook "single-focus-hook" (Hook.create after)
  ;;
end

module Multi = struct

  type attr = t
  type t = attr list

  let map_style t ~f = [ Many_only_merge_classes_and_styles (t, f, Fn.id) ]

  let add_class t c =
    [ Many_only_merge_classes_and_styles (t, Fn.id, fun cs -> Set.add cs c) ]
  ;;

  let add_style t s = map_style t ~f:(fun ss -> Css_gen.combine ss s)

  let merge_classes_and_styles t =
    [ Many_only_merge_classes_and_styles (t, Fn.id, Fn.id) ]
  ;;
end

module Expert = struct
  let rec filter_by_kind t ~f =
    match t with
    | Property _ -> if f `Property then t else empty
    | Attribute _ -> if f `Attribute then t else empty
    | Hook _ -> if f `Hook then t else empty
    | Handler _ -> if f `Handler then t else empty
    | Style _ -> if f `Style then t else empty
    | Class _ -> if f `Class then t else empty
    | Many attrs -> Many (List.map attrs ~f:(filter_by_kind ~f))
    | Many_only_merge_classes_and_styles (attrs, a, b) ->
      Many_only_merge_classes_and_styles (List.map attrs ~f:(filter_by_kind ~f), a, b)
    | Many_without_merge attrs ->
      Many_without_merge (List.map attrs ~f:(filter_by_kind ~f))
  ;;

  let rec contains_name looking_for = function
    | Property { name; _ } | Attribute { name; _ } | Hook { name; _ } ->
      String.equal looking_for name
    | Handler { name; _ } -> String.equal ("on" ^ name) looking_for
    | Style _ -> String.equal looking_for "style"
    | Class _ -> String.equal looking_for "class"
    | Many attrs
    | Many_only_merge_classes_and_styles (attrs, _, _)
    | Many_without_merge attrs -> List.exists ~f:(contains_name looking_for) attrs
  ;;
end
