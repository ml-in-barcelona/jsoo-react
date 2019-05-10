/* This is your familiar handleClick from ReactJS. This mandatorily takes the payload,
   then the `self` record, which contains state (none here), `handle`, `send`
   and other utilities */
let handleClick = _event => print_endline("clicked!");

/* Which desugars to
   `let make = ({name}) => ...` */
[@react.component]
let make = (~name, ()) => {
  /*React.useEffect(() => {
    print_endline("Hey!");
    None;
  }); 
    ReactDOMRe.react##.createElement(
      "div",
      ()
    );*/
  <div onClick=handleClick></div>;
};
