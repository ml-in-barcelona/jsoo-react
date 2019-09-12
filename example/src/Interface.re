let s = React.string;

[@react.component]
let make = (~title, ~children) => {
  <div>
    <span> {title |> s} </span>
    children
    <br />
    <br />
    <blockquote>
      <p> {"Keep it secret. Keep it safe." |> s} </p>
      <cite> {"Gandalf the Gray" |> s} </cite>
    </blockquote>
  </div>;
};
