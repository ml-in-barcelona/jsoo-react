include [%js:
          type window;
          [@js.global "window"]
          let get: option(window);
          [@js.call]
          let alert: (window, string) => unit;
          [@js.get]
          let value: Ojs.t => string
        ];
