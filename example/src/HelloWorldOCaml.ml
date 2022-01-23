open React.Dom.Dsl
open Html

let%component make () =
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
    ]

let web_component =
  (* Partial example from https://github.com/seattletimes/component-leaflet-map *)
  h "leaflet-map"
    Prop.[|string "lat" "47"; string "lng" "-122"; int "zoom" 5|]
    [
      h "tile-layer" Prop.[|string "layer" "stamen-toner"|] [];
      h "map-marker"
        Prop.[|string "lat" "23"; string "lng" "-80"; string "id" "findMe"|]
        [ string "Popup text!" ];
      h "geo-json"
        Prop.[|string "src" "url.geojson"|]
        [
          h "geo-data" [||] [ string "OR GEOJSON DATA GOES HERE" ];
          h "geo-palette"
            Prop.[|string "property" "FEATURE_PROPERTY"|]
            [
              h "color-mapping" Prop.[|int "max" 128; string "color" "red"|] [];
              h "color-mapping"
                Prop.[|int "min" 129; int "max" 255; string "color" "blue"|]
                [];
            ];
        ];
    ]
