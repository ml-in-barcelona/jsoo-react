[@react.component]
let make = (~title, ~children) => {
  <div>
    <span> {React.string(title)} </span>
    children
    <br/>
    <br/>
    <blockquote>
      <p> {"Keep it secret. Keep it safe." |> React.string} </p>
      <cite> {"Gandalf the Gray" |> React.string} </cite>
    </blockquote>
  </div>;
};
