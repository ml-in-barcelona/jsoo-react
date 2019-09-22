type coords = {
  x: int,
  y: int,
};

module Title = {
  [@react.component]
  let make = (~children) => {
    <h4 style={ReactDOM.Style.make(~margin="15px 0 0", ())}> children </h4>;
  };
};

[@react.component]
let make = () => {
  let (coords, setCoords) = React.useState(() => {x: 0, y: 0});
  <div>
    <Title> {"mouse movement via \"onMouseMove\"" |> React.string} </Title>
    <div>
      <img
        src="https://cdn.glitch.com/ed95e263-69d5-4c3b-aed2-d85713f4aef9%2Fdoggo.jpeg?v=1563384185147"
        onMouseMove={event => {
          let (x, y) = ReactEvent.Mouse.(screenX(event), screenY(event));
          setCoords(_ => {{x, y}});
        }}
      />
      <div>
        {string_of_int(coords.x)
         ++ "px / "
         ++ string_of_int(coords.y)
         ++ "px"
         |> React.string}
      </div>
    </div>
  </div>;
  // </form>
  //   <button type_="submit"> {"submit dis"|> React.string} </button>
  //   <input value={this.state.inputText} />
  // <form onSubmit={this.handleSubmit}>
  // <Title> {"form submission via \"onSubmit\"" |> React.string} </Title>
  // <input onChange={this.handleInput} value={this.state.inputText} />
  // <Title> {"text input via \"onChange\"" |> React.string} </Title>
};
