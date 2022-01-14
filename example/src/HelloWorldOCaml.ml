open React.Dom_lite

let%component make () =
  Fragment.make
    Html.
      [
        a
          Props.
            [|
              href "https://github.com/jihchi/jsoo-react-realworld-example-app";
              target "_blank";
            |]
          [
            i Props.[|className "ion-social-github"|] []; text "Fork on GitHub";
          ];
        footer [||]
          [
            div
              Props.[|className "container"|]
              [
                span
                  Props.[|className "attribution"|]
                  [
                    text "An interactive learning project from ";
                    a Props.[|href "https://thinkster.io"|] [ text "Thinkster" ];
                    text ". Code &amp; design licensed under MIT.";
                  ];
              ];
          ];
      ]
