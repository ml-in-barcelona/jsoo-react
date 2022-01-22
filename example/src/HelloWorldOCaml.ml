let%component make () =
  React.Dom.Html.(
    fragment
      [
        a
          [|
            href "https://github.com/jihchi/jsoo-react-realworld-example-app";
            target "_blank";
          |]
          [ i [|className "ion-social-github"|] []; string "Fork on GitHub" ];
        footer [||]
          [
            div
              [|className "container"|]
              [
                span
                  [|className "attribution"|]
                  [
                    string "An interactive learning project from ";
                    a [|href "https://thinkster.io"|] [ string "Thinkster" ];
                    string ". Code &amp; design licensed under MIT.";
                  ];
              ];
          ];
      ])
