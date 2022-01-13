open React.Dom_lite

let%component make () =
  Fragment.make
    [
      a
        [
          href "https://github.com/jihchi/jsoo-react-realworld-example-app";
          target "_blank";
        ]
        [
          i [ className "ion-social-github" ] []; React.string "Fork on GitHub";
        ];
      footer []
        [
          div [ className "container" ]
            [
              span
                [ className "attribution" ]
                [
                  React.string "An interactive learning project from ";
                  a [ href "https://thinkster.io" ] [ React.string "Thinkster" ];
                  React.string ". Code &amp; design licensed under MIT.";
                ];
            ];
        ];
    ]
