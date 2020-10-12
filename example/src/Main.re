let s = React.string;

type example = {
  path: string,
  title: string,
  element: React.element,
  code: React.element,
};

let firstExample = {
  path: "hello-world-ocaml",
  title: "Hello World OCaml",
  element: <HelloWorldOCaml />,
  code: <Code text=[%blob "HelloWorldOCaml.ml"] />,
};
let examples = [
  firstExample,
  {
    path: "hello-world-reason",
    title: "Hello World Reason",
    element: <HelloWorldReason />,
    code: <Code text=[%blob "HelloWorldReason.re"] />,
  },
  {
    path: "events",
    title: "Events",
    element: <Events />,
    code: <Code text=[%blob "Events.re"] />,
  },
  {
    path: "greeting",
    title: "GreetingReason",
    element: <GreetingReason />,
    code: <Code text=[%blob "GreetingReason.re"] />,
  },
  {
    path: "refs",
    title: "Refs",
    element: <Refs />,
    code: <Code text=[%blob "Refs.re"] />,
  },
  {
    path: "interfaces",
    title: "Interface files",
    element:
      <Interface
        key="inter"
        title="jsoo-react PPX can also be used in interface files.">
        React.null
      </Interface>,
    code: <Code text=[%blob "Interface.rei"] />,
  },
  {
    path: "bindings",
    title: "Bindings to JavaScript code",
    element:
      <p>
        {"Bindings can be written easily by using " |> s}
        <a href="https://github.com/LexiFi/gen_js_api" target="_blank">
          {"gen_js_api" |> s}
        </a>
        {"." |> s}
      </p>,
    code: <Code text=[%blob "Bindings.rei"] />,
  },
  {
    path: "ppxs",
    title: "PPXs (preprocessing extensions)",
    element:
      <>
        <p>
          {"You have seen the embedded code snippets in the examples. The one below is from the Main component of this page."
           |> s}
          <code> {"Interface.re" |> s} </code>
          {"." |> s}
        </p>
        <p>
          {"These snippets always stay in sync with the code itself. The strings from the files get captured at compile time via a "
           |> s}
          <a
            href="https://victor.darvariu.me/jekyll/update/2018/06/19/ppx-tutorial.html"
            target="_blank">
            {"ppx" |> s}
          </a>
          {" (preprocessor extension) that is called " |> s}
          <a href="https://github.com/johnwhitington/ppx_blob" target="_blank">
            {"ppx_blob" |> s}
          </a>
          {" by calling " |> s}
          <code> {"<Code text=[%blob \"SomeComponent.re\"] />" |> s} </code>
          {". Then, we just pass that string to a component " |> s}
          <code> {"Code" |> s} </code>
          {"." |> s}
        </p>
        <p>
          {"Here is the implementation of" |> s}
          <code> {"Code.re" |> s} </code>
          {":" |> s}
        </p>
      </>,
    code: <Code text=[%blob "Code.re"] />,
  },
];

[@react.component]
let make = () => {
  let url = ReactRouter.useUrl();

  <div className="flex-container">
    <div className="sidebar">
      <h2 className="title"> {"jsoo-react" |> s} </h2>
      <nav className="menu">
        <ul>
          {examples
           |> List.map(e => {
                <li key={e.path}>
                  <a
                    href={e.path}
                    onClick={event => {
                      ReactEvent.Mouse.preventDefault(event);
                      ReactRouter.push(e.path);
                    }}>
                    {e.title |> s}
                  </a>
                </li>
              })
           |> React.list}
        </ul>
      </nav>
    </div>
    <div className="content-wrapper">
      <div className="content">
        {let example =
           examples
           |> List.find_opt(e => {
                e.path
                == (List.nth_opt(url.path, 0) |> Option.value(~default=""))
              })
           |> Option.value(~default=firstExample);
         <div>
           <h2> {example.title |> s} </h2>
           <h4> {"Rendered component" |> s} </h4>
           {example.element}
           <h4> {"Code" |> s} </h4>
           {example.code}
         </div>}
      </div>
    </div>
  </div>;
};
