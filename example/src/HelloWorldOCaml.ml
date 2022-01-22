let%component make () =
  React.Dom.Html.(
    Fragment.make
      [
        a
          [|
            href "https://github.com/jihchi/jsoo-react-realworld-example-app";
            target "_blank";
          |]
          [ i [|className "ion-social-github"|] []; text "Fork on GitHub" ];
        footer [||]
          [
            div
              [|className "container"|]
              [
                span
                  [|className "attribution"|]
                  [
                    text "An interactive learning project from ";
                    a [|href "https://thinkster.io"|] [ text "Thinkster" ];
                    text ". Code &amp; design licensed under MIT.";
                  ];
              ];
          ];
      ])
