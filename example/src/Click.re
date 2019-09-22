type action =
  | Clicked(int, int);

let reducer = (state, action) =>
  switch (action) {
  | Clicked(x, y) => [(x, y), ...state]
  };

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, []);
  <div
    style={ReactDOM.Style.make(~color="#ff5544", ~fontSize="68px", ())}
    onClick={event => {
      dispatch @@
      ReactEvent.Mouse.(Clicked(event |> clientX, event |> clientY))
    }}>
    {"Hello" |> React.string}
    {"Pos: "
     ++ String.concat(
          "\n",
          state
          |> List.map(((x, y)) =>
               string_of_int(x) ++ ", " ++ string_of_int(y)
             ),
        )
     |> React.string}
  </div>;
};
