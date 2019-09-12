[@react.component]
let make = (~title, ~children) => {
  <div> <span> {React.string(title)} </span> children </div>;
};
