(*
  This is the file that handles turning Reason JSX' agnostic function call into
  a jsoo-react-specific function call. Aka, this is a macro, using OCaml's ppx
  facilities; https://whitequark.org/blog/2014/04/16/a-guide-to-extension-
  points-in-ocaml/
*)

(*
   The transform:
   transform `[@JSX] div(~props1=a, ~props2=b, ~children=[foo, bar], ())` into
   `React.Dom.createDOMElementVariadic("div", React.Dom.domProps(~props1=1, ~props2=b), [foo, bar])`.
   transform the upper-cased case
   `[@JSX] Foo.createElement(~key=a, ~ref=b, ~foo=bar, ~children=[], ())` into
   `React.createElement(Foo.make, Foo.makeProps(~key=a, ~ref=b, ~foo=bar, ()))`
   transform the upper-cased case
   `[@JSX] Foo.createElement(~foo=bar, ~children=[foo, bar], ())` into
   `React.createElementVariadic(Foo.make, Foo.makeProps(~foo=bar, ~children=React.null, ()), [foo, bar])`
   transform `[@JSX] [foo]` into
   `React.createFragment([foo])`
 *)

module Ocaml_location = Location
open Ppxlib
open Ast_helper

module Context = struct
  type t = {react_dom: bool}

  let init = {react_dom= false}
end

module Str_label = struct
  type t = Labelled of string | Optional of string

  let of_arg_label : arg_label -> t = function
    | Labelled s ->
        Labelled s
    | Optional s ->
        Optional s
    | Nolabel ->
        failwith "invariant failed: Str_label called with Nolabel"

  let to_arg_label : t -> arg_label = function
    | Labelled s ->
        Labelled s
    | Optional s ->
        Optional s

  let str = function Labelled s -> s | Optional s -> s
end

let rec find_opt p = function
  | [] ->
      None
  | x :: l ->
      if p x then Some x else find_opt p l

let nolabel = Nolabel

let labelled str = Labelled str

let getLabel str =
  match str with Optional str | Labelled str -> str | Nolabel -> ""

let optionIdent = Lident "option"

let dom_tags =
  (* html *)
  [ "a"
  ; "abbr"
  ; "address"
  ; "area"
  ; "article"
  ; "aside"
  ; "audio"
  ; "b"
  ; "base"
  ; "bdi"
  ; "bdo"
  ; "big"
  ; "blockquote"
  ; "body"
  ; "br"
  ; "button"
  ; "canvas"
  ; "caption"
  ; "cite"
  ; "code"
  ; "col"
  ; "colgroup"
  ; "data"
  ; "datalist"
  ; "dd"
  ; "del"
  ; "details"
  ; "dfn"
  ; "dialog"
  ; "div"
  ; "dl"
  ; "dt"
  ; "em"
  ; "embed"
  ; "fieldset"
  ; "figcaption"
  ; "figure"
  ; "footer"
  ; "form"
  ; "h1"
  ; "h2"
  ; "h3"
  ; "h4"
  ; "h5"
  ; "h6"
  ; "head"
  ; "header"
  ; "hr"
  ; "html"
  ; "i"
  ; "iframe"
  ; "img"
  ; "input"
  ; "ins"
  ; "kbd"
  ; "keygen"
  ; "label"
  ; "legend"
  ; "li"
  ; "link"
  ; "main"
  ; "map"
  ; "mark"
  ; "menu"
  ; "menuitem"
  ; "meta"
  ; "meter"
  ; "nav"
  ; "noscript"
  ; "object"
  ; "ol"
  ; "optgroup"
  ; "option"
  ; "output"
  ; "p"
  ; "param"
  ; "picture"
  ; "pre"
  ; "progress"
  ; "q"
  ; "rp"
  ; "rt"
  ; "ruby"
  ; "s"
  ; "samp"
  ; "script"
  ; "section"
  ; "select"
  ; "small"
  ; "source"
  ; "span"
  ; "strong"
  ; "style"
  ; "sub"
  ; "summary"
  ; "sup"
  ; "table"
  ; "tbody"
  ; "td"
  ; "textarea"
  ; "tfoot"
  ; "th"
  ; "thead"
  ; "time"
  ; "title"
  ; "tr"
  ; "track"
  ; "u"
  ; "ul"
  ; "var"
  ; "video"
  ; "wbr" ]
  @ (* svg *)
  [ "circle"
  ; "clipPath"
  ; "defs"
  ; "ellipse"
  ; "g"
  ; "line"
  ; "linearGradient"
  ; "mask"
  ; "path"
  ; "pattern"
  ; "polygon"
  ; "polyline"
  ; "radialGradient"
  ; "rect"
  ; "stop"
  ; "svg"
  ; "text"
  ; "tspan" ]

let constantString ~loc str = Ast_helper.Exp.constant ~loc (Const.string str)

let safeTypeFromValue label =
  let str = Str_label.str label in
  match String.sub str 0 1 with "_" -> "T" ^ str | _ -> str

let keyType loc =
  Typ.constr ~loc {loc; txt= optionIdent}
    [Typ.constr ~loc {loc; txt= Lident "string"} []]

let refType loc = [%type: React.Dom.domRef]

type componentConfig = {propsName: string}

let extractChildren ?(removeLastPositionUnit = false) ~loc propsAndChildren =
  let rec allButLast_ lst acc =
    match lst with
    | [] ->
        []
    | [(Nolabel, {pexp_desc= Pexp_construct ({txt= Lident "()"}, None)})] ->
        acc
    | (Nolabel, _) :: _rest ->
        raise
          (Invalid_argument
             "JSX: found non-labelled argument before the last position" )
    | arg :: rest ->
        allButLast_ rest (arg :: acc)
  in
  let allButLast lst = allButLast_ lst [] |> List.rev in
  match
    List.partition
      (fun (label, _) -> label = labelled "children")
      propsAndChildren
  with
  | [], props ->
      (* no children provided? Place a placeholder list *)
      ( Exp.construct ~loc {loc; txt= Lident "[]"} None
      , if removeLastPositionUnit then allButLast props else props )
  | [(_, childrenExpr)], props ->
      (childrenExpr, if removeLastPositionUnit then allButLast props else props)
  | _ ->
      raise
        (Invalid_argument "JSX: somehow there's more than one `children` label")

let unerasableIgnore loc =
  { attr_name= {txt= "warning"; loc}
  ; attr_payload= PStr [Str.eval (Exp.constant (Const.string "-16"))]
  ; attr_loc= loc }

let merlinFocus =
  { attr_name= {txt= "merlin.focus"; loc= Location.none}
  ; attr_payload= PStr []
  ; attr_loc= Location.none }

(* Helper method to look up the [@react.component] attribute *)
let hasAttr {attr_name; _} = attr_name.txt = "react.component"

(* Helper method to filter out any attribute that isn't [@react.component] *)
let otherAttrsPure {attr_name; _} = attr_name.txt <> "react.component"

(* Iterate over the attributes and try to find the [@react.component] attribute *)
let hasAttrOnBinding {pvb_attributes} = find_opt hasAttr pvb_attributes <> None

let not_jsx {attr_name; _} = attr_name.txt <> "JSX"

(* Filter the [@JSX] attribute and immutably replace them on the expression *)
let filter_attr_create_element expression =
  { expression with
    pexp_attributes= List.filter not_jsx expression.pexp_attributes }

let used_attributes_tbl = Hashtbl.create 16

let register_loc attr =
  Ppxlib.Attribute.mark_as_handled_manually attr ;
  Hashtbl.replace used_attributes_tbl attr.attr_name.loc ()

let filter_attr_name key attr =
  if attr.attr_name.txt = key then (register_loc attr ; true) else false

(* Finds the name of the variable the binding is assigned to, otherwise raises Invalid_argument *)
let getFnName binding =
  match binding with
  | {pvb_pat= {ppat_desc= Ppat_var {txt}}} ->
      txt
  | _ ->
      raise (Invalid_argument "react.component calls cannot be destructured.")

let makeNewBinding binding expression newName =
  match binding with
  | {pvb_pat= {ppat_desc= Ppat_var ppat_var} as pvb_pat} ->
      { binding with
        pvb_pat= {pvb_pat with ppat_desc= Ppat_var {ppat_var with txt= newName}}
      ; pvb_expr= expression
      ; pvb_attributes= [merlinFocus] }
  | _ ->
      raise (Invalid_argument "react.component calls cannot be destructured.")

(* Lookup the value of `props` otherwise raise Invalid_argument error *)
let getPropsNameValue _acc (loc, exp) =
  match (loc, exp) with
  | {txt= Lident "props"}, {pexp_desc= Pexp_ident {txt= Lident str}} ->
      {propsName= str}
  | {txt}, _ ->
      raise
        (Invalid_argument
           ( "react.component only accepts props as an option, given: "
           ^ Longident.last_exn txt ) )

(* Lookup the `props` record or string as part of [@react.component] and store the name for use when rewriting *)
let getPropsAttr payload =
  let defaultProps = {propsName= "Props"} in
  match payload with
  | Some
      (PStr
        ({ pstr_desc=
             Pstr_eval ({pexp_desc= Pexp_record (recordFields, None)}, _) }
        :: _rest ) ) ->
      List.fold_left getPropsNameValue defaultProps recordFields
  | Some
      (PStr
        ({ pstr_desc=
             Pstr_eval ({pexp_desc= Pexp_ident {txt= Lident "props"}}, _) }
        :: _rest ) ) ->
      {propsName= "props"}
  | Some (PStr ({pstr_desc= Pstr_eval (_, _)} :: _rest)) ->
      raise
        (Invalid_argument
           "react.component accepts a record config with props as an options."
        )
  | _ ->
      defaultProps

(* Plucks the label, loc, and type_ from an AST node *)
let pluckLabelDefaultLocType (label, default, _, _, loc, type_) =
  (label, default, loc, type_)

(* Lookup the filename from the location information on the AST node and turn it into a valid module identifier *)
let filenameFromLoc (pstr_loc : Location.t) =
  let fileName =
    match pstr_loc.loc_start.pos_fname with
    | "" ->
        !Ocaml_location.input_name
    | fileName ->
        fileName
  in
  let fileName =
    try Filename.chop_extension (Filename.basename fileName)
    with Invalid_argument _ -> fileName
  in
  let fileName = String.capitalize_ascii fileName in
  fileName

(* Build a string representation of a module name with segments separated by $ *)
let makeModuleName fileName nestedModules fnName =
  let fullModuleName =
    match (fileName, nestedModules, fnName) with
    (* TODO: is this even reachable? It seems like the fileName always exists *)
    | "", nestedModules, "make" ->
        nestedModules
    | "", nestedModules, fnName ->
        List.rev (fnName :: nestedModules)
    | fileName, nestedModules, "make" ->
        fileName :: List.rev nestedModules
    | fileName, nestedModules, fnName ->
        fileName :: List.rev (fnName :: nestedModules)
  in
  let fullModuleName = String.concat "$" fullModuleName in
  fullModuleName

(*
  AST node builders
  These functions help us build AST nodes that are needed when transforming a [@react.component] into a
  constructor and a `makeProps` function
*)

(* Build an AST node representing all named args for the `makeProps` definition for a component's props *)
let rec makeArgsForMakePropsType list args =
  let open Str_label in
  match list with
  | (label, default, loc, interiorType) :: tl ->
      let coreType =
        match (label, interiorType, default) with
        (* ~foo=1 *)
        | label, None, Some _ ->
            Typ.mk ~loc (Ptyp_var (safeTypeFromValue label))
        (* ~foo: int=1 *)
        | _label, Some type_, Some _ ->
            type_
        (* ~foo: option(int)=? *)
        | ( _label
          , Some {ptyp_desc= Ptyp_constr ({txt= Lident "option"; _}, [type_]); _}
          , _ )
        | ( _label
          , Some
              { ptyp_desc=
                  Ptyp_constr
                    ({txt= Ldot (Lident "*predef*", "option"); _}, [type_])
              ; _ }
          , _ )
        (* ~foo: int=? - note this isnt valid. but we want to get a type error *)
        | (Optional _ as _label), Some type_, _ ->
            type_
        (* ~foo=? *)
        | (Optional _ as label), None, _ ->
            Typ.mk ~loc (Ptyp_var (safeTypeFromValue label))
        (* ~foo *)
        | label, None, _ ->
            Typ.mk ~loc (Ptyp_var (safeTypeFromValue label))
        | _label, Some type_, _ ->
            type_
      in
      makeArgsForMakePropsType tl
        (Typ.arrow ~loc (to_arg_label label) coreType args)
  | [] ->
      args

let makeMakePropsFnName fnName = fnName ^ "Props"

(* Build an AST node for the props name when converted to a Js.t inside the function signature  *)
let makePropsName ~loc name = Pat.mk ~loc (Ppat_var {txt= name; loc})

let makeObjectField loc (label, _attrs, propType) =
  let type_ = [%type: [%t propType] Js_of_ocaml.Js.readonly_prop] in
  { pof_desc=
      Otag ({loc; txt= Str_label.str label}, {type_ with ptyp_attributes= []})
  ; pof_loc= loc
  ; pof_attributes= [] }

(* Build an AST node representing a "closed" Js_of_ocaml.Js.t object representing a component's props *)
let makePropsType ~loc namedTypeList =
  Typ.mk ~loc
    (Ptyp_constr
       ( {txt= Ldot (Ldot (Lident "Js_of_ocaml", "Js"), "t"); loc}
       , [ Typ.mk ~loc
             (Ptyp_object (List.map (makeObjectField loc) namedTypeList, Closed))
         ] ) )

let rec makeFunsForMakePropsBody list args =
  match list with
  | (label, _default, loc, _interiorType) :: tl ->
      makeFunsForMakePropsBody tl
        (Exp.fun_ ~loc
           (Str_label.to_arg_label label)
           None
           { ppat_desc= Ppat_var {txt= Str_label.str label; loc}
           ; ppat_loc= loc
           ; ppat_attributes= []
           ; ppat_loc_stack= [] }
           args )
  | [] ->
      args

let makeAttributeValue ~loc (type_ : Html.attributeType) value =
  match type_ with
  | String ->
      [%expr Js_of_ocaml.Js.string ([%e value] : string)]
  | Int ->
      [%expr ([%e value] : int)]
  | Float ->
      [%expr ([%e value] : float)]
  | Bool ->
      [%expr ([%e value] : bool)]
  | Style ->
      [%expr ([%e value] : React.Dom.Style.t)]
  | Ref ->
      [%expr ([%e value] : React.Dom.domRef)]
  | InnerHtml ->
      [%expr ([%e value] : React.Dom.DangerouslySetInnerHTML.t)]

let makeEventValue ~loc (type_ : Html.eventType) value =
  match type_ with
  | Clipboard ->
      [%expr ([%e value] : React.Event.Clipboard.t -> unit)]
  | Composition ->
      [%expr ([%e value] : React.Event.Composition.t -> unit)]
  | Keyboard ->
      [%expr ([%e value] : React.Event.Keyboard.t -> unit)]
  | Focus ->
      [%expr ([%e value] : React.Event.Focus.t -> unit)]
  | Form ->
      [%expr ([%e value] : React.Event.Form.t -> unit)]
  | Mouse ->
      [%expr ([%e value] : React.Event.Mouse.t -> unit)]
  | Selection ->
      [%expr ([%e value] : React.Event.Selection.t -> unit)]
  | Touch ->
      [%expr ([%e value] : React.Event.Touch.t -> unit)]
  | UI ->
      [%expr ([%e value] : React.Event.UI.t -> unit)]
  | Wheel ->
      [%expr ([%e value] : React.Event.Wheel.t -> unit)]
  | Media ->
      [%expr ([%e value] : React.Event.Media.t -> unit)]
  | Image ->
      [%expr ([%e value] : React.Event.Image.t -> unit)]
  | Animation ->
      [%expr ([%e value] : React.Event.Animation.t -> unit)]
  | Transition ->
      [%expr ([%e value] : React.Event.Transition.t -> unit)]

let makeValue ~loc prop value =
  match prop with
  | Html.Attribute attribute ->
      makeAttributeValue ~loc attribute.type_ value
  | Html.Event event ->
      makeEventValue ~loc event.type_ value

let makeJsObj ~loc namedArgListWithKeyAndRef =
  let open Str_label in
  let labelToTuple label =
    let l = str label in
    let id = Exp.ident ~loc {txt= Lident l; loc} in
    let make_tuple raw =
      match l = "key" with
      | true ->
          [%expr
            [%e Exp.constant ~loc (Const.string l)]
            , inject (Js_of_ocaml.Js.string [%e raw])]
      | false ->
          [%expr [%e Exp.constant ~loc (Const.string l)], inject [%e raw]]
    in
    match label with
    | Optional _ ->
        [%expr Option.map (fun raw -> [%e make_tuple [%expr raw]]) [%e id]]
    | Labelled _ ->
        [%expr Some [%e make_tuple id]]
  in
  [%expr
    obj
      ( [%e
          Exp.array ~loc
            (List.map
               (fun (label, _, _, _) -> labelToTuple label)
               namedArgListWithKeyAndRef )]
      |> Array.to_list
      |> List.filter_map (fun x -> x)
      |> Array.of_list )]

let makePropsValueBinding fnName loc namedArgListWithKeyAndRef propsType =
  let core_type =
    makeArgsForMakePropsType namedArgListWithKeyAndRef
      [%type: unit -> [%t propsType]]
  in
  Vb.mk ~loc
    (Pat.mk ~loc
       (Ppat_constraint
          ( makePropsName ~loc (makeMakePropsFnName fnName)
          , { ptyp_desc= Ptyp_poly ([], core_type)
            ; ptyp_loc= loc
            ; ptyp_attributes= []
            ; ptyp_loc_stack= [] } ) ) )
    (Exp.mk ~loc
       (Pexp_constraint
          ( makeFunsForMakePropsBody namedArgListWithKeyAndRef
              [%expr
                fun () ->
                  let open Js_of_ocaml.Js.Unsafe in
                  [%e makeJsObj ~loc namedArgListWithKeyAndRef]]
          , core_type ) ) )

(* Returns a structure item for the `makeProps` function *)
let makePropsItem fnName loc namedArgListWithKeyAndRef propsType =
  Str.mk ~loc
    (Pstr_value
       ( Nonrecursive
       , [makePropsValueBinding fnName loc namedArgListWithKeyAndRef propsType]
       ) )

(* Builds an AST node for the entire `makeProps` function *)
let makePropsDecl fnName loc namedArgListWithKeyAndRef namedTypeList =
  makePropsItem fnName loc
    (List.map pluckLabelDefaultLocType namedArgListWithKeyAndRef)
    (makePropsType ~loc namedTypeList)

(* Builds the args list for elements like <Foo bar=2 />, or for React.Fragment: <> <div /> <p /> </> *)
let uppercase_element_args ~loc callArguments =
  let children, argsWithLabels =
    extractChildren ~loc ~removeLastPositionUnit:true callArguments
  in
  let argsForMake = argsWithLabels in
  let recursivelyTransformedArgsForMake =
    argsForMake |> List.map (fun (label, expression) -> (label, expression))
  in
  let filtered_children =
    match children with
    | [%expr []] ->
        []
    | children ->
        [(labelled "children", children)]
  in
  ( children
  , recursivelyTransformedArgsForMake @ filtered_children
    @ [(nolabel, Exp.construct ~loc {loc; txt= Lident "()"} None)] )

(* TODO: some line number might still be wrong *)
let jsxMapper () =
  let transformLowercaseCall loc attrs callArguments id =
    let children, nonChildrenProps = extractChildren ~loc callArguments in
    let componentNameExpr = constantString ~loc id in
    let args =
      match nonChildrenProps with
      | [_justTheUnitArgumentAtTheEnd] ->
          [ (* "div" *)
            (nolabel, componentNameExpr)
          ; (* React.Dom.props(~className=blabla, ~foo=bar, ()) *)
            (labelled "props", [%expr Js_of_ocaml.Js.Unsafe.obj [||]])
          ; (* [|moreCreateElementCallsHere|] *)
            (nolabel, children) ]
      | nonEmptyProps ->
          (* Filtering out the props that don't have a label, not sure how's possible *)
          let propsWithName =
            List.filter (fun (name, _) -> getLabel name != "") nonEmptyProps
          in
          let makePropField (arg_label, value) =
            let name = getLabel arg_label in
            let prop = Html.findByName name in
            [%expr
              [%e
                Exp.constant ~loc
                  (Pconst_string (Html.getHtmlName prop, loc, None))]
              (* loc here points to the element <div />, we could be more precise and point to the prop *)
              , Js_of_ocaml.Js.Unsafe.inject [%e makeValue ~loc prop value]]
          in
          let propsObj =
            [%expr
              ( Js_of_ocaml.Js.Unsafe.obj
                  [%e Exp.array ~loc (List.map makePropField propsWithName)]
                : React.Dom.domProps )]
          in
          [ (* "div" *)
            (nolabel, componentNameExpr)
          ; (* props: Js_of_ocaml.Js.Unsafe.obj ... *)
            (labelled "props", propsObj)
          ; (* [|moreCreateElementCallsHere|] *)
            (nolabel, children) ]
    in
    Exp.apply
      ~loc (* throw away the [@JSX] attribute and keep the others, if any *)
      ~attrs
      (* React.Dom.createDOMElementVariadic *)
      (Exp.ident ~loc
         { loc
         ; txt= Ldot (Ldot (Lident "React", "Dom"), "createDOMElementVariadic")
         } )
      args
  in
  let rec recursivelyTransformNamedArgsForMake mapper ctxt expr list =
    let expr = mapper#expression ctxt expr in
    match expr.pexp_desc with
    (* TODO: make this show up with a loc. *)
    | Pexp_fun (Labelled "key", _, _, _) | Pexp_fun (Optional "key", _, _, _) ->
        raise
          (Invalid_argument
             "Key cannot be accessed inside of a component. Don't worry - you \
              can always key a component from its parent!" )
    | Pexp_fun (Labelled "ref", _, _, _) | Pexp_fun (Optional "ref", _, _, _) ->
        raise
          (Invalid_argument
             "Ref cannot be passed as a normal prop. Please use `forwardRef` \
              API instead." )
    | Pexp_fun
        ( ((Labelled label | Optional label) as arg)
        , default
        , pattern
        , expression ) ->
        let () =
          match (arg, pattern, default) with
          | Optional _, {ppat_desc= Ppat_constraint (_, {ptyp_desc})}, None -> (
            match ptyp_desc with
            | Ptyp_constr ({txt= Lident "option"}, [_]) ->
                ()
            | _ ->
                let currentType =
                  match ptyp_desc with
                  | Ptyp_constr ({txt}, []) ->
                      String.concat "." (Longident.flatten_exn txt)
                  | Ptyp_constr ({txt}, _innerTypeArgs) ->
                      String.concat "." (Longident.flatten_exn txt) ^ "(...)"
                  | _ ->
                      "..."
                in
                Location.raise_errorf ~loc:pattern.ppat_loc
                  "jsoo-react: optional argument annotations must have \
                   explicit `option`. Did you mean `option(%s)=?`?"
                  currentType )
          | _ ->
              ()
        in
        let alias =
          match pattern with
          | {ppat_desc= Ppat_alias (_, {txt}) | Ppat_var {txt}} ->
              txt
          | {ppat_desc= Ppat_any} ->
              "_"
          | _ ->
              label
        in
        let type_ =
          match pattern with
          | {ppat_desc= Ppat_constraint (_, type_)} ->
              Some type_
          | _ ->
              None
        in
        recursivelyTransformNamedArgsForMake mapper ctxt expression
          ( ( Str_label.of_arg_label arg
            , default
            , pattern
            , alias
            , pattern.ppat_loc
            , type_ )
          :: list )
    | Pexp_fun
        ( Nolabel
        , _
        , {ppat_desc= Ppat_construct ({txt= Lident "()"}, _) | Ppat_any}
        , _expression ) ->
        (list, None)
    | Pexp_fun
        ( Nolabel
        , _
        , { ppat_desc=
              Ppat_var {txt} | Ppat_constraint ({ppat_desc= Ppat_var {txt}}, _)
          }
        , _expression ) ->
        (list, Some txt)
    | Pexp_fun (Nolabel, _, pattern, _expression) ->
        Location.raise_errorf ~loc:pattern.ppat_loc
          "jsoo-react: react.component refs only support plain arguments and \
           type annotations."
    | _ ->
        (list, None)
  in
  let argToType types (name, default, _noLabelName, _alias, loc, type_) =
    let open Str_label in
    match (type_, name, default) with
    | ( Some {ptyp_desc= Ptyp_constr ({txt= Lident "option"}, [type_])}
      , (Optional _ as name)
      , _ ) ->
        ( name
        , []
        , { type_ with
            ptyp_desc=
              Ptyp_constr ({loc= type_.ptyp_loc; txt= optionIdent}, [type_]) }
        )
        :: types
    | Some type_, name, Some _default ->
        ( name
        , []
        , { ptyp_desc= Ptyp_constr ({loc; txt= optionIdent}, [type_])
          ; ptyp_loc= loc
          ; ptyp_attributes= []
          ; ptyp_loc_stack= [] } )
        :: types
    | Some type_, name, _ ->
        (name, [], type_) :: types
    | None, (Optional _ as name), _ ->
        ( name
        , []
        , { ptyp_desc=
              Ptyp_constr
                ( {loc; txt= optionIdent}
                , [ { ptyp_desc= Ptyp_var (safeTypeFromValue name)
                    ; ptyp_loc= loc
                    ; ptyp_attributes= []
                    ; ptyp_loc_stack= [] } ] )
          ; ptyp_loc= loc
          ; ptyp_attributes= []
          ; ptyp_loc_stack= [] } )
        :: types
    | None, (Labelled _ as name), _ ->
        ( name
        , []
        , { ptyp_desc= Ptyp_var (safeTypeFromValue name)
          ; ptyp_loc= loc
          ; ptyp_attributes= []
          ; ptyp_loc_stack= [] } )
        :: types
  in
  let argToConcreteType types (name, loc, type_) =
    let open Str_label in
    match name with
    | Labelled _ as name ->
        (name, [], type_) :: types
    | Optional _ as name ->
        (name, [], Typ.constr ~loc {loc; txt= optionIdent} [type_]) :: types
  in
  let nestedModules = ref [] in
  let transformComponentDefinition mapper ctxt structure returnStructures =
    match structure with
    (* external *)
    | { pstr_loc
      ; pstr_desc=
          Pstr_primitive
            ( {pval_name= {txt= fnName}; pval_attributes; pval_type} as
            value_description ) } as pstr -> (
      match List.filter hasAttr pval_attributes with
      | [] ->
          structure :: returnStructures
      | [_] ->
          let rec getPropTypes types ({ptyp_loc; ptyp_desc} as fullType) =
            match ptyp_desc with
            | Ptyp_arrow
                ( ((Labelled _ | Optional _) as name)
                , type_
                , ({ptyp_desc= Ptyp_arrow _} as rest) ) ->
                getPropTypes
                  ((Str_label.of_arg_label name, ptyp_loc, type_) :: types)
                  rest
            | Ptyp_arrow (Nolabel, type_, _rest) ->
                Location.raise_errorf ~loc:type_.ptyp_loc
                  "jsoo-react: props need to be labelled arguments."
            | Ptyp_arrow
                (((Labelled _ | Optional _) as name), type_, returnValue) ->
                ( returnValue
                , (Str_label.of_arg_label name, returnValue.ptyp_loc, type_)
                  :: types )
            | _ ->
                (fullType, types)
          in
          let innerType, propTypes = getPropTypes [] pval_type in
          let namedTypeList = List.fold_left argToConcreteType [] propTypes in
          let pluckLabelAndLoc (label, loc, type_) =
            (label, None (* default *), loc, Some type_)
          in
          let retPropsType = makePropsType ~loc:pstr_loc namedTypeList in
          let externalPropsDecl =
            makePropsItem fnName pstr_loc
              ( (Optional "key", None, pstr_loc, Some (keyType pstr_loc))
              :: List.map pluckLabelAndLoc propTypes )
              retPropsType
          in
          (* can't be an arrow because it will defensively uncurry *)
          let newExternalType =
            Ptyp_constr
              ( {loc= pstr_loc; txt= Ldot (Lident "React", "componentLike")}
              , [retPropsType; innerType] )
          in
          let newStructure =
            { pstr with
              pstr_desc=
                Pstr_primitive
                  { value_description with
                    pval_type= {pval_type with ptyp_desc= newExternalType}
                  ; pval_attributes= List.filter otherAttrsPure pval_attributes
                  } }
          in
          externalPropsDecl :: newStructure :: returnStructures
      | _ ->
          raise
            (Invalid_argument
               "Only one react.component call can exist on a component at one \
                time" ) )
    (* let component = ... *)
    | {pstr_loc; pstr_desc= Pstr_value (recFlag, valueBindings)} ->
        let fileName = filenameFromLoc pstr_loc in
        let emptyLoc = Location.in_file fileName in
        let mapBinding binding =
          if hasAttrOnBinding binding then
            let bindingLoc = binding.pvb_loc in
            let bindingPatLoc = binding.pvb_pat.ppat_loc in
            let binding =
              { binding with
                pvb_pat= {binding.pvb_pat with ppat_loc= emptyLoc}
              ; pvb_loc= emptyLoc }
            in
            let fnName = getFnName binding in
            let internalFnName = fnName ^ "$Internal" in
            let fullModuleName =
              makeModuleName fileName !nestedModules fnName
            in
            let modifiedBindingOld binding =
              let expression = binding.pvb_expr in
              (* TODO: there is a long-tail of unsupported features inside of blocks - Pexp_letmodule , Pexp_letexception , Pexp_ifthenelse *)
              let rec spelunkForFunExpression expression =
                match expression with
                (* let make = (~prop) => ... *)
                | {pexp_desc= Pexp_fun _} ->
                    expression
                (* let make = {let foo = bar in (~prop) => ...} *)
                | {pexp_desc= Pexp_let (_recursive, _vbs, returnExpression)} ->
                    (* here's where we spelunk! *)
                    spelunkForFunExpression returnExpression
                (* let make = React.forwardRef((~prop) => ...) or
                   let make = React.memoCustomCompareProps((~prop) => ..., compareProps()) *)
                | { pexp_desc=
                      Pexp_apply
                        ( _wrapperExpression
                        , ( [(Nolabel, innerFunctionExpression)]
                          | [ (Nolabel, innerFunctionExpression)
                            ; (Nolabel, {pexp_desc= Pexp_fun _}) ] ) ) } ->
                    spelunkForFunExpression innerFunctionExpression
                | { pexp_desc=
                      Pexp_sequence (_wrapperExpression, innerFunctionExpression)
                  } ->
                    spelunkForFunExpression innerFunctionExpression
                | _ ->
                    raise
                      (Invalid_argument
                         "react.component calls can only be on function \
                          definitions or component wrappers (forwardRef, \
                          memo)." )
              in
              spelunkForFunExpression expression
            in
            let namedArgList, forwardRef =
              recursivelyTransformNamedArgsForMake mapper ctxt
                (modifiedBindingOld binding)
                []
            in
            let namedArgListWithKeyAndRef =
              ( Str_label.Optional "key"
              , None
              , Pat.var {txt= "key"; loc= emptyLoc}
              , "key"
              , emptyLoc
              , Some (keyType emptyLoc) )
              :: namedArgList
            in
            let namedArgListWithKeyAndRef =
              match forwardRef with
              | Some _ ->
                  ( Str_label.Optional "ref"
                  , None
                  , Pat.var {txt= "ref"; loc= emptyLoc}
                  , "ref"
                  , emptyLoc
                  , Some (refType emptyLoc) )
                  :: namedArgListWithKeyAndRef
              | None ->
                  namedArgListWithKeyAndRef
            in
            let outerMake expression =
              Vb.mk ~loc:bindingLoc
                ~attrs:(List.filter otherAttrsPure binding.pvb_attributes)
                (Pat.var ~loc:bindingPatLoc {loc= bindingPatLoc; txt= fnName})
                (makeFunsForMakePropsBody
                   (List.map pluckLabelDefaultLocType namedArgListWithKeyAndRef)
                   (let loc = emptyLoc in
                    [%expr
                      fun () ->
                        React.createElement [%e expression]
                          [%e
                            Exp.apply ~loc
                              (Exp.ident ~loc
                                 {loc; txt= Lident (makeMakePropsFnName fnName)} )
                              ( List.map
                                  (fun ( arg
                                       , _default
                                       , _pattern
                                       , _alias
                                       , _pattern_loc
                                       , _type ) ->
                                    ( Str_label.to_arg_label arg
                                    , Exp.ident ~loc:emptyLoc
                                        { loc= emptyLoc
                                        ; txt= Lident (Str_label.str arg) } ) )
                                  namedArgListWithKeyAndRef
                              @ [ ( Nolabel
                                  , Exp.construct {loc; txt= Lident "()"} None
                                  ) ] )]] ) )
            in
            let modifiedBinding binding =
              let hasApplication = ref false in
              let expression = binding.pvb_expr in
              let unerasableIgnoreExp exp =
                { exp with
                  pexp_attributes=
                    unerasableIgnore emptyLoc :: exp.pexp_attributes }
              in
              (* TODO: there is a long-tail of unsupported features inside of blocks - Pexp_letmodule , Pexp_letexception , Pexp_ifthenelse *)
              let rec spelunkForFunExpression expression =
                match expression with
                (* let make = (~prop) => ... with no final unit *)
                | { pexp_desc=
                      Pexp_fun
                        ( ((Labelled _ | Optional _) as label)
                        , default
                        , pattern
                        , ({pexp_desc= Pexp_fun _} as internalExpression) ) } ->
                    let wrap, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( wrap
                    , hasUnit
                    , unerasableIgnoreExp
                        { expression with
                          pexp_desc= Pexp_fun (label, default, pattern, exp) }
                    )
                (* let make = (()) => ... *)
                (* let make = (_) => ... *)
                | { pexp_desc=
                      Pexp_fun
                        ( Nolabel
                        , _default
                        , { ppat_desc=
                              Ppat_construct ({txt= Lident "()"}, _) | Ppat_any
                          }
                        , _internalExpression ) } ->
                    ((fun a -> a), true, expression)
                (* let make = (~prop) => ... *)
                | { pexp_desc=
                      Pexp_fun
                        ( (Labelled _ | Optional _)
                        , _default
                        , _pattern
                        , _internalExpression ) } ->
                    ((fun a -> a), false, unerasableIgnoreExp expression)
                (* let make = (prop) => ... *)
                | { pexp_desc=
                      Pexp_fun (_nolabel, _default, pattern, _internalExpression)
                  } ->
                    if hasApplication.contents then
                      ((fun a -> a), false, unerasableIgnoreExp expression)
                    else
                      Location.raise_errorf ~loc:pattern.ppat_loc
                        "jsoo-react: props need to be labelled arguments.\n\
                        \  If you are working with refs be sure to wrap with \
                         React.forwardRef.\n\
                        \  If your component doesn't have any props use () or \
                         _ instead of a name."
                (* let make = {let foo = bar in (~prop) => ...} *)
                | {pexp_desc= Pexp_let (recursive, vbs, internalExpression)} ->
                    (* here's where we spelunk! *)
                    let wrap, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( wrap
                    , hasUnit
                    , {expression with pexp_desc= Pexp_let (recursive, vbs, exp)}
                    )
                (* let make = React.forwardRef((~prop) => ...) *)
                | { pexp_desc=
                      Pexp_apply
                        (wrapperExpression, [(Nolabel, internalExpression)]) }
                  ->
                    let () = hasApplication := true in
                    let _, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( (fun exp -> Exp.apply wrapperExpression [(nolabel, exp)])
                    , hasUnit
                    , exp )
                (* let make = React.memoCustomCompareProps((~prop) => ..., (prevPros, nextProps) => true) *)
                | { pexp_desc=
                      Pexp_apply
                        ( wrapperExpression
                        , [ (Nolabel, internalExpression)
                          ; ((Nolabel, {pexp_desc= Pexp_fun _}) as compareProps)
                          ] ) } ->
                    let () = hasApplication := true in
                    let _, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( (fun exp ->
                        Exp.apply wrapperExpression
                          [(nolabel, exp); compareProps] )
                    , hasUnit
                    , exp )
                | { pexp_desc=
                      Pexp_sequence (wrapperExpression, internalExpression) } ->
                    let wrap, hasUnit, exp =
                      spelunkForFunExpression internalExpression
                    in
                    ( wrap
                    , hasUnit
                    , { expression with
                        pexp_desc= Pexp_sequence (wrapperExpression, exp) } )
                | e ->
                    ((fun a -> a), false, e)
              in
              let wrapExpression, hasUnit, expression =
                spelunkForFunExpression expression
              in
              (wrapExpression, hasUnit, expression)
            in
            let wrapExpression, hasUnit, expression = modifiedBinding binding in
            let reactComponentAttribute =
              try Some (List.find hasAttr binding.pvb_attributes)
              with Not_found -> None
            in
            let _attr_loc, payload =
              match reactComponentAttribute with
              | Some {attr_loc; attr_payload} ->
                  (attr_loc, Some attr_payload)
              | None ->
                  (emptyLoc, None)
            in
            let props = getPropsAttr payload in
            let pluck_arg (label, _, _, _, loc, _) =
              let label_str = Str_label.str label in
              let props_name_id =
                Exp.ident ~loc {txt= Lident props.propsName; loc}
              in
              let label_const = Exp.constant ~loc (Const.string label_str) in
              let send =
                Exp.send ~loc
                  (Exp.ident ~loc {txt= Lident "x"; loc})
                  {txt= label_str; loc}
              in
              (* https://github.com/ocsigen/js_of_ocaml/blob/b1c807eaa40fa17b04c7d8e7e24306a03a46681d/ppx/ppx_js/lib_internal/ppx_js_internal.ml#L322-L332 *)
              let expr =
                [%expr
                  (fun (type res a0) (a0 : a0 Js_of_ocaml.Js.t)
                       (_ : a0 -> < get: res ; .. > Js_of_ocaml.Js.gen_prop) :
                       res ->
                    Js_of_ocaml.Js.Unsafe.get a0 [%e label_const] )
                    ([%e props_name_id] : < .. > Js_of_ocaml.Js.t)
                    (fun x -> [%e send])]
              in
              (Str_label.to_arg_label label, expr)
            in
            let namedTypeList = List.fold_left argToType [] namedArgList in
            let loc = emptyLoc in
            let makePropsLet =
              makePropsDecl fnName loc namedArgListWithKeyAndRef namedTypeList
            in
            let innerExpressionArgs =
              List.map pluck_arg namedArgList
              @ ( match forwardRef with
                | Some txt ->
                    [(Nolabel, Exp.ident ~loc {txt= Lident txt; loc= emptyLoc})]
                | None ->
                    [] )
              @
              if hasUnit then
                [(Nolabel, Exp.construct {loc; txt= Lident "()"} None)]
              else []
            in
            let innerExpression =
              Exp.apply
                (Exp.ident
                   { loc
                   ; txt=
                       Lident
                         ( match recFlag with
                         | Recursive ->
                             internalFnName
                         | Nonrecursive ->
                             fnName ) } )
                innerExpressionArgs
            in
            let innerExpressionWithRef =
              match forwardRef with
              | Some txt ->
                  { innerExpression with
                    pexp_desc=
                      Pexp_fun
                        ( nolabel
                        , None
                        , { ppat_desc= Ppat_var {txt; loc= emptyLoc}
                          ; ppat_loc= emptyLoc
                          ; ppat_attributes= []
                          ; ppat_loc_stack= [] }
                        , innerExpression ) }
              | None ->
                  innerExpression
            in
            let fullExpression =
              Exp.fun_ nolabel None
                { ppat_desc=
                    Ppat_constraint
                      ( makePropsName ~loc:emptyLoc props.propsName
                      , makePropsType ~loc:emptyLoc namedTypeList )
                ; ppat_loc= emptyLoc
                ; ppat_attributes= []
                ; ppat_loc_stack= [] }
                innerExpressionWithRef
            in
            let fullExpression =
              match fullModuleName with
              | "" ->
                  (* how can this happen? *)
                  wrapExpression fullExpression
              | _txt ->
                  wrapExpression fullExpression
            in
            let innerMakeIdent = Exp.ident ~loc {loc; txt= Lident fnName} in
            let bindings, newBinding =
              match recFlag with
              | Recursive ->
                  ( [ outerMake
                        (Exp.let_ ~loc:emptyLoc Recursive
                           [ makeNewBinding binding expression internalFnName
                           ; Vb.mk
                               (Pat.var {loc= emptyLoc; txt= fnName})
                               innerMakeIdent ]
                           (Exp.ident {loc= emptyLoc; txt= Lident fnName}) ) ]
                  , None )
              | Nonrecursive ->
                  ( [{binding with pvb_expr= expression; pvb_attributes= []}]
                  , Some (outerMake innerMakeIdent) )
            in
            ( Some makePropsLet
            , Some (Vb.mk (Pat.var {loc= emptyLoc; txt= fnName}) fullExpression)
            , bindings
            , newBinding )
          else (None, None, [binding], None)
        in
        let structuresAndBinding = List.map mapBinding valueBindings in
        let otherStructures (extern, innerMake, binding, newBinding)
            (externs, innerMakes, bindings, newBindings) =
          let externs =
            match extern with
            | Some extern ->
                extern :: externs
            | None ->
                externs
          in
          let innerMakes =
            match innerMake with
            | Some innerMake ->
                innerMake :: innerMakes
            | None ->
                innerMakes
          in
          let newBindings =
            match newBinding with
            | Some newBinding ->
                newBinding :: newBindings
            | None ->
                newBindings
          in
          (externs, innerMakes, binding @ bindings, newBindings)
        in
        let externs, innerMakes, bindings, newBindings =
          List.fold_right otherStructures structuresAndBinding ([], [], [], [])
        in
        externs
        @ [{pstr_loc; pstr_desc= Pstr_value (recFlag, bindings)}]
        @ ( match innerMakes with
          | [] ->
              []
          | innerMakes ->
              [{pstr_loc= emptyLoc; pstr_desc= Pstr_value (recFlag, innerMakes)}]
          )
        @ ( match newBindings with
          | [] ->
              []
          | newBindings ->
              [ { pstr_loc= emptyLoc
                ; pstr_desc= Pstr_value (recFlag, newBindings) } ] )
        @ returnStructures
    | structure ->
        structure :: returnStructures
  in
  let reactComponentTransform mapper ctxt structures =
    List.fold_right (transformComponentDefinition mapper ctxt) structures []
  in
  let transformJsxCall callExpression callArguments attrs pexp_loc
      pexp_loc_stack =
    match callExpression.pexp_desc with
    | Pexp_ident caller -> (
      match caller with
      | {txt= Lident "createElement"} ->
          raise
            (Invalid_argument
               "JSX: `createElement` should be preceeded by a module name." )
      (* Foo.createElement(~prop1=foo, ~prop2=bar, ~children=[], ()) *)
      | {loc; txt= Ldot (modulePath, "createElement")} ->
          let _children_expr, args =
            uppercase_element_args ~loc callArguments
          in
          { pexp_desc=
              Pexp_apply
                ( { callExpression with
                    pexp_desc= Pexp_ident {loc; txt= Ldot (modulePath, "make")}
                  }
                , args )
          ; pexp_attributes= attrs
          ; pexp_loc
          ; pexp_loc_stack }
      (* div(~prop1=foo, ~prop2=bar, ~children=[bla], ()) *)
      (* turn that into
         React.Dom.createElement(~props=React.Dom.props(~props1=foo, ~props2=bar, ()), [|bla|]) *)
      | {loc; txt= Lident id} ->
          transformLowercaseCall loc attrs callArguments id
      | {txt= Ldot (_, anythingNotCreateElementOrMake)} ->
          raise
            (Invalid_argument
               ( "JSX: the JSX attribute should be attached to a \
                  `YourModuleName.createElement` or `YourModuleName.make` \
                  call. We saw `" ^ anythingNotCreateElementOrMake ^ "` instead"
               ) )
      | {txt= Lapply _} ->
          (* don't think there's ever a case where this is reached *)
          raise
            (Invalid_argument
               "JSX: encountered a weird case while processing the code. \
                Please report this!" ) )
    | _ ->
        raise
          (Invalid_argument
             "JSX: `createElement` should be preceeded by a simple, direct \
              module name." )
  in
  object (self)
    inherit [Context.t] Ast_traverse.map_with_context as super

    method! structure c structure =
      match structure with
      | {pstr_desc= Pstr_attribute attribute; _} :: rest
        when filter_attr_name "react.dom" attribute ->
          super#structure {react_dom= true}
            (reactComponentTransform self c rest)
      | structures ->
          super#structure c (reactComponentTransform self c structures)

    method! expression c expression =
      let expression = super#expression c expression in
      match expression with
      | { pexp_desc= Pexp_apply (callExpression, callArguments)
        ; pexp_attributes
        ; pexp_loc
        ; pexp_loc_stack } -> (
        match c with
        | {react_dom= true} -> (
          match callExpression with
          | {pexp_desc= Pexp_ident {txt= Lident id; _}}
            when List.mem id dom_tags ->
              transformJsxCall callExpression callArguments pexp_attributes
                pexp_loc pexp_loc_stack
          | _ ->
              expression )
        | {react_dom= false} -> (
            (* Does the function application have the @JSX attribute? *)
            let jsxAttribute, nonJSXAttributes =
              List.partition
                (fun attribute -> attribute.attr_name.txt = "JSX")
                pexp_attributes
            in
            match (jsxAttribute, nonJSXAttributes) with
            (* no JSX attribute *)
            | [], _ ->
                expression
            | _, nonJSXAttributes ->
                transformJsxCall callExpression callArguments nonJSXAttributes
                  pexp_loc pexp_loc_stack ) )
      (* is it a list with jsx attribute? Reason <>foo</> desugars to [@JSX][foo]*)
      | { pexp_desc=
            ( Pexp_construct
                ({txt= Lident "::"; loc}, Some {pexp_desc= Pexp_tuple _})
            | Pexp_construct ({txt= Lident "[]"; loc}, None) )
        ; pexp_attributes
        ; pexp_loc
        ; pexp_loc_stack } as listItems -> (
          let jsxAttribute, nonJSXAttributes =
            List.partition
              (fun attribute -> attribute.attr_name.txt = "JSX")
              pexp_attributes
          in
          match (jsxAttribute, nonJSXAttributes) with
          (* no JSX attribute *)
          | [], _ ->
              expression
          | _, nonJSXAttributes ->
              let callExpression = [%expr React.Fragment.createElement] in
              transformJsxCall callExpression
                [(Labelled "children", {listItems with pexp_attributes= []})]
                nonJSXAttributes pexp_loc pexp_loc_stack )
      (* Delegate to the default mapper, a deep identity traversal *)
      | _e ->
          expression

    method! module_binding c module_binding =
      let _ =
        match module_binding.pmb_name.txt with
        | None ->
            ()
        | Some txt ->
            nestedModules := txt :: !nestedModules
      in
      let mapped = super#module_binding c module_binding in
      let _ = nestedModules := List.tl !nestedModules in
      mapped
  end

let rewrite_implementation (code : Parsetree.structure) : Parsetree.structure =
  let c = Context.init in
  let mapper = jsxMapper () in
  mapper#structure c code

let rewrite_signature (code : Parsetree.signature) : Parsetree.signature =
  let c = Context.init in
  let mapper = jsxMapper () in
  mapper#signature c code

let () =
  Driver.register_transformation "jsoo-react-ppx" ~impl:rewrite_implementation
    ~intf:rewrite_signature
