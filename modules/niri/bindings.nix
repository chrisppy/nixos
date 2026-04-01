_: {
  flake.modules.homeManager.niri = {lib, ...}: let
    left = "Left";
    down = "Down";
    up = "Up";
    right = "Right";
  in {
    wayland.windowManager.niri.settings.binds =
      {
        "Mod+Escape".close-window = {};

        "Mod+${left}".focus-column-left = {};
        "Mod+${right}".focus-column-right = {};
        "Mod+${down}".switch-preset-column-width = {};
        "Mod+${up}".maximize-column = {};

        "Mod+Shift+${left}".move-column-left = {};
        "Mod+Shift+${right}".move-column-right = {};
        "Mod+Shift+${down}".move-window-down = {};
        "Mod+Shift+${up}".move-window-up = {};
      }
      // (
        lib.range 1 9
        |> map (
          ws: let
            s = toString ws;
          in {
            "Mod+${s}".focus-workspace = ws;
            "Mod+Shift+${s}".move-column-to-workspace = ws;
          }
        )
        |> lib.mergeAttrsList
      );
  };
}
