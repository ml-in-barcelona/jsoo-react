/*
   This is the file that handles turning Reason JSX' agnostic function call into
   a React-specific function call. Aka, this is a macro, using OCaml's ppx
   facilities; https://whitequark.org/blog/2014/04/16/a-guide-to-extension-points-in-ocaml/
 */

/*
   The transform:
   transform `[@JSX] div(~props1=a, ~props2=b, ~children=[foo, bar], ())` into
   `ReactDOM.createDOMElementVariadic("div", ReactDOM.domProps(~props1=1, ~props2=b), [foo, bar])`.
   transform the upper-cased case
   `[@JSX] Foo.createElement(~key=a, ~ref=b, ~foo=bar, ~children=[], ())` into
   `React.createElement(Foo.make, Foo.makeProps(~key=a, ~ref=b, ~foo=bar, ()))`
   transform the upper-cased case
   `[@JSX] Foo.createElement(~foo=bar, ~children=[foo, bar], ())` into
   `React.createElementVariadic(Foo.make, Foo.makeProps(~foo=bar, ~children=React.null, ()), [foo, bar])`
   transform `[@JSX] [foo]` into
   `React.createFragment([foo])`
 */

open Migrate_parsetree;
open Asttypes;
open Longident;
open Ast_helper;
open Parsetree;
open Ast_mapper;

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

let safeTypeFromValue = valueStr => {
  let valueStr = getLabel(valueStr);
  switch (String.sub(valueStr, 0, 1)) {
  | "_" => "T" ++ valueStr
  | _ => valueStr
  };
};

let keyType = loc =>
  Typ.constr(
    ~loc,
    {loc, txt: optionIdent},
    [Typ.constr(~loc, {loc, txt: Lident("string")}, [])],
  );

let refType = loc =>
  Typ.constr(~loc, {loc, txt: Ldot(Lident("ReactDOM"), "domRef")}, []);

type children('a) =
  | ListLiteral('a)
  | Exact('a);

type componentConfig = {propsName: string};

/* Helper method to look up the [@react.component] attribute */
let hasAttr = ({attr_name, _}) => attr_name.txt == "react.component";

/* Helper method to filter out any attribute that isn't [@react.component] */
let otherAttrsPure = ({attr_name, _}) => attr_name.txt != "react.component";

/* Iterate over the attributes and try to find the [@react.component] attribute */
let hasAttrOnBinding = ({pvb_attributes, _}) =>
  find_opt(hasAttr, pvb_attributes) != None;

/* Filter the [@react.component] attribute and immutably replace them on the binding */
let filterAttrOnBinding = binding => {
  ...binding,
  pvb_attributes: List.filter(otherAttrsPure, binding.pvb_attributes),
};

/* Finds the name of the variable the binding is assigned to, otherwise raises Invalid_argument */
let getFnName = binding =>
  switch (binding) {
  | {pvb_pat: {ppat_desc: Ppat_var({txt, _}), _}, _} => txt
  | _ =>
    raise(Invalid_argument("react.component calls cannot be destructured."))
  };

/* Lookup the value of `props` otherwise raise Invalid_argument error */
let getPropsNameValue = (_acc, (loc, exp)) =>
  switch (loc, exp) {
  | (
      {txt: Lident("props"), _},
      {pexp_desc: Pexp_ident({txt: Lident(str), _}), _},
    ) => {
      propsName: str,
    }
  | ({txt, _}, _) =>
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
            Pstr_eval({pexp_desc: Pexp_record(recordFields, None), _}, _),
          _,
        },
        ..._rest,
      ]),
    ) =>
    List.fold_left(getPropsNameValue, defaultProps, recordFields)
  | Some(PStr([[%stri props], ..._rest])) => {propsName: "props"}
  | Some(PStr([{pstr_desc: Pstr_eval(_, _), _}, ..._rest])) =>
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
    try(Filename.chop_extension(Filename.basename(fileName))) {
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

let argToConcreteType = (types, (name, _loc, type_)) =>
  switch (name) {
  | name when isLabelled(name) || isOptional(name) => [
      (getLabel(name), [], type_),
      ...types,
    ]
  /* return value */
  | _ => types
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
      | (label, None, Some(_)) =>
        Typ.mk(~loc, Ptyp_var(safeTypeFromValue(label)))
      /* ~foo: int=1 */
      | (_label, Some(type_), Some(_)) => type_
      /* ~foo: option(int)=? */
      | (
          label,
          Some({
            ptyp_desc: Ptyp_constr({txt: Lident("option"), _}, [type_]),
            _,
          }),
          _,
        )
      | (
          label,
          Some({
            ptyp_desc:
              Ptyp_constr(
                {txt: Ldot(Lident("*predef*"), "option"), _},
                [type_],
              ),
            _,
          }),
          _,
        )
      /* ~foo: int=? - note this isnt valid. but we want to get a type error */
      | (label, Some(type_), _) when isOptional(label) => type_
      /* ~foo=? */
      | (label, None, _) when isOptional(label) =>
        Typ.mk(~loc, Ptyp_var(safeTypeFromValue(label)))
      /* ~foo */
      | (label, None, _) =>
        Typ.mk(~loc, Ptyp_var(safeTypeFromValue(label)))
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
          ppat_loc_stack: [],
        },
        args,
      ),
    )
  | [] => args
  };

/* Build an AST node for the makeProps value binding */
let makePropsValue = (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
  let propsName = fnName ++ "Props";
  Val.mk(
    ~loc,
    {txt: propsName, loc},
    makeArgsForMakePropsType(
      namedArgListWithKeyAndRef,
      Typ.arrow(
        Nolabel,
        {
          ptyp_desc: Ptyp_constr({txt: Lident("unit"), loc}, []),
          ptyp_loc: loc,
          ptyp_attributes: [],
          ptyp_loc_stack: [],
        },
        propsType,
      ),
    ),
  );
};

/* Build an AST node for the props name when converted to a Js.t inside the function signature  */
let makePropsName = (~loc, name) =>
  Pat.mk(~loc, Ppat_var({txt: name, loc}));

/* AST for the creation of a JavaScript object using Js_of_ocaml.Js.obj */
let makeJsObj = (~loc, namedArgListWithKeyAndRef) => {
  /* Creates the ("key", inject(key)), ("name", inject(name)) tuples */
  let labelToTuple = label => {
    let l = getLabel(label);
    let id = Exp.ident(~loc, {txt: Lident(l), loc});
    let expr =
      l == "key"
        ? [%expr
          (
            [%e Exp.constant(~loc, Pconst_string(l, None))],
            inject(
              Option.map(Js_of_ocaml.Js.string, [%e id])
              |> Js_of_ocaml.Js.Opt.option,
            ),
          )
        ]
        : [%expr
          (
            [%e Exp.constant(~loc, Pconst_string(l, None))],
            inject([%e id]),
          )
        ];
    isOptional(label)
      ? [%expr
        Option.map(
          _ => {
            %e
            expr
          },
          [%e id],
        )
      ]
      : [%expr Some([%e expr])];
  };
  %expr
  obj(
    [%e
      Exp.array(
        ~loc,
        List.map(
          ((label, _, _, _)) => labelToTuple(label),
          namedArgListWithKeyAndRef,
        ),
      )
    ]
    |> Array.to_list
    |> List.filter_map(x => x)
    |> Array.of_list,
  );
};

/* Build an AST node for the makeProps value binding */
let makePropsValueBinding =
    (fnName, loc, namedArgListWithKeyAndRef, propsType) => {
  let core_type =
    makeArgsForMakePropsType(
      namedArgListWithKeyAndRef,
      [%type: unit => [%t propsType]],
    );

  let propsName = fnName ++ "Props";
  Vb.mk(
    ~loc,
    Pat.mk(
      ~loc,
      Ppat_constraint(
        makePropsName(~loc, propsName),
        {
          /* Not sure why, but in the type definition of the props Ptyp_poly is needed */
          ptyp_desc: Ptyp_poly([], core_type),
          ptyp_loc: loc,
          ptyp_attributes: [],
          ptyp_loc_stack: [],
        },
      ),
    ),
    Exp.mk(
      ~loc,
      Pexp_constraint(
        makeFunsForMakePropsBody(
          namedArgListWithKeyAndRef,
          [%expr
            _ => {
              open Js_of_ocaml.Js.Unsafe;
              %e
              makeJsObj(~loc, namedArgListWithKeyAndRef);
            }
          ],
        ),
        core_type,
      ),
    ),
  );
};

/* Build an AST node representing the `let makeProps` structure item */
let makePropsItem = (fnName, loc, namedArgListWithKeyAndRef, propsType) =>
  Str.mk(
    ~loc,
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
  );

/* Build an AST node for the signature of the `makeProps` definition */
let makePropsSig = (fnName, loc, namedArgListWithKeyAndRef, propsType) =>
  Sig.mk(
    ~loc,
    Psig_value(
      makePropsValue(fnName, loc, namedArgListWithKeyAndRef, propsType),
    ),
  );

let makeObjectField = (loc, (str, _attrs, propType)) => {
  let type_ = [%type: Js_of_ocaml.Js.readonly_prop([%t propType])];
  /* intentionally not using attrs - they probably don't work on object fields. use on *Props instead */
  {
    pof_desc: Otag({loc, txt: str}, {...type_, ptyp_attributes: []}),
    pof_loc: loc,
    pof_attributes: [],
  };
};

/* Build an AST node representing a "closed" Js.t object representing a component's props */
let makePropsType = (~loc, namedTypeList) =>
  Typ.mk(
    ~loc,
    Ptyp_constr(
      {txt: Ldot(Ldot(Lident("Js_of_ocaml"), "Js"), "t"), loc},
      [
        Typ.mk(
          ~loc,
          Ptyp_object(
            List.map(makeObjectField(loc), namedTypeList),
            Closed,
          ),
        ),
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
      | {ppat_desc: Ppat_alias(_, {txt, _}) | Ppat_var({txt, _}), _} => txt
      | {ppat_desc: Ppat_any, _} => "_"
      | _ => getLabel(arg)
      };

    let type_ =
      switch (pattern) {
      | {ppat_desc: Ppat_constraint(_, type_), _} => Some(type_)
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
      {ppat_desc: Ppat_construct({txt: Lident("()"), _}, _) | Ppat_any, _},
      expression,
    ) => (
      expression.pexp_desc,
      list,
      None,
    )
  | Pexp_fun(Nolabel, _, {ppat_desc: Ppat_var({txt, _}), _}, expression) => (
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
      Some({
        ptyp_desc: Ptyp_constr({txt: Lident("option"), _}, [type_]),
        _,
      }),
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
        Typ.mk(~loc, Ptyp_constr({loc, txt: optionIdent}, [type_])),
      ),
      ...types,
    ]
  | (Some(type_), name, _) => [(getLabel(name), [], type_), ...types]
  | (None, name, _) when isOptional(name) => [
      (
        getLabel(name),
        [],
        Typ.mk(
          ~loc,
          Ptyp_constr(
            {loc, txt: optionIdent},
            [Typ.mk(~loc, Ptyp_var(safeTypeFromValue(name)))],
          ),
        ),
      ),
      ...types,
    ]
  | (None, name, _) when isLabelled(name) => [
      (
        getLabel(name),
        [],
        Typ.mk(~loc, Ptyp_var(safeTypeFromValue(name))),
      ),
      ...types,
    ]
  | _ => types
  };

let transformComponentSignature = (_mapper, signature, returnSignatures) =>
  switch (signature) {
  | {
      psig_loc,
      psig_desc:
        Psig_value(
          {pval_name: {txt: fnName, _}, pval_attributes, pval_type, _} as psig_desc,
        ),
    } as psig =>
    switch (List.filter(hasAttr, pval_attributes)) {
    | [] => [signature, ...returnSignatures]
    | [_] =>
      let rec getPropTypes = (types, {ptyp_loc, ptyp_desc, _} as fullType) =>
        switch (ptyp_desc) {
        | Ptyp_arrow(name, type_, {ptyp_desc: Ptyp_arrow(_), _} as rest)
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
      let makePropsDecl =
        makePropsSig(
          fnName,
          psig_loc,
          [
            (Optional("key"), None, psig_loc, Some(keyType(psig_loc))),
            ...List.map(pluckLabelAndLoc, propTypes),
          ],
          retPropsType,
        );

      /* can't be an arrow because it will defensively uncurry */
      let newMakeType =
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
              ptyp_desc: newMakeType,
            },
            pval_attributes: List.filter(otherAttrsPure, pval_attributes),
          }),
      };

      [makePropsDecl, newStructure, ...returnSignatures];
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

let extractChildren =
    (~callerLoc, ~removeLastPositionUnit=false, propsAndChildren) => {
  let rec allButLast_ = (lst, acc) =>
    switch (lst) {
    | [] => []
    | [(Nolabel, [%expr ()])] => acc
    | [arg, ...rest] => allButLast_(rest, [arg, ...acc])
    };

  let allButLast = lst => allButLast_(lst, []) |> List.rev;

  let (children, restProps) =
    List.partition(
      ((label, _)) => label == Labelled("children"),
      propsAndChildren,
    );

  let childrenExpr =
    switch (children) {
    | [] =>
      /* No children provided? Add a placeholder list */
      let loc = {...callerLoc, Location.loc_ghost: true};
      %expr
      [];
    | [(_childrenLabel, childrenExpr)] => childrenExpr
    | _ =>
      raise(
        Invalid_argument(
          "JSX: somehow there's more than one `children` label",
        ),
      )
    };
  let rest = removeLastPositionUnit ? allButLast(restProps) : restProps;
  (childrenExpr, rest);
};

let transformUppercaseCall = (~callerLoc, modulePath, callArguments) => {
  let gloc = {...callerLoc, Location.loc_ghost: true};
  let (children, argsWithLabels) =
    extractChildren(~callerLoc, ~removeLastPositionUnit=true, callArguments);

  let argsForMake = argsWithLabels;

  let childrenArg = ref(None);

  let processedChildren =
    switch (children) {
    | [%expr []] => None
    | [%expr [[%e? child]]] => Some(child)
    | [%expr [[%e? _child], ...[%e? _acc]]] =>
      /* this is a hack to support react components that introspect into their children */
      childrenArg := Some(children);
      let loc = gloc;
      Some([%expr React.null]);
    | [%expr [%e? notListChildren]] => Some(notListChildren)
    };
  let args = {
    let loc = gloc;
    argsForMake
    @ {
      switch (processedChildren) {
      | Some(c) => [(Labelled("children"), c)]
      | None => []
      };
    }
    @ [(Nolabel, [%expr ()])];
  };

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

  let props = {
    let loc = gloc;
    Exp.apply(~loc, Exp.ident(~loc, {loc, txt: propsIdent}), args);
  };

  /* handle key, ref, children */
  /* React.createElement(Component.make, props, ...children) */
  let loc = callerLoc; // This is really the only expression that should have proper loc
  switch (childrenArg^) {
  | None =>
    Exp.apply(
      ~loc,
      [%expr React.createElement],
      [(Nolabel, Exp.ident(~loc, {txt: ident, loc})), (Nolabel, props)],
    )
  | Some(children) =>
    Exp.apply(
      ~loc,
      [%expr React.createElementVariadic],
      [
        (Nolabel, Exp.ident(~loc, {txt: ident, loc})),
        (Nolabel, props),
        (Nolabel, children),
      ],
    )
  };
};

let transformLowercaseCall = (~callerLoc, callArguments, id) => {
  let gloc = {...callerLoc, Location.loc_ghost: true};
  let (children, nonChildrenProps) =
    extractChildren(~callerLoc, callArguments);
  let componentNameExpr = Exp.constant(Pconst_string(id, None));
  let createElementCall =
    switch (children) {
    /* [@JSX] div(~children=[a]), coming from <div> a </div> */
    | [%expr []] => "createDOMElementVariadic"
    | [%expr [[%e? _child], ...[%e? _acc]]] => "createDOMElementVariadic"
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
    | [_justTheUnitArgumentAtEnd] =>
      let loc = gloc;
      [
        /* "div" */
        (Nolabel, componentNameExpr),
        /* ReactDOM.domProps(()) */
        (Labelled("props"), [%expr ReactDOM.domProps()]),
        /* [moreCreateElementCallsHere] */
        (Nolabel, children),
      ];
    | nonEmptyProps =>
      let loc = gloc;
      let propsCall = Exp.apply([%expr ReactDOM.domProps], nonEmptyProps);
      [
        /* "div" */
        (Nolabel, componentNameExpr),
        /* ReactDOM.domProps(~className=blabla, ~foo=bar, ()) */
        (Labelled("props"), propsCall),
        /* [moreCreateElementCallsHere] */
        (Nolabel, children),
      ];
    };

  Exp.apply(
    ~loc=callerLoc,
    /* ReactDOM.createElement */
    Exp.ident(
      ~loc=callerLoc,
      {loc: callerLoc, txt: Ldot(Lident("ReactDOM"), createElementCall)},
    ),
    args,
  );
};

let transformJsxCall = (callExpression, callArguments) => {
  switch (callExpression) {
  | [%expr createElement] =>
    raise(
      Invalid_argument(
        "JSX: `createElement` should be preceeded by a module name.",
      ),
    )
  /* Foo.createElement(~prop1=foo, ~prop2=bar, ~children=[], ()) */
  | {
      pexp_desc:
        Pexp_ident({txt: Ldot(modulePath, "createElement" | "make"), _}),
      _,
    }
  /* This is just included because of the tests. We can't use Reason-syntax code: https://github.com/ocaml-ppx/ocaml-migrate-parsetree/issues/74
     So we use OCaml code. But the generated code from <Foo.make /> creates Foo.make.createElement in OCaml code,
     which is parsed as Pexp_field */
  | {
      pexp_desc:
        Pexp_field(
          {pexp_desc: Pexp_ident({txt: modulePath, _}), _},
          {txt: Lident("createElement"), _},
        ),
      _,
    } =>
    transformUppercaseCall(
      ~callerLoc=callExpression.pexp_loc,
      modulePath,
      callArguments,
    )
  /* div(~prop1=foo, ~prop2=bar, ~children=[bla], ()) */
  /* turn that into
     ReactDOM.createElement(~props=ReactDOM.props(~props1=foo, ~props2=bar, ()), [bla]) */
  | {pexp_desc: Pexp_ident({txt: Lident(id), _}), _} =>
    transformLowercaseCall(
      ~callerLoc=callExpression.pexp_loc,
      callArguments,
      id,
    )
  | {
      pexp_desc:
        Pexp_ident({txt: Ldot(_, anythingNotCreateElementOrMake), _}),
      _,
    } =>
    raise(
      Invalid_argument(
        "JSX: the JSX attribute should be attached to a `YourModuleName.createElement` or `YourModuleName.make` call. We saw `"
        ++ anythingNotCreateElementOrMake
        ++ "` instead",
      ),
    )
  | {pexp_desc: Pexp_ident({txt: Lapply(_), _}), _} =>
    /* don't think there's ever a case where this is reached */
    raise(
      Invalid_argument(
        "JSX: encountered a weird case while processing the code. Please report this!",
      ),
    )
  | _ =>
    raise(
      Invalid_argument(
        "JSX: `createElement` should be preceeded by a simple, direct module name.",
      ),
    )
  };
};

let consumeAttribute = (attrTxt, expr) => {
  let (foundAttrs, otherAttrs) =
    List.partition(
      ({attr_name, _}) => attr_name.txt == attrTxt,
      expr.pexp_attributes,
    );
  switch (foundAttrs) {
  | [] => None
  | _ => Some({...expr, pexp_attributes: otherAttrs})
  };
};

let jsxMapper = () => {
  let nestedModules = ref([]);

  let transformComponentDefinition = (mapper, structure, returnStructures) =>
    switch (structure) {
    /* external */
    | {
        pstr_loc,
        pstr_desc:
          Pstr_primitive(
            {pval_name: {txt: fnName, _}, pval_attributes, pval_type, _} as value_description,
          ),
      } as pstr =>
      switch (List.filter(hasAttr, pval_attributes)) {
      | [] => [structure, ...returnStructures]
      | [_] =>
        let rec getPropTypes = (types, {ptyp_loc, ptyp_desc, _} as fullType) =>
          switch (ptyp_desc) {
          | Ptyp_arrow(name, type_, {ptyp_desc: Ptyp_arrow(_), _} as rest)
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
              (Optional("key"), None, pstr_loc, Some(keyType(pstr_loc))),
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
              | {pexp_desc: Pexp_fun(_), _} => (
                  (
                    expressionDesc => {
                      ...expression,
                      pexp_desc: expressionDesc,
                    }
                  ),
                  expression,
                )
              /* let make = {let foo = bar in (~prop) => ...} */
              | {pexp_desc: Pexp_let(recursive, vbs, returnExpression), _} =>
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
                  _,
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
                          [(Nolabel, wrapExpression(expressionDesc))],
                        ),
                    }
                  ),
                  realReturnExpression,
                );
              | {
                  pexp_desc:
                    Pexp_sequence(wrapperExpression, innerFunctionExpression),
                  _,
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
            try(Some(List.find(hasAttr, binding.pvb_attributes))) {
            | Not_found => None
            };

          let (attrLoc, payload) =
            switch (reactComponentAttribute) {
            | Some({attr_loc, attr_payload, _}) => (
                attr_loc,
                Some(attr_payload),
              )
            | None => (emptyLoc, None)
            };

          let props = getPropsAttr(payload);
          /* do stuff here! */
          let (innerFunctionExpression, namedArgList, forwardRef) =
            recursivelyTransformNamedArgsForMake(mapper, expression, []);

          let namedArgListWithKeyAndRef = [
            (
              Optional("key"),
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
                  Optional("ref"),
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
              attrLoc,
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

            let expression = {
              /* We need to wrap it with Js_of_ocaml ppx so the ##. operator can be processed correctly */
              let propsNameId =
                Exp.ident(~loc, {txt: Lident(props.propsName), loc});
              let labelStringId =
                Exp.ident(~loc, {txt: Lident(labelString), loc});
              Ppx_js.mapper.expr(
                default_mapper,
                [%expr [%e propsNameId]##.[%e labelStringId]],
              );
            };

            let expression =
              switch (default) {
              | Some(default) =>
                switch%expr ([%e expression]) {
                | Some([%p Pat.var({txt: labelString, loc})]) =>
                  %e
                  Exp.ident({
                    txt: Lident(labelString),
                    loc: {
                      ...loc,
                      Location.loc_ghost: true,
                    },
                  })
                | None =>
                  %e
                  default
                }
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
                    Nolabel,
                    None,
                    {
                      ppat_desc: Ppat_var({txt, loc: emptyLoc}),
                      ppat_loc: emptyLoc,
                      ppat_attributes: [],
                      ppat_loc_stack: [],
                    },
                    innerExpression,
                  ),
              }
            | None => innerExpression
            };

          let fullExpression =
            Pexp_fun(
              Nolabel,
              None,
              {
                ppat_desc:
                  Ppat_constraint(
                    makePropsName(~loc=emptyLoc, props.propsName),
                    makePropsType(~loc=emptyLoc, namedTypeList),
                  ),
                ppat_loc: emptyLoc,
                ppat_attributes: [],
                ppat_loc_stack: [],
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

  let signature = (mapper, signature) =>
    default_mapper.signature(mapper) @@
    reactComponentSignatureTransform(mapper, signature);

  let structure = (mapper, structures) =>
    default_mapper.structure(mapper) @@
    reactComponentTransform(mapper, structures);

  let expr = (mapper, expr) =>
    switch (expr |> consumeAttribute("JSX")) {
    | Some({pexp_loc: callerLoc, pexp_attributes: nonJsxAttributes, _} as e) =>
      switch (e) {
      /* Is it a function application with the @JSX attribute? e.g. <Hello /> or <div /> */
      | {pexp_desc: Pexp_apply(cexp, callArguments), _} =>
        let callExpression = mapper.expr(mapper, cexp);
        let callArguments =
          List.map(
            ((s, e)) => (s, mapper.expr(mapper, e)),
            callArguments,
          );
        let newExpr = transformJsxCall(callExpression, callArguments);
        mapper.expr(mapper, {...newExpr, pexp_attributes: nonJsxAttributes});
      /* Is it a list with jsx attribute? Reason <>foo</> desugars to [@JSX][foo] */
      | [%expr [[%e? _child], ...[%e? _moreChildren]]] as children =>
        let children = mapper.expr(mapper, children);
        let loc = callerLoc;
        let newExpr = [%expr React.createFragment([%e children])];
        mapper.expr(mapper, {...newExpr, pexp_attributes: nonJsxAttributes});
      | _ => e
      }
    | None => default_mapper.expr(mapper, expr)
    };

  let module_binding = (mapper, module_binding) => {
    let _ = nestedModules := [module_binding.pmb_name.txt, ...nestedModules^];
    let mapped = default_mapper.module_binding(mapper, module_binding);
    let _ = nestedModules := List.tl(nestedModules^);
    mapped;
  };

  {...default_mapper, structure, expr, signature, module_binding};
};

let () =
  Driver.register(
    ~name="jsoo-react-ppx",
    Migrate_parsetree.Versions.ocaml_408,
    (_config, _cookies) =>
    jsxMapper()
  );
