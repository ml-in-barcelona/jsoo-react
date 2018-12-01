let react = Js.Unsafe.global##.react##.react;

type reactClass;

type jsProps;

type reactElement;

type reactRef;

let null: reactElement = Js.Unsafe.js_expr("null");

external string: string => reactElement = "%identity";

external array: array(reactElement) => reactElement = "%identity";

external refToJsObj: reactRef => Js.t({..}) = "%identity";

let createElement:
  (reactClass, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  react##.createElement;

let cloneElement:
  (reactElement, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  react##.cloneElement;

let createElementVerbatim: 'a = react##.createElement;

let createDomElement = (s, ~props, children) => {
  let vararg =
    Js.array([|Obj.magic(s), Obj.magic(props)|]) |> children##.concat;
  /* Use varargs to avoid warnings on duplicate keys in children */
  Obj.magic(createElementVerbatim)##apply(Js.null, vararg);
};

let magicNull: 'a = Js.Unsafe.js_expr("null");

type reactClassInternal = reactClass;

type renderNotImplemented =
  | RenderNotImplemented;

type stateless = unit;

type noRetainedProps = unit;

type actionless = unit;

/***
 * Elements are what JSX blocks become. They represent the *potential* for a
 * component instance and state to be created / updated. They are not yet
 * instances.
 */
type element =
  | Element(component('state, 'retainedProps, 'action)): element
and jsPropsToReason('jsProps, 'state, 'retainedProps, 'action) =
  'jsProps => component('state, 'retainedProps, 'action)
and uncurriedJsPropsToReason('jsProps, 'state, 'retainedProps, 'action) =
  (. 'jsProps) => component('state, 'retainedProps, 'action)
/***
 * Type of hidden field for Reason components that use JS components
 */
and jsElementWrapped =
  option(
    (~key: Js.opt(Js.js_string), ~ref: Js.opt(Js.opt(reactRef) => unit)) =>
    reactElement,
  )
and update('state, 'retainedProps, 'action) =
  | NoUpdate
  | Update('state)
  | SideEffects(self('state, 'retainedProps, 'action) => unit)
  | UpdateWithSideEffects(
      'state,
      self('state, 'retainedProps, 'action) => unit,
    )
/***
 * Granularly types state, and initial state as being independent, so that we
 * may include a template that all instances extend from.
 */
and componentSpec(
  'state,
  'initialState,
  'retainedProps,
  'initialRetainedProps,
  'action,
) = {
  debugName: string,
  reactClassInternal,
  /* Keep here as a way to prove that the API may be implemented soundly */
  mutable handedOffState: ref(option('state)),
  willReceiveProps: self('state, 'retainedProps, 'action) => 'state,
  didMount: self('state, 'retainedProps, 'action) => unit,
  didUpdate: oldNewSelf('state, 'retainedProps, 'action) => unit,
  willUnmount: self('state, 'retainedProps, 'action) => unit,
  willUpdate: oldNewSelf('state, 'retainedProps, 'action) => unit,
  shouldUpdate: oldNewSelf('state, 'retainedProps, 'action) => bool,
  render: self('state, 'retainedProps, 'action) => reactElement,
  initialState: unit => 'initialState,
  retainedProps: 'initialRetainedProps,
  reducer: ('action, 'state) => update('state, 'retainedProps, 'action),
  jsElementWrapped,
}
and component('state, 'retainedProps, 'action) =
  componentSpec('state, 'state, 'retainedProps, 'retainedProps, 'action)
and self('state, 'retainedProps, 'action) = {
  handle:
    'payload.
    (('payload, self('state, 'retainedProps, 'action)) => unit, 'payload) =>
    unit,

  state: 'state,
  retainedProps: 'retainedProps,
  send: 'action => unit,
  onUnmount: (unit => unit) => unit,
}
and oldNewSelf('state, 'retainedProps, 'action) = {
  oldSelf: self('state, 'retainedProps, 'action),
  newSelf: self('state, 'retainedProps, 'action),
};

type jsComponentThis('state, 'props, 'retainedProps, 'action) = {
  .
  "state": Js.readonly_prop(totalState('state, 'retainedProps, 'action)),
  "props": Js.readonly_prop({. "reasonProps": Js.readonly_prop('props)}),
  "setState":
    Js.readonly_prop(
      Js.meth_callback(
        jsComponentThis('state, 'props, 'retainedProps, 'action),
        (
          (totalState('state, 'retainedProps, 'action), 'props) =>
          totalState('state, 'retainedProps, 'action),
          Js.opt(unit => unit)
        ) =>
        unit,
      ),
    ),
  "jsPropsToReason":
    Js.readonly_prop(
      option(
        uncurriedJsPropsToReason('props, 'state, 'retainedProps, 'action),
      ),
    ),
}
/***
 * `totalState` tracks all of the internal reason API bookkeeping.
 *
 * Since we will mutate `totalState` in `shouldComponentUpdate`, and since
 * there's no guarantee that returning true from `shouldComponentUpdate`
 * guarantees that a component's update *actually* takes place (it could get
 * rolled back by Fiber etc), then we should put all properties that we
 * mutate directly on the totalState, so that when Fiber makes backup shallow
 * backup copies of `totalState`, our changes can be rolled back correctly
 * even when we mutate them.
 */
and totalState('state, 'retainedProps, 'action) = {
  .
  "reasonState": Js.readonly_prop('state),
};

let anyToUnit = _ => ();

let anyToTrue = _ => true;

let willReceivePropsDefault = ({state}) => state;

let renderDefault = _self => string("RenderNotImplemented");

let initialStateDefault = () => ();

let reducerDefault:
  ('action, 'state) => update('state, 'retainedProps, 'action) =
  (_action, _state) => NoUpdate;

let convertPropsIfTheyreFromJs = (props, jsPropsToReason, debugName) => {
  let props = Obj.magic(props);
  switch (Js.Opt.to_option(props##.reasonProps), jsPropsToReason) {
  | (Some(props), _) => props
  | (None, Some(toReasonProps)) => Element(toReasonProps(. props))
  | (None, None) =>
    raise(
      Invalid_argument(
        "A JS component called the Reason component "
        ++ debugName
        ++ " which didn't implement the JS->Reason React props conversion.",
      ),
    )
  };
};

let createClass =
    (type reasonState, type retainedProps, type action, debugName): reactClass =>
  ReactOptimizedCreateClass.createClass(
    [%js
      {
        as self; /* Equivalent of this */
        /***
         * TODO: Null out fields that aren't overridden beyond defaults in
         * `component`. React optimizes components that don't implement
         * lifecycles!
         */
        val displayName = debugName;
        val mutable subscriptions = Js.null;
        /***
         * TODO: Avoid allocating this every time we need it. Should be doable.
         */
        pub self = (state, retainedProps) => {
          handle: Obj.magic(self##.handleMethod),
          send: Obj.magic(self##.sendMethod),
          state,
          retainedProps,
          onUnmount: Obj.magic(self##.onUnmountMethod),
        };
        pub getInitialState = (): totalState('state, 'retainedProps, 'action) => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let convertedReasonProps =
            convertPropsIfTheyreFromJs(
              thisJs##.props,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(component) = convertedReasonProps;
          let initialReasonState = component.initialState();
          %js
          {val reasonState = Obj.magic(initialReasonState)};
        };
        pub componentDidMount = () => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let convertedReasonProps =
            convertPropsIfTheyreFromJs(
              thisJs##.props,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(component) = convertedReasonProps;
          let curTotalState = thisJs##.state;
          let curReasonState = curTotalState##.reasonState;
          let self =
            self##.self(curReasonState, Obj.magic(component.retainedProps));
          let self = Obj.magic(self);
          if (component.didMount !== anyToUnit) {
            component.didMount(self);
          };
        };
        pub componentDidUpdate = (prevProps, prevState) => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let curState = thisJs##.state;
          let curReasonState = curState##.reasonState;
          let newJsProps = thisJs##.props;
          let newConvertedReasonProps =
            convertPropsIfTheyreFromJs(
              newJsProps,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(newComponent) = newConvertedReasonProps;
          if (newComponent.didUpdate !== anyToUnit) {
            let oldConvertedReasonProps =
              prevProps === newJsProps ?
                newConvertedReasonProps :
                convertPropsIfTheyreFromJs(
                  prevProps,
                  thisJs##.jsPropsToReason,
                  debugName,
                );
            let Element(oldComponent) = oldConvertedReasonProps;
            let prevReasonState = prevState##.reasonState;
            let prevReasonState = Obj.magic(prevReasonState);
            let newSelf =
              self##.self(
                curReasonState,
                Obj.magic(newComponent.retainedProps),
              );
            let newSelf = Obj.magic(newSelf);
            /* bypass self##.self call for small perf boost */
            let oldSelf =
              Obj.magic({
                ...newSelf,
                state: prevReasonState,
                retainedProps: oldComponent.retainedProps,
              });
            newComponent.didUpdate({oldSelf, newSelf});
          };
        };
        /* pub componentWillMount .. TODO (or not?) */
        pub componentWillUnmount = () => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let convertedReasonProps =
            convertPropsIfTheyreFromJs(
              thisJs##.props,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(component) = convertedReasonProps;
          let curState = thisJs##.state;
          let curReasonState = curState##.reasonState;
          if (component.willUnmount !== anyToUnit) {
            let self =
              self##.self(
                curReasonState,
                Obj.magic(component.retainedProps),
              );
            let self = Obj.magic(self);
            component.willUnmount(self);
          };
          switch (Js.Opt.to_option(self##.subscriptions)) {
          | None => ()
          | Some(subs) => subs##.forEach(unsubscribe => unsubscribe())
          };
        };
        /***
         * If we are even getting this far, we've already done all the logic for
         * detecting unnecessary updates in shouldComponentUpdate. We know at
         * this point that we need to rerender, and we've even *precomputed* the
         * render result (subelements)!
         */
        pub componentWillUpdate = (nextProps, nextState: totalState(_)) => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let newConvertedReasonProps =
            convertPropsIfTheyreFromJs(
              nextProps,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(newComponent) = newConvertedReasonProps;
          if (newComponent.willUpdate !== anyToUnit) {
            let oldJsProps = thisJs##.props;
            /* Avoid converting again the props that are just the same as curProps. */
            let oldConvertedReasonProps =
              nextProps === oldJsProps ?
                newConvertedReasonProps :
                convertPropsIfTheyreFromJs(
                  oldJsProps,
                  thisJs##.jsPropsToReason,
                  debugName,
                );
            let Element(oldComponent) = oldConvertedReasonProps;
            let curState = thisJs##.state;
            let curReasonState = curState##.reasonState;
            let curReasonState = Obj.magic(curReasonState);
            let nextReasonState = nextState##.reasonState;
            let newSelf =
              self##.self(
                nextReasonState,
                Obj.magic(newComponent.retainedProps),
              );
            let newSelf = Obj.magic(newSelf);
            /* bypass self##.self call for small perf boost */
            let oldSelf =
              Obj.magic({
                ...newSelf,
                state: curReasonState,
                retainedProps: oldComponent.retainedProps,
              });
            newComponent.willUpdate({oldSelf, newSelf});
          };
        };
        /***
         * One interesting part of the new Reason React API. There isn't a need
         * for a separate `willReceiveProps` function. The primary `create` API
         * is *always* receiving props.
         */
        pub componentWillReceiveProps = nextProps => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let newConvertedReasonProps =
            convertPropsIfTheyreFromJs(
              nextProps,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(newComponent) = Obj.magic(newConvertedReasonProps);
          if (newComponent.willReceiveProps !== willReceivePropsDefault) {
            let oldJsProps = thisJs##.props;
            /* Avoid converting again the props that are just the same as curProps. */
            let oldConvertedReasonProps =
              nextProps === oldJsProps ?
                newConvertedReasonProps :
                convertPropsIfTheyreFromJs(
                  oldJsProps,
                  thisJs##.jsPropsToReason,
                  debugName,
                );
            let Element(oldComponent) = oldConvertedReasonProps;
            Js.Unsafe.fun_call(
              thisJs##.setState,
              [|
                Js.Unsafe.inject((curTotalState, _) => {
                  let curReasonState = Obj.magic(curTotalState##.reasonState);
                  let oldSelf =
                    Obj.magic(
                      self##.self(
                        curReasonState,
                        Obj.magic(oldComponent.retainedProps),
                      ),
                    );
                  let nextReasonState =
                    Obj.magic(newComponent.willReceiveProps(oldSelf));
                  if (nextReasonState !== curTotalState) {
                    let nextTotalState: totalState(_) = [%js
                      {val reasonState = nextReasonState}
                    ];
                    let nextTotalState = Obj.magic(nextTotalState);
                    nextTotalState;
                  } else {
                    curTotalState;
                  };
                }),
                Js.Unsafe.inject(Js.null),
              |],
            );
          };
        };
        /***
         * shouldComponentUpdate is invoked any time props change, or new state
         * updates occur.
         *
         * The easiest way to think about this method, is:
         * - "Should component have its componentWillUpdate method called,
         * followed by its render() method?",
         *
         * Therefore the component.shouldUpdate becomes a hook solely to perform
         * performance optimizations through.
         */
        pub shouldComponentUpdate = (nextJsProps, nextState, _) => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let curJsProps = thisJs##.props;

          /***
           * Now, we inspect the next state that we are supposed to render, and ensure that
           * - We have enough information to answer "should update?"
           * - We have enough information to render() in the event that the answer is "true".
           *
           * If we can detect that props have changed update has occured,
           * we ask the component's shouldUpdate if it would like to update - defaulting to true.
           */
          let oldConvertedReasonProps =
            convertPropsIfTheyreFromJs(
              thisJs##.props,
              thisJs##.jsPropsToReason,
              debugName,
            );
          /* Avoid converting again the props that are just the same as curProps. */
          let newConvertedReasonProps =
            nextJsProps === curJsProps ?
              oldConvertedReasonProps :
              convertPropsIfTheyreFromJs(
                nextJsProps,
                thisJs##.jsPropsToReason,
                debugName,
              );
          let Element(oldComponent) = oldConvertedReasonProps;
          let Element(newComponent) = newConvertedReasonProps;
          let nextReasonState = nextState##.reasonState;
          let newSelf =
            self##.self(
              nextReasonState,
              Obj.magic(newComponent.retainedProps),
            );
          if (newComponent.shouldUpdate !== anyToTrue) {
            let curState = thisJs##.state;
            let curReasonState = curState##.reasonState;
            let curReasonState = Obj.magic(curReasonState);
            let newSelf = Obj.magic(newSelf);
            /* bypass self##.self call for small perf boost */
            let oldSelf =
              Obj.magic({
                ...newSelf,
                state: curReasonState,
                retainedProps: oldComponent.retainedProps,
              });
            newComponent.shouldUpdate({oldSelf, newSelf});
          } else {
            true;
          };
        };
        pub onUnmountMethod = subscription =>
          switch (Js.Opt.to_option(self##.subscriptions)) {
          | None => self##.subscriptions := Js.Opt.return([|subscription|])
          | Some(subs) => ignore(subs##.push(subscription))
          };
        pub handleMethod = callback => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          callbackPayload => {
            let curState = thisJs##.state;
            let curReasonState = curState##.reasonState;
            let convertedReasonProps =
              convertPropsIfTheyreFromJs(
                thisJs##.props,
                thisJs##.jsPropsToReason,
                debugName,
              );
            let Element(component) = convertedReasonProps;
            callback(
              callbackPayload,
              Obj.magic(
                self##.self(
                  curReasonState,
                  Obj.magic(component.retainedProps),
                ),
              ),
            );
          };
        };
        pub sendMethod = (action: 'action) => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let convertedReasonProps =
            convertPropsIfTheyreFromJs(
              thisJs##.props,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(component) = convertedReasonProps;
          if (component.reducer !== reducerDefault) {
            let sideEffects = ref(ignore);
            /* allow side-effects to be executed here */
            let partialStateApplication =
              component.reducer(Obj.magic(action));
            Js.Unsafe.fun_call(
              thisJs##.setState,
              [|
                Js.Unsafe.inject((curTotalState, _) => {
                  let curReasonState = curTotalState##.reasonState;
                  let reasonStateUpdate =
                    partialStateApplication(Obj.magic(curReasonState));
                  if (reasonStateUpdate === NoUpdate) {
                    magicNull;
                  } else {
                    let reasonStateUpdate = Obj.magic(reasonStateUpdate);
                    let nextTotalState =
                      switch (reasonStateUpdate) {
                      | NoUpdate => curTotalState
                      | Update(nextReasonState) =>
                        %js
                        {val reasonState = nextReasonState}
                      | SideEffects(performSideEffects) =>
                        sideEffects.contents = performSideEffects;
                        curTotalState;
                      | UpdateWithSideEffects(
                          nextReasonState,
                          performSideEffects,
                        ) =>
                        sideEffects.contents = performSideEffects;
                        %js
                        {val reasonState = nextReasonState};
                      };
                    if (nextTotalState !== curTotalState) {
                      nextTotalState;
                    } else {
                      magicNull;
                    };
                  };
                }),
                Js.Unsafe.inject(
                  Js.Opt.return(
                    self##.handleMethod(((), self) =>
                      sideEffects.contents(self)
                    ),
                  ),
                ),
              |],
            );
          };
        };
        /***
         * In order to ensure we always operate on freshest props / state, and to
         * support the API that "reduces" the next state along with the next
         * rendering, with full acccess to named argument props in the closure,
         * we always *pre* compute the render result.
         */
        pub render = () => {
          let thisJs:
            jsComponentThis(reasonState, element, retainedProps, action) =
            Js.Unsafe.js_expr("this");
          let convertedReasonProps =
            convertPropsIfTheyreFromJs(
              thisJs##.props,
              thisJs##.jsPropsToReason,
              debugName,
            );
          let Element(created) = Obj.magic(convertedReasonProps);
          let component = created;
          let curState = thisJs##.state;
          let curReasonState = Obj.magic(curState##.reasonState);
          let self =
            Obj.magic(
              self##.self(
                curReasonState,
                Obj.magic(component.retainedProps),
              ),
            );
          component.render(self);
        }
      }
    ],
  );

let basicComponent = debugName => {
  let componentTemplate = {
    reactClassInternal: createClass(debugName),
    debugName,
    /* Keep here as a way to prove that the API may be implemented soundly */
    handedOffState: {
      contents: None,
    },
    didMount: anyToUnit,
    willReceiveProps: willReceivePropsDefault,
    didUpdate: anyToUnit,
    willUnmount: anyToUnit,
    willUpdate: anyToUnit,
    /***
     * Called when component will certainly mount at some point - and may be
     * called on the sever for server side React rendering.
     */
    shouldUpdate: anyToTrue,
    render: renderDefault,
    initialState: initialStateDefault,
    reducer: reducerDefault,
    jsElementWrapped: None,
    retainedProps: (),
  };
  componentTemplate;
};

let statelessComponent =
    (debugName): component(stateless, noRetainedProps, actionless) =>
  basicComponent(debugName);