_: {
  flake.modules.homeManager.niri = {lib, ...}: let
    left = "Left";
    down = "Down";
    up = "Up";
    right = "Right";
  in {
    programs.niri.settings.binds =
      {
        "Mod+Escape".action.close-window = [];

        "Mod+${left}".action.focus-column-left = [];
        "Mod+${right}".action.focus-column-right = [];
        "Mod+${down}".action.switch-preset-column-width = [];
        "Mod+${up}".action.maximize-column = [];

        "Mod+Shift+${left}".action.move-column-left = [];
        "Mod+Shift+${right}".action.move-column-right = [];
        "Mod+Shift+${down}".action.move-window-down = [];
        "Mod+Shift+${up}".action.move-window-up = [];
      }
      // (
        lib.range 1 9
        |> map (
          ws: let
            s = toString ws;
          in {
            "Mod+${s}".action.focus-workspace = ws;
            "Mod+Shift+${s}".action.move-column-to-workspace = ws;
          }
        )
        |> lib.mergeAttrsList
      );
  };
}
