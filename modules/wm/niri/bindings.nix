_: {
  flake.modules.homeManager.niri =
    { config, lib, ... }:
    let
      left = "Left";
      down = "Down";
      up = "Up";
      right = "Right";
      launcher = "birdland-dugout";
      term = lib.getExe config.programs.kitty.package;
    in
    {
      wayland.windowManager.niri.settings.binds = {
        "Mod+Escape".close-window = [ ];
        "Mod+Ctrl+Escape".quit = [ ];
        "Mod+Shift+Slash".show-hotkey-overlay = [ ];
        "Mod+Tab".toggle-overview = [ ];

        "Mod+${left}".focus-column-left = [ ];
        "Mod+${right}".focus-column-right = [ ];
        "Mod+${down}".focus-workspace-down = [ ];
        "Mod+${up}".focus-workspace-up = [ ];

        "Mod+Alt+${down}".move-window-down = [ ];
        "Mod+Alt+${up}".move-window-up = [ ];

        "Mod+Shift+${left}".move-column-left = [ ];
        "Mod+Shift+${right}".move-column-right = [ ];
        "Mod+Shift+${down}".move-column-to-workspace-down = [ ];
        "Mod+Shift+${up}".move-column-to-workspace-up = [ ];

        "Mod+Ctrl+${left}".consume-or-expel-window-left = [ ];
        "Mod+Ctrl+${right}".consume-or-expel-window-right = [ ];
        "Mod+Ctrl+${down}".switch-preset-column-width = [ ];
        "Mod+Ctrl+${up}".maximize-column = [ ];

        "Mod+Shift+Space".switch-focus-between-floating-and-tiling = [ ];
        "Mod+Alt+Space".toggle-window-floating = [ ];

        "Mod+Space".spawn = [
          launcher
          "ipc"
          "call"
          "dugout"
          "toggle"
        ];
        "Mod+Return".spawn = [ term ];

        "Mod+Ctrl+l".spawn = [
          "birdland-tarp"
          "ipc"
          "call"
          "tarp"
          "lock"
        ];

        "Print".screenshot = [ ];
        "Shift+Print".screenshot-window = [ ];
        "Ctrl+Print".screenshot-screen = [ ];

        "XF86AudioRaiseVolume".spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.05+"
          "-l"
          "1.0"
        ];
        "XF86AudioLowerVolume".spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.05-"
        ];
        "XF86AudioMute".spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        "XF86AudioMicMute".spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
        "XF86MonBrightnessUp".spawn = [
          "brightnessctl"
          "set"
          "5%+"
        ];
        "XF86MonBrightnessDown".spawn = [
          "brightnessctl"
          "set"
          "5%-"
        ];
      }
      // (
        lib.range 1 9
        |> map (
          ws:
          let
            s = toString ws;
          in
          {
            "Mod+${s}".focus-workspace = ws;
            "Mod+Shift+${s}".move-column-to-workspace = ws;
          }
        )
        |> lib.mergeAttrsList
      );
    };
}
