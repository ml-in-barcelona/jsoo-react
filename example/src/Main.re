let s = React.string;

type example = {
  path: string,
  title: string,
  element: React.element,
  code: React.element,
};

let firstExample = {
  path: "click",
  title: "Click",
  element: <Click />,
  code: <Code text=[%blob "Click.re"] />,
};
let examples = [
  firstExample,
  {
    path: "greeting",
    title: "GreetingReason",
    element: <GreetingReason />,
    code: <Code text=[%blob "GreetingReason.re"] />,
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
           {example.element}
           <h3> {"Code" |> s} </h3>
           {example.code}
         </div>}
      </div>
    </div>
  </div>;
  // <h1 className="hello"> {"OCaml component" |> s} </h1>
  // <h1> {"Reason component" |> s} </h1>
  // <h1> {"Refs" |> s} </h1>
  // <Refs />
  // <h1 key="h1"> {"Interface files" |> s} </h1>
  // <Interface
  //   key="inter" title="Hi from a component with an interface file">
  //   React.null
  // </Interface>
  // <h1 key="h1"> {"Integration with ppxs" |> s} </h1>
  // <p>
  //   {"The following code is being read from one of the files in the project: "
  //    |> s}
  //   <code> {"Interface.re" |> s} </code>
  //   {"." |> s}
  // </p>
  // <p>
  //   {"It gets rendered via " |> s}
  //   <a href="https://github.com/johnwhitington/ppx_blob" target="_blank">
  //     {"ppx_blob" |> s}
  //   </a>
  //   {" by calling " |> s}
  //   <code> {"<Code text=[%blob \"Interface.re\"] />" |> s} </code>
  //   {":" |> s}
  // </p>
  // <Code text=[%blob "Interface.re"] />
};
