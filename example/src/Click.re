type action =
  | Clicked(int, int);

let reducer = (state, action) =>
  switch (action) {
  | Clicked(x, y) => [(x, y), ...state]
  };

[@react.component]
let make = () => {
  let (_state, dispatch) = React.useReducer(reducer, []);
  <div
    onClick={event => {
      dispatch @@
      ReactEvent.Mouse.(Clicked(event |> clientX, event |> clientY))
    }}>
    {"Hello" |> React.string}
  </div>;
};
