/*
   This is the file that handles turning Reason JSX' agnostic function call into
   a React-specific function call. Aka, this is a macro, using OCaml's ppx
   facilities; https://whitequark.org/blog/2014/04/16/a-guide-to-extension-points-in-ocaml/
 */

/*
   The transform:
   transform `[@JSX] div(~props1=a, ~props2=b, ~children=[foo, bar], ())` into
   `ReactDOM.createDOMElementVariadic("div", ReactDOM.domProps(~props1=1, ~props2=b), [|foo, bar|])`.
   transform the upper-cased case
   `[@JSX] Foo.createElement(~key=a, ~ref=b, ~foo=bar, ~children=[], ())` into
   `React.createElement(Foo.make, Foo.makeProps(~key=a, ~ref=b, ~foo=bar, ()))`
   transform the upper-cased case
   `[@JSX] Foo.createElement(~foo=bar, ~children=[foo, bar], ())` into
   `React.createElementVariadic(Foo.make, Foo.makeProps(~foo=bar, ~children=React.null, ()), [|foo, bar|])`
   transform `[@JSX] [foo]` into
   `ReactDOM.createFragment([|foo|])`
 */

open Ppxlib;
open Ast_helper;

let rec find_opt = p =>
  fun
  | [] => None
  | [x, ...l] =>
    if (p(x)) {
      Some(x);
    } else {
      find_opt(p, l);
    };

let isOptional = str =>
  switch (str) {
  | Optional(_) => true
  | _ => false
  };

let isLabelled = str =>
  switch (str) {
  | Labelled(_) => true
  | _ => false
  };

let getLabel = str =>
  switch (str) {
  | Optional(str)
  | Labelled(str) => str
  | Nolabel => ""
  };

let optionIdent = Lident("option");

let argIsKeyRef =
  fun
  | (Labelled("key" | "ref"), _)
  | (Optional("key" | "ref"), _) => true
  | _ => false;

let constantString = (~loc, str) =>
  Exp.constant(~loc, Pconst_string(str, None));

let safeTypeFromValue = valueStr => {
  let valueStr = getLabel(valueStr);
  switch (String.sub(valueStr, 0, 1)) {
  | "_" => "T" ++ valueStr
  | _ => valueStr
  };
};

/*
 let keyType = loc =>
   Typ.constr(
     ~loc,
     {loc, txt: optionIdent},
     [Typ.constr(~loc, {loc, txt: Lident("string")}, [])],
   );

 let refType = loc =>
   Typ.constr(~loc, {loc, txt: Ldot(Lident("ReactDOM"), "domRef")}, []);
 */

type children('a) =
  | ListLiteral('a)
  | Exact('a);

type componentConfig = {propsName: string};

/*
 let transformChildrenIfList = (~loc, ~mapper, theList) => {
   let rec transformChildren_ = (theList, accum) =>
     /* not in the sense of converting a list to an array; convert the AST
        reprensentation of a list to the AST reprensentation of an array */
     switch (theList) {
     | {pexp_desc: Pexp_construct({txt: Lident("[]")}, None)} =>
       List.rev(accum) |> Exp.array(~loc)
     | {
         pexp_desc:
           Pexp_construct(
             {txt: Lident("::")},
             Some({pexp_desc: Pexp_tuple([v, acc])}),
           ),
       } =>
       transformChildren_(acc, [mapper.expr(mapper, v), ...accum])
     | notAList => mapper.expr(mapper, notAList)
     };

   transformChildren_(theList, []);
 };*/

/*

 /* Helper method to look up the [@react.component] attribute */
 let hasAttr = ((loc, _)) => loc.txt == "react.component";

 /* Helper method to filter out any attribute that isn't [@react.component] */
 let otherAttrsPure = ((loc, _)) => loc.txt != "react.component";

 /* Iterate over the attributes and try to find the [@react.component] attribute */
 let hasAttrOnBinding = ({pvb_attributes}) =>
   find_opt(hasAttr, pvb_attributes) != None;

 /* Filter the [@react.component] attribute and immutably replace them on the binding */
 let filterAttrOnBinding = binding => {
   ...binding,
   pvb_attributes: List.filter(otherAttrsPure, binding.pvb_attributes),
 };

 /* Finds the name of the variable the binding is assigned to, otherwise raises Invalid_argument */
 let getFnName = binding =>
   switch (binding) {
   | {pvb_pat: {ppat_desc: Ppat_var({txt})}} => txt
   | _ =>
     raise(Invalid_argument("react.component calls cannot be destructured."))
   };

 /* Lookup the value of `props` otherwise raise Invalid_argument error */
 let getPropsNameValue = (_acc, (loc, exp)) =>
   switch (loc, exp) {
   | ({txt: Lident("props")}, {pexp_desc: Pexp_ident({txt: Lident(str)})}) => {
       propsName: str,
     }
   | ({txt}, _) =>
     raise(
       Invalid_argument(
         "react.component only accepts props as an option, given: "
         ++ Longident.last(txt),
       ),
     )
   };

 /* Lookup the `props` record or string as part of [@react.component] and store the name for use when rewriting */
 let getPropsAttr = payload => {
   let defaultProps = {propsName: "Props"};
   switch (payload) {
   | Some(
       PStr([
         {
           pstr_desc:
             Pstr_eval({pexp_desc: Pexp_record(recordFields, None)}, _),
         },
         ..._rest,
       ]),
     ) =>
     List.fold_left(getPropsNameValue, defaultProps, recordFields)
   | Some(
       PStr([
         {
           pstr_desc:
             Pstr_eval({pexp_desc: Pexp_ident({txt: Lident("props")})}, _),
         },
         ..._rest,
       ]),
     ) => {
       propsName: "props",
     }
   | Some(PStr([{pstr_desc: Pstr_eval(_, _)}, ..._rest])) =>
     raise(
       Invalid_argument(
         "react.component accepts a record config with props as an options.",
       ),
     )
   | _ => defaultProps
   };
 };

 /* Plucks the label, loc, and type_ from an AST node */
 let pluckLabelDefaultLocType = ((label, default, _, _, loc, type_)) => (
   label,
   default,
   loc,
   type_,
 );

 /* Lookup the filename from the location information on the AST node and turn it into a valid module identifier */
 let filenameFromLoc = (pstr_loc: Location.t) => {
   let fileName =
     switch (pstr_loc.loc_start.pos_fname) {
     | "" => Location.input_name^
     | fileName => fileName
     };

   let fileName =
     try (Filename.chop_extension(Filename.basename(fileName))) {
     | Invalid_argument(_) => fileName
     };

   let fileName = String.capitalize_ascii(fileName);
   fileName;
 };

 /* Build a string representation of a module name with segments separated by $ */
 let makeModuleName = (fileName, nestedModules, fnName) => {
   let fullModuleName =
     switch (fileName, nestedModules, fnName) {
     /* TODO: is this even reachable? It seems like the fileName always exists */
     | ("", nestedModules, "make") => nestedModules
     | ("", nestedModules, fnName) => List.rev([fnName, ...nestedModules])
     | (fileName, nestedModules, "make") => [
         fileName,
         ...List.rev(nestedModules),
       ]
     | (fileName, nestedModules, fnName) => [
         fileName,
         ...List.rev([fnName, ...nestedModules]),
       ]
     };

   let fullModuleName = String.concat("$", fullModuleName);
   fullModuleName;
 };

 /*
    AST node builders
    These functions help us build AST nodes that are needed when transforming a [@react.component] into a
    constructor and a props external
  */

 /* Build an AST node representing all named args for the `makeProps` type definition */
 let rec makeArgsForMakePropsType = (list, args) =>
   switch (list) {
   | [(label, default, loc, interiorType), ...tl] =>
     let coreType =
       switch (label, interiorType, default) {
       /* ~foo=1 */
       | (label, None, Some(_)) => {
           ptyp_desc: Ptyp_var(safeTypeFromValue(label)),
           ptyp_loc: loc,
           ptyp_attributes: [],
         }
       /* ~foo: int=1 */
       | (_label, Some(type_), Some(_)) => type_
       /* ~foo: option(int)=? */
       | (
           label,
           Some({
             ptyp_desc: Ptyp_constr({txt: Lident("option")}, [type_]),
           }),
           _,
         )
       | (
           label,
           Some({
             ptyp_desc:
               Ptyp_constr(
                 {txt: Ldot(Lident("*predef*"), "option")},
                 [type_],
               ),
           }),
           _,
         )
       /* ~foo: int=? - note this isnt valid. but we want to get a type error */
       | (label, Some(type_), _) when isOptional(label) => type_
       /* ~foo=? */
       | (label, None, _) when isOptional(label) => {
           ptyp_desc: Ptyp_var(safeTypeFromValue(label)),
           ptyp_loc: loc,
           ptyp_attributes: [],
         }
       /* ~foo */
       | (label, None, _) => {
           ptyp_desc: Ptyp_var(safeTypeFromValue(label)),
           ptyp_loc: loc,
           ptyp_attributes: [],
         }
       | (_label, Some(type_), _) => type_
       };
     makeArgsForMakePropsType(tl, Typ.arrow(~loc, label, coreType, args));
   | [] => args
   };

 /* Build an AST node for the makeProps function body */
 let rec makeFunsForMakePropsBody = (list, args) =>
   switch (list) {
   | [(label, _default, loc, _interiorType), ...tl] =>
     makeFunsForMakePropsBody(
       tl,
       Exp.fun_(
         ~loc,
         label,
         None,
         {
           ppat_desc: Ppat_var({txt: getLabel(label), loc}),
           ppat_loc: loc,
           ppat_attributes: [],
         },
         args,
       ),
     )
   | [] => args
   };

 /* Build an AST node for the makeProps value binding */
 let makePropsValue = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
   let propsName = fnName ++ "Props";
   {
     pval_name: {
       txt: propsName,
       loc,
     },
     pval_type:
       makeArgsForMakePropsType(
         namedArgListWithKeyAndRef,
         Typ.arrow(
           nolabel,
           {
             ptyp_desc: Ptyp_constr({txt: Lident("unit"), loc}, []),
             ptyp_loc: loc,
             ptyp_attributes: [],
           },
           propsType,
         ),
       ),
     pval_prim: [""],
     pval_attributes: [({txt: "bs.obj", loc}, PStr([]))],
     pval_loc: loc,
   };
 };

 /* Build an AST node for the props name when converted to a Js.t inside the function signature  */
 let makePropsName = (~loc, name) => {
   ppat_desc: Ppat_var({txt: name, loc}),
   ppat_loc: loc,
   ppat_attributes: [],
 };

 /* AST for the creation of a JavaScript object using Js_of_ocaml.Js.obj */
 let makeJsObj = (~loc, namedArgListWithKeyAndRef) => {
   /* Creates the ("key", inject(key)), ("name", inject(name)) tuples */
   let labelToTuple = label =>
     Exp.tuple(
       ~loc,
       [
         constantString(~loc, getLabel(label)),
         Exp.apply(
           ~loc,
           Exp.ident(~loc, {txt: Lident("inject"), loc}),
           [
             (
               Nolabel,
               Exp.ident(~loc, {txt: Lident(getLabel(label)), loc}),
             ),
           ],
         ),
       ],
     );
   Exp.apply(
     ~loc,
     Exp.ident(~loc, {txt: Lident("obj"), loc}),
     [
       (
         Nolabel,
         Exp.array(
           ~loc,
           List.map(
             ((label, _, _, _)) => labelToTuple(label),
             namedArgListWithKeyAndRef,
           ),
         ),
       ),
     ],
   );
 };

 /* Build an AST node for the makeProps value binding */
 let makePropsValueBinding =
     (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
   let core_type =
     makeArgsForMakePropsType(
       namedArgListWithKeyAndRef,
       Typ.arrow(
         nolabel,
         {
           ptyp_desc: Ptyp_constr({txt: Lident("unit"), loc}, []),
           ptyp_loc: loc,
           ptyp_attributes: [],
         },
         propsType,
       ),
     );

   let propsName = fnName ++ "Props";
   {
     pvb_pat: {
       ppat_desc:
         Ppat_constraint(
           makePropsName(~loc, propsName),
           {
             /* Not sure why, but in the type definition of the props Ptyp_poly is needed */
             ptyp_desc: Ptyp_poly([], core_type),
             ptyp_loc: loc,
             ptyp_attributes: [],
           },
         ),
       ppat_loc: loc,
       ppat_attributes: [],
     },
     pvb_expr: {
       pexp_desc:
         Pexp_constraint(
           makeFunsForMakePropsBody(
             namedArgListWithKeyAndRef,
             Exp.fun_(
               Nolabel,
               None,
               {ppat_desc: Ppat_any, ppat_loc: loc, ppat_attributes: []},
               Exp.open_(
                 ~loc,
                 Fresh,
                 {
                   txt: Ldot(Ldot(Lident("Js_of_ocaml"), "Js"), "Unsafe"),
                   loc,
                 },
                 makeJsObj(~loc, namedArgListWithKeyAndRef),
               ),
             ),
           ),
           core_type,
         ),
       pexp_loc: loc,
       pexp_attributes: [],
     },
     pvb_loc: loc,
     pvb_attributes: [],
   };
 };

 /* Build an AST node representing the `let makeProps` structure item */
 let makePropsItem = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
   pstr_loc: loc,
   pstr_desc:
     Pstr_value(
       Nonrecursive,
       [
         makePropsValueBinding(
           fnName,
           loc,
           namedArgListWithKeyAndRef,
           propsType,
         ),
       ],
     ),
 };

 /* Build an AST node for the signature of the `external` definition */
 let makePropsExternalSig = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
   psig_loc: loc,
   psig_desc:
     Psig_value(
       makePropsValue(fnName, loc, namedArgListWithKeyAndRef, propsType),
     ),
 };

 let makeObjectField = (loc, (str, _attrs, propType)) => {
   let type_ =
     Typ.constr(
       ~loc,
       {txt: Ldot(Ldot(Lident("Js_of_ocaml"), "Js"), "readonly_prop"), loc},
       [propType],
     );
   /* intentionally not using attrs - they probably don't work on object fields. use on *Props instead */
   Otag({loc, txt: str}, [], {...type_, ptyp_attributes: []});
 };

 /* Build an AST node representing a "closed" Js.t object representing a component's props */
 let makePropsType = (~loc, namedTypeList) =>
   Typ.mk(
     ~loc,
     Ptyp_constr(
       {txt: Ldot(Ldot(Lident("Js_of_ocaml"), "Js"), "t"), loc},
       [
         {
           ptyp_desc:
             Ptyp_object(
               List.map(makeObjectField(loc), namedTypeList),
               Closed,
             ),
           ptyp_loc: loc,
           ptyp_attributes: [],
         },
       ],
     ),
   );

 /* Builds an AST node for the entire `let` definition of props */
 let makePropsDecl = (fnName, loc, namedArgListWithKeyAndRef, namedTypeList) =>
   makePropsItem(
     fnName,
     loc,
     List.map(pluckLabelDefaultLocType, namedArgListWithKeyAndRef),
     makePropsType(~loc, namedTypeList),
   );
 */
/* TODO: some line number might still be wrong */
/*
 let jsxMapper = () => {
    let transformLowercaseCall = (mapper, loc, attrs, callArguments, id) => {
     let (children, nonChildrenProps) = extractChildren(~loc, callArguments);
     let componentNameExpr = constantString(~loc, id);
     let childrenExpr = transformChildrenIfList(~loc, ~mapper, children);
     let createElementCall =
       switch (children) {
       /* [@JSX] div(~children=[a]), coming from <div> a </div> */
       | {
           pexp_desc:
             Pexp_construct(
               {txt: Lident("::")},
               Some({pexp_desc: Pexp_tuple(_)}),
             ) |
             Pexp_construct({txt: Lident("[]")}, None),
         } => "createDOMElementVariadic"
       /* [@JSX] div(~children= value), coming from <div> ...(value) </div> */
       | _ =>
         raise(
           Invalid_argument(
             "A spread as a DOM element's children don't make sense written together. You can simply remove the spread.",
           ),
         )
       };

     let args =
       switch (nonChildrenProps) {
       | [_justTheUnitArgumentAtEnd] => [
           /* "div" */
           (nolabel, componentNameExpr), /* [|moreCreateElementCallsHere|] */
           (nolabel, childrenExpr),
         ]
       | nonEmptyProps =>
         let propsCall =
           Exp.apply(
             ~loc,
             Exp.ident(
               ~loc,
               {loc, txt: Ldot(Lident("ReactDOM"), "domProps")},
             ),
             nonEmptyProps
             |> List.map(((label, expression)) =>
                  (label, mapper.expr(mapper, expression))
                ),
           );

         [
           /* "div" */
           (nolabel, componentNameExpr), /* ReactDOM.props(~className=blabla, ~foo=bar, ()) */
           (labelled("props"), propsCall), /* [|moreCreateElementCallsHere|] */
           (nolabel, childrenExpr),
         ];
       };

     Exp.apply(
       ~loc, /* throw away the [@JSX] attribute and keep the others, if any */
       ~attrs,
       /* ReactDOM.createElement */
       Exp.ident(
         ~loc,
         {loc, txt: Ldot(Lident("ReactDOM"), createElementCall)},
       ),
       args,
     );
   };

   let rec recursivelyTransformNamedArgsForMake = (mapper, expr, list) => {
     let expr = mapper.expr(mapper, expr);
     switch (expr.pexp_desc) {
     /* TODO: make this show up with a loc. */
     | Pexp_fun(Labelled("key"), _, _, _)
     | Pexp_fun(Optional("key"), _, _, _) =>
       raise(
         Invalid_argument(
           "Key cannot be accessed inside of a component. Don't worry - you can always key a component from its parent!",
         ),
       )
     | Pexp_fun(Labelled("ref"), _, _, _)
     | Pexp_fun(Optional("ref"), _, _, _) =>
       raise(
         Invalid_argument(
           "Ref cannot be passed as a normal prop. Please use `forwardRef` API instead.",
         ),
       )
     | Pexp_fun(arg, default, pattern, expression)
         when isOptional(arg) || isLabelled(arg) =>
       let alias =
         switch (pattern) {
         | {ppat_desc: Ppat_alias(_, {txt}) | Ppat_var({txt})} => txt
         | {ppat_desc: Ppat_any} => "_"
         | _ => getLabel(arg)
         };

       let type_ =
         switch (pattern) {
         | {ppat_desc: Ppat_constraint(_, type_)} => Some(type_)
         | _ => None
         };

       recursivelyTransformNamedArgsForMake(
         mapper,
         expression,
         [(arg, default, pattern, alias, pattern.ppat_loc, type_), ...list],
       );
     | Pexp_fun(
         Nolabel,
         _,
         {ppat_desc: Ppat_construct({txt: Lident("()")}, _) | Ppat_any},
         expression,
       ) => (
         expression.pexp_desc,
         list,
         None,
       )
     | Pexp_fun(Nolabel, _, {ppat_desc: Ppat_var({txt})}, expression) => (
         expression.pexp_desc,
         list,
         Some(txt),
       )
     | innerExpression => (innerExpression, list, None)
     };
   };

   let argToType = (types, (name, default, _noLabelName, _alias, loc, type_)) =>
     switch (type_, name, default) {
     | (
         Some({ptyp_desc: Ptyp_constr({txt: Lident("option")}, [type_])}),
         name,
         _,
       )
         when isOptional(name) => [
         (
           getLabel(name),
           [],
           {
             ...type_,
             ptyp_desc:
               Ptyp_constr({loc: type_.ptyp_loc, txt: optionIdent}, [type_]),
           },
         ),
         ...types,
       ]
     | (Some(type_), name, Some(_default)) => [
         (
           getLabel(name),
           [],
           {
             ptyp_desc: Ptyp_constr({loc, txt: optionIdent}, [type_]),
             ptyp_loc: loc,
             ptyp_attributes: [],
           },
         ),
         ...types,
       ]
     | (Some(type_), name, _) => [(getLabel(name), [], type_), ...types]
     | (None, name, _) when isOptional(name) => [
         (
           getLabel(name),
           [],
           {
             ptyp_desc:
               Ptyp_constr(
                 {loc, txt: optionIdent},
                 [
                   {
                     ptyp_desc: Ptyp_var(safeTypeFromValue(name)),
                     ptyp_loc: loc,
                     ptyp_attributes: [],
                   },
                 ],
               ),
             ptyp_loc: loc,
             ptyp_attributes: [],
           },
         ),
         ...types,
       ]
     | (None, name, _) when isLabelled(name) => [
         (
           getLabel(name),
           [],
           {
             ptyp_desc: Ptyp_var(safeTypeFromValue(name)),
             ptyp_loc: loc,
             ptyp_attributes: [],
           },
         ),
         ...types,
       ]
     | _ => types
     };

   let argToConcreteType = (types, (name, _loc, type_)) =>
     switch (name) {
     | name when isLabelled(name) || isOptional(name) => [
         (getLabel(name), [], type_),
         ...types,
       ]
     /* return value */
     | _ => types
     };

   let nestedModules = ref([]);
   let transformComponentDefinition = (mapper, structure, returnStructures) =>
     switch (structure) {
     /* external */
     | {
         pstr_loc,
         pstr_desc:
           Pstr_primitive(
             {pval_name: {txt: fnName}, pval_attributes, pval_type} as value_description,
           ),
       } as pstr =>
       switch (List.filter(hasAttr, pval_attributes)) {
       | [] => [structure, ...returnStructures]
       | [_] =>
         let rec getPropTypes = (types, {ptyp_loc, ptyp_desc} as fullType) =>
           switch (ptyp_desc) {
           | Ptyp_arrow(name, type_, {ptyp_desc: Ptyp_arrow(_)} as rest)
               when isLabelled(name) || isOptional(name) =>
             getPropTypes([(name, ptyp_loc, type_), ...types], rest)
           | Ptyp_arrow(Nolabel, _type, rest) => getPropTypes(types, rest)
           | Ptyp_arrow(name, type_, returnValue)
               when isLabelled(name) || isOptional(name) => (
               returnValue,
               [(name, returnValue.ptyp_loc, type_), ...types],
             )
           | _ => (fullType, types)
           };

         let (innerType, propTypes) = getPropTypes([], pval_type);
         let namedTypeList = List.fold_left(argToConcreteType, [], propTypes);
         let pluckLabelAndLoc = ((label, loc, type_)) => (
           label,
           None /* default */,
           loc,
           Some(type_),
         );

         let retPropsType = makePropsType(~loc=pstr_loc, namedTypeList);
         let externalPropsDecl =
           makePropsItem(
             fnName,
             pstr_loc,
             [
               (optional("key"), None, pstr_loc, Some(keyType(pstr_loc))),
               ...List.map(pluckLabelAndLoc, propTypes),
             ],
             retPropsType,
           );

         /* can't be an arrow because it will defensively uncurry */
         let newExternalType =
           Ptyp_constr(
             {loc: pstr_loc, txt: Ldot(Lident("React"), "componentLike")},
             [retPropsType, innerType],
           );

         let newStructure = {
           ...pstr,
           pstr_desc:
             Pstr_primitive({
               ...value_description,
               pval_type: {
                 ...pval_type,
                 ptyp_desc: newExternalType,
               },
               pval_attributes: List.filter(otherAttrsPure, pval_attributes),
             }),
         };

         [externalPropsDecl, newStructure, ...returnStructures];
       | _ =>
         raise(
           Invalid_argument(
             "Only one react.component call can exist on a component at one time",
           ),
         )
       }
     /* let component = ... */
     | {pstr_loc, pstr_desc: Pstr_value(recFlag, valueBindings)} =>
       let mapBinding = binding =>
         if (hasAttrOnBinding(binding)) {
           let fnName = getFnName(binding);
           let fileName = filenameFromLoc(pstr_loc);
           let fullModuleName =
             makeModuleName(fileName, nestedModules^, fnName);

           let emptyLoc = Location.in_file(fileName);
           let modifiedBinding = binding => {
             let expression = binding.pvb_expr;
             let wrapExpressionWithBinding = (expressionFn, expression) => {
               ...filterAttrOnBinding(binding),
               pvb_expr: expressionFn(expression),
             };

             /* TODO: there is a long-tail of unsupported features inside of blocks - Pexp_letmodule , Pexp_letexception , Pexp_ifthenelse */
             let rec spelunkForFunExpression = expression =>
               switch (expression) {
               /* let make = (~prop) => ... */
               | {pexp_desc: Pexp_fun(_)} => (
                   (
                     expressionDesc => {
                       ...expression,
                       pexp_desc: expressionDesc,
                     }
                   ),
                   expression,
                 )
               /* let make = {let foo = bar in (~prop) => ...} */
               | {pexp_desc: Pexp_let(recursive, vbs, returnExpression)} =>
                 /* here's where we spelunk! */
                 let (wrapExpression, realReturnExpression) =
                   spelunkForFunExpression(returnExpression);

                 (
                   (
                     expressionDesc => {
                       ...expression,
                       pexp_desc:
                         Pexp_let(
                           recursive,
                           vbs,
                           wrapExpression(expressionDesc),
                         ),
                     }
                   ),
                   realReturnExpression,
                 );
               /* let make = React.forwardRef((~prop) => ...) */
               | {
                   pexp_desc:
                     Pexp_apply(
                       wrapperExpression,
                       [(Nolabel, innerFunctionExpression)],
                     ),
                 } =>
                 let (wrapExpression, realReturnExpression) =
                   spelunkForFunExpression(innerFunctionExpression);

                 (
                   (
                     expressionDesc => {
                       ...expression,
                       pexp_desc:
                         Pexp_apply(
                           wrapperExpression,
                           [(nolabel, wrapExpression(expressionDesc))],
                         ),
                     }
                   ),
                   realReturnExpression,
                 );
               | {
                   pexp_desc:
                     Pexp_sequence(wrapperExpression, innerFunctionExpression),
                 } =>
                 let (wrapExpression, realReturnExpression) =
                   spelunkForFunExpression(innerFunctionExpression);

                 (
                   (
                     expressionDesc => {
                       ...expression,
                       pexp_desc:
                         Pexp_sequence(
                           wrapperExpression,
                           wrapExpression(expressionDesc),
                         ),
                     }
                   ),
                   realReturnExpression,
                 );
               | _ =>
                 raise(
                   Invalid_argument(
                     "react.component calls can only be on function definitions or component wrappers (forwardRef, memo).",
                   ),
                 )
               };

             let (wrapExpression, expression) =
               spelunkForFunExpression(expression);

             (wrapExpressionWithBinding(wrapExpression), expression);
           };

           let (bindingWrapper, expression) = modifiedBinding(binding);
           let reactComponentAttribute =
             try (Some(List.find(hasAttr, binding.pvb_attributes))) {
             | Not_found => None
             };

           let (attr_loc, payload) =
             switch (reactComponentAttribute) {
             | Some((loc, payload)) => (loc.loc, Some(payload))
             | None => (emptyLoc, None)
             };

           let props = getPropsAttr(payload);
           /* do stuff here! */
           let (innerFunctionExpression, namedArgList, forwardRef) =
             recursivelyTransformNamedArgsForMake(mapper, expression, []);

           let namedArgListWithKeyAndRef = [
             (
               optional("key"),
               None,
               Pat.var({txt: "key", loc: emptyLoc}),
               "key",
               emptyLoc,
               Some(keyType(emptyLoc)),
             ),
             ...namedArgList,
           ];

           let namedArgListWithKeyAndRef =
             switch (forwardRef) {
             | Some(_) => [
                 (
                   optional("ref"),
                   None,
                   Pat.var({txt: "key", loc: emptyLoc}),
                   "ref",
                   emptyLoc,
                   Some(refType(emptyLoc)),
                 ),
                 ...namedArgListWithKeyAndRef,
               ]
             | None => namedArgListWithKeyAndRef
             };

           let namedTypeList = List.fold_left(argToType, [], namedArgList);
           let makePropsLet =
             makePropsDecl(
               fnName,
               attr_loc,
               namedArgListWithKeyAndRef,
               namedTypeList,
             );

           let makeLet =
               (
                 innerExpression,
                 (label, default, pattern, _alias, loc, _type),
               ) => {
             let labelString =
               switch (label) {
               | label when isOptional(label) || isLabelled(label) =>
                 getLabel(label)
               | _ => raise(Invalid_argument("This should never happen"))
               };

             let expression =
               /* We need to wrap it with Js_of_ocaml ppx so the ##. operator can be processed correctly */
               Ppx_js.mapper.expr(
                 default_mapper,
                 Exp.apply(
                   ~loc,
                   Exp.ident(~loc, {txt: Lident("##."), loc}),
                   [
                     (
                       nolabel,
                       Exp.ident(~loc, {txt: Lident(props.propsName), loc}),
                     ),
                     (
                       nolabel,
                       Exp.ident(~loc, {txt: Lident(labelString), loc}),
                     ),
                   ],
                 ),
               );

             let expression =
               switch (default) {
               | Some(default) =>
                 Exp.match(
                   expression,
                   [
                     Exp.case(
                       Pat.construct(
                         {loc, txt: Lident("Some")},
                         Some(Pat.var(~loc, {txt: labelString, loc})),
                       ),
                       Exp.ident(~loc, {txt: Lident(labelString), loc}),
                     ),
                     Exp.case(
                       Pat.construct({loc, txt: Lident("None")}, None),
                       default,
                     ),
                   ],
                 )
               | None => expression
               };

             let letExpression = Vb.mk(pattern, expression);
             Exp.let_(~loc, Nonrecursive, [letExpression], innerExpression);
           };

           let innerExpression =
             List.fold_left(
               makeLet,
               Exp.mk(innerFunctionExpression),
               namedArgList,
             );

           let innerExpressionWithRef =
             switch (forwardRef) {
             | Some(txt) => {
                 ...innerExpression,
                 pexp_desc:
                   Pexp_fun(
                     nolabel,
                     None,
                     {
                       ppat_desc: Ppat_var({txt, loc: emptyLoc}),
                       ppat_loc: emptyLoc,
                       ppat_attributes: [],
                     },
                     innerExpression,
                   ),
               }
             | None => innerExpression
             };

           let fullExpression =
             Pexp_fun(
               nolabel,
               None,
               {
                 ppat_desc:
                   Ppat_constraint(
                     makePropsName(~loc=emptyLoc, props.propsName),
                     makePropsType(~loc=emptyLoc, namedTypeList),
                   ),
                 ppat_loc: emptyLoc,
                 ppat_attributes: [],
               },
               innerExpressionWithRef,
             );

           let fullExpression =
             switch (fullModuleName) {
             | "" => fullExpression
             | txt =>
               Pexp_let(
                 Nonrecursive,
                 [
                   Vb.mk(
                     ~loc=emptyLoc,
                     Pat.var(~loc=emptyLoc, {loc: emptyLoc, txt}),
                     Exp.mk(~loc=emptyLoc, fullExpression),
                   ),
                 ],
                 Exp.ident(~loc=emptyLoc, {loc: emptyLoc, txt: Lident(txt)}),
               )
             };

           let newBinding = bindingWrapper(fullExpression);
           (Some(makePropsLet), newBinding);
         } else {
           (None, binding);
         };

       let structuresAndBinding = List.map(mapBinding, valueBindings);
       let otherStructures = ((extern, binding), (externs, bindings)) => {
         let externs =
           switch (extern) {
           | Some(extern) => [extern, ...externs]
           | None => externs
           };

         (externs, [binding, ...bindings]);
       };

       let (externs, bindings) =
         List.fold_right(otherStructures, structuresAndBinding, ([], []));

       externs
       @ [
         {pstr_loc, pstr_desc: Pstr_value(recFlag, bindings)},
         ...returnStructures,
       ];
     | structure => [structure, ...returnStructures]
     };

   let reactComponentTransform = (mapper, structures) =>
     List.fold_right(transformComponentDefinition(mapper), structures, []);

   let transformComponentSignature = (_mapper, signature, returnSignatures) =>
     switch (signature) {
     | {
         psig_loc,
         psig_desc:
           Psig_value(
             {pval_name: {txt: fnName}, pval_attributes, pval_type} as psig_desc,
           ),
       } as psig =>
       switch (List.filter(hasAttr, pval_attributes)) {
       | [] => [signature, ...returnSignatures]
       | [_] =>
         let rec getPropTypes = (types, {ptyp_loc, ptyp_desc} as fullType) =>
           switch (ptyp_desc) {
           | Ptyp_arrow(name, type_, {ptyp_desc: Ptyp_arrow(_)} as rest)
               when isOptional(name) || isLabelled(name) =>
             getPropTypes([(name, ptyp_loc, type_), ...types], rest)
           | Ptyp_arrow(Nolabel, _type, rest) => getPropTypes(types, rest)
           | Ptyp_arrow(name, type_, returnValue)
               when isOptional(name) || isLabelled(name) => (
               returnValue,
               [(name, returnValue.ptyp_loc, type_), ...types],
             )
           | _ => (fullType, types)
           };

         let (innerType, propTypes) = getPropTypes([], pval_type);
         let namedTypeList = List.fold_left(argToConcreteType, [], propTypes);
         let pluckLabelAndLoc = ((label, loc, type_)) => (
           label,
           None,
           loc,
           Some(type_),
         );

         let retPropsType = makePropsType(~loc=psig_loc, namedTypeList);
         let externalPropsDecl =
           makePropsExternalSig(
             fnName,
             psig_loc,
             [
               (optional("key"), None, psig_loc, Some(keyType(psig_loc))),
               ...List.map(pluckLabelAndLoc, propTypes),
             ],
             retPropsType,
           );

         /* can't be an arrow because it will defensively uncurry */
         let newExternalType =
           Ptyp_constr(
             {loc: psig_loc, txt: Ldot(Lident("React"), "componentLike")},
             [retPropsType, innerType],
           );

         let newStructure = {
           ...psig,
           psig_desc:
             Psig_value({
               ...psig_desc,
               pval_type: {
                 ...pval_type,
                 ptyp_desc: newExternalType,
               },
               pval_attributes: List.filter(otherAttrsPure, pval_attributes),
             }),
         };

         [externalPropsDecl, newStructure, ...returnSignatures];
       | _ =>
         raise(
           Invalid_argument(
             "Only one react.component call can exist on a component at one time",
           ),
         )
       }
     | signature => [signature, ...returnSignatures]
     };

   let reactComponentSignatureTransform = (mapper, signatures) =>
     List.fold_right(transformComponentSignature(mapper), signatures, []);

   let signature = (mapper, signature) =>
     default_mapper.signature(mapper) @@
     reactComponentSignatureTransform(mapper, signature);

   let structure = (mapper, structures) =>
     default_mapper.structure(mapper) @@
     reactComponentTransform(mapper, structures);

   let module_binding = (mapper, module_binding) => {
     let _ = nestedModules := [module_binding.pmb_name.txt, ...nestedModules^];
     let mapped = default_mapper.module_binding(mapper, module_binding);
     let _ = nestedModules := List.tl(nestedModules^);
     mapped;
   };

   {...default_mapper, structure, expr, signature, module_binding};
 };
 */

let childrenListToArray = (~loc, ~attrs=?, children) => {
  let rec processChildren = (children, accum) =>
    /* Not in the sense of converting a list to an array; convert the AST
       representation of a list to the AST representation of an array */
    switch (children) {
    | [%expr []] => List.rev(accum) |> Exp.array(~attrs?, ~loc)
    | [%expr [[%e? child], ...[%e? acc]]] =>
      processChildren(acc, [child, ...accum])
    | notAList => notAList
    };
  processChildren(children, []);
};

let extractChildren = (~removeLastPositionUnit=false, ~loc, propsAndChildren) => {
  let rec allButLast_ = (lst, acc) =>
    switch (lst) {
    | [] => []
    | [(Nolabel, [%expr ()])] => acc
    | [(Nolabel, _), ..._rest] =>
      raise(
        Invalid_argument(
          "JSX: found non-labelled argument before the last position",
        ),
      )
    | [arg, ...rest] => allButLast_(rest, [arg, ...acc])
    };

  let allButLast = lst => allButLast_(lst, []) |> List.rev;
  switch (
    List.partition(
      ((label, _)) => label == Labelled("children"),
      propsAndChildren,
    )
  ) {
  | ([], props) =>
    /* no children provided? Place a placeholder list */
    (
      [%expr []],
      if (removeLastPositionUnit) {
        allButLast(props);
      } else {
        props;
      },
    )
  | ([(_, childrenExpr)], props) => (
      childrenExpr,
      if (removeLastPositionUnit) {
        allButLast(props);
      } else {
        props;
      },
    )
  | _ =>
    raise(
      Invalid_argument("JSX: somehow there's more than one `children` label"),
    )
  };
};

let transformUppercaseCall =
    (modulePath, mapper, loc, attrs, _, callArguments) => {
  let (children, argsWithLabels) =
    extractChildren(~loc, ~removeLastPositionUnit=true, callArguments);

  let argsForMake = argsWithLabels;

  let childrenArg = ref(None);
  let args =
    argsForMake
    @ (
      switch (children) {
      | [%expr []] => []
      | [%expr [[%e? child]]] => [(Labelled("children"), child)]
      | [%expr [[%e? child], ...[%e? acc]]] =>
        /* this is a hack to support react components that introspect into their children */
        childrenArg := Some(childrenListToArray(~loc, children));
        [
          (
            Labelled("children"),
            Exp.ident(~loc, {loc, txt: Ldot(Lident("React"), "null")}),
          ),
        ];
      | [%expr [%e? notListChildren]] => [
          (Labelled("children"), notListChildren),
        ]
      }
    )
    @ [(Nolabel, Exp.construct(~loc, {loc, txt: Lident("()")}, None))];

  let isCap = str => {
    let first = String.sub(str, 0, 1);
    let capped = String.uppercase_ascii(first);
    first == capped;
  };

  let ident =
    switch (modulePath) {
    | Lident(_) => Ldot(modulePath, "make")
    | Ldot(_modulePath, value) as fullPath when isCap(value) =>
      Ldot(fullPath, "make")
    | modulePath => modulePath
    };

  let propsIdent =
    switch (ident) {
    | Lident(path) => Lident(path ++ "Props")
    | Ldot(ident, path) => Ldot(ident, path ++ "Props")
    | _ =>
      raise(
        Invalid_argument(
          "JSX name can't be the result of function applications",
        ),
      )
    };

  let props =
    Exp.apply(~attrs, ~loc, Exp.ident(~loc, {loc, txt: propsIdent}), args);

  /* handle key, ref, children */
  /* React.createElement(Component.make, props, ...children) */
  switch (childrenArg^) {
  | None =>
    Exp.apply(
      ~loc,
      ~attrs,
      Exp.ident(~loc, {loc, txt: Ldot(Lident("React"), "createElement")}),
      [(Nolabel, Exp.ident(~loc, {txt: ident, loc})), (Nolabel, props)],
    )
  | Some(children) =>
    Exp.apply(
      ~loc,
      ~attrs,
      Exp.ident(
        ~loc,
        {loc, txt: Ldot(Lident("React"), "createElementVariadic")},
      ),
      [
        (Nolabel, Exp.ident(~loc, {txt: ident, loc})),
        (Nolabel, props),
        (Nolabel, children),
      ],
    )
  };
};

let transformJsxCall = (callExpression, _callArguments, _attrs) => {
  let loc = callExpression.pexp_loc;
  switch (callExpression) {
  | [%expr createElement] =>
    raise(
      Invalid_argument(
        "JSX: `createElement` should be preceeded by a module name.",
      ),
    )
  /* Foo.createElement(~prop1=foo, ~prop2=bar, ~children=[], ()) */
  | [%expr [%e? modulePath].createElement]
  | [%expr [%e? modulePath].make] =>
    transformUppercaseCall(
      modulePath,
      mapper,
      loc,
      attrs,
      callExpression,
      callArguments,
    )
  /* div(~prop1=foo, ~prop2=bar, ~children=[bla], ()) */
  /* turn that into
     ReactDOM.createElement(~props=ReactDOM.props(~props1=foo, ~props2=bar, ()), [|bla|]) */
  | [%expr [%e? _id]] =>
    %expr
    2
  // transformLowercaseCall(mapper, loc, attrs, callArguments, id)
  // | [%expr [%e? _].[%e? _anythingNotCreateElementOrMake]] =>
  //   raise(
  //     Invalid_argument(
  //       "JSX: the JSX attribute should be attached to a `YourModuleName.createElement` or `YourModuleName.make` call. We saw `"
  //       ++ anythingNotCreateElementOrMake
  //       ++ "` instead",
  //     ),
  //   )
  // | {txt: Lapply(_)} =>
  //   /* don't think there's ever a case where this is reached */
  //   raise(
  //     Invalid_argument(
  //       "JSX: encountered a weird case while processing the code. Please report this!",
  //     ),
  //   )
  };
};

let jsxAttribute =
  Attribute.declare(
    "JSX",
    Attribute.Context.expression,
    Ppxlib.Ast_pattern.__,
    ignore,
  );

let mapExprs = {
  as _self;
  inherit class Ast_traverse.map as super;
  pub! expression = expr => {
    let expr = super#expression(expr);
    switch (Attribute.consume(jsxAttribute, expr)) {
    | Some((e, _)) =>
      let loc = e.pexp_loc;
      let nonJSXAttributes = e.pexp_attributes;
      switch (e) {
      /* Is it a function application with the @JSX attribute? e.g. <Hello /> or <div /> */
      | {
          pexp_desc: Pexp_apply(callExpression, callArguments),
          pexp_attributes: _,
        } =>
        transformJsxCall(callExpression, callArguments, nonJSXAttributes)
      /* Is it a list with jsx attribute? Reason <>foo</> desugars to [@JSX][foo] */
      | [%expr [[%e? _v], ...[%e? _acc]]] as children =>
        %expr
        ReactDOM.createFragment(
          [%e childrenListToArray(~attrs=nonJSXAttributes, ~loc, children)],
        )
      | _ => e
      };
    | None => expr
    };
  }
};

let () =
  Ppxlib.Driver.register_transformation(
    "rroo_jsoo_ppx",
    ~impl=mapExprs#structure,
    ~intf=mapExprs#signature,
  );
