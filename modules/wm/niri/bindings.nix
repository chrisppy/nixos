_: {
  flake.modules.nixos.niri =
    { config, lib, ... }:
    let
      left = "Left";
      down = "Down";
      up = "Up";
      right = "Right";
      launcher = "birdland-dugout";
      term = lib.getExe config.wrappers.kitty.package;
    in
    {
      wrappers.niri.module.settings.binds = {
        "Mod+Escape".close-window = _: { };
        "Mod+Ctrl+Escape".quit = _: { };
        "Mod+Shift+Slash".show-hotkey-overlay = _: { };
        "Mod+Tab".toggle-overview = _: { };

        "Mod+${left}".focus-column-left = _: { };
        "Mod+${right}".focus-column-right = _: { };
        "Mod+${down}".focus-workspace-down = _: { };
        "Mod+${up}".focus-workspace-up = _: { };

        "Mod+Alt+${down}".move-window-down = _: { };
        "Mod+Alt+${up}".move-window-up = _: { };

        "Mod+Shift+${left}".move-column-left = _: { };
        "Mod+Shift+${right}".move-column-right = _: { };
        "Mod+Shift+${down}".move-column-to-workspace-down = _: { };
        "Mod+Shift+${up}".move-column-to-workspace-up = _: { };

        "Mod+Ctrl+${left}".consume-or-expel-window-left = _: { };
        "Mod+Ctrl+${right}".consume-or-expel-window-right = _: { };
        "Mod+Ctrl+${down}".switch-preset-column-width = _: { };
        "Mod+Ctrl+${up}".maximize-column = _: { };

        "Mod+Shift+Space".switch-focus-between-floating-and-tiling = _: { };
        "Mod+Alt+Space".toggle-window-floating = _: { };

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

        "Print".screenshot = _: { };
        "Shift+Print".screenshot-window = _: { };
        "Ctrl+Print".screenshot-screen = _: { };

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
