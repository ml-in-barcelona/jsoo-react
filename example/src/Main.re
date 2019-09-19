let s = React.string;

[@deriving (enum, show)]
type example =
  | HelloWorldReason
  | HelloWorldOCaml;

[@react.component]
let make = () => {
  let _url = ReactRouter.useUrl();
  let _a = example_to_enum(HelloWorldReason);
  let _b = show_example(HelloWorldReason);

  <div className="flex-container">
    <div className="sidebar">
      <h1 className="title"> {"jsoo-react" |> s} </h1>
      <nav className="menu">
        <ul>
          <li>
            <a
              href="#"
              onClick={event => {
                ReactEvent.Mouse.preventDefault(event);
                ReactRouter.push("home");
              }}>
              {"Home" |> s}
            </a>
          </li>
          <li>
            <a
              href="#"
              onClick={event => {
                ReactEvent.Mouse.preventDefault(event);
                ReactRouter.push("services");
              }}>
              {"About" |> s}
            </a>
          </li>
          <li> <a href="#"> {"Services" |> s} </a> </li>
          <li> <a href="#"> {"Pricing" |> s} </a> </li>
          <li> <a href="#"> {"Contact" |> s} </a> </li>
          <li> <a href="#"> {"Blog" |> s} </a> </li>
        </ul>
      </nav>
    </div>
    <div className="content-wrapper">
      <div className="content">
        <h1 className="hello"> {"OCaml component" |> s} </h1>
        <h1> {"Reason component" |> s} </h1>
        <h1> {"Refs" |> s} </h1>
        <Refs />
        <h1 key="h1"> {"Interface files" |> s} </h1>
        <Interface
          key="inter" title="Hi from a component with an interface file">
          React.null
        </Interface>
        <h1 key="h1"> {"Integration with ppxs" |> s} </h1>
        <p>
          {"The following code is being read from one of the files in the project: "
           |> s}
          <code> {"Interface.re" |> s} </code>
          {"." |> s}
        </p>
        <p>
          {"It gets rendered via " |> s}
          <a href="https://github.com/johnwhitington/ppx_blob" target="_blank">
            {"ppx_blob" |> s}
          </a>
          {" by calling " |> s}
          <code> {"<Code text=[%blob \"Interface.re\"] />" |> s} </code>
          {":" |> s}
        </p>
        <Code text=[%blob "Interface.re"] />
      </div>
    </div>
  </div>;
};
