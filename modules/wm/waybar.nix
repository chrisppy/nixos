_: {
  flake.modules.homeManager.waybar =
    { config, lib, ... }:

    {
      programs.waybar = {
        enable = true;
        systemd.enable = true;

        # --- Structural Configuration ---
        settings.mainBar = {
          layer = "top";
          position = "top";
          height = 32;

          modules-left = [
            "niri/workspaces"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "tray"
            "wireplumber"
            "network"
            "battery"
          ];

          "niri/workspaces" = {
            format = "{name}";
            all-outputs = true;
          };

          "clock" = {
            format = "{:%H:%M}";
            format-alt = "{:%m-%d-%Y}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "wireplumber" = {
            format = "{icon} {volume}%";
            format-muted = "󰝟";
            on-click = "${lib.getExe config.programs.kitty.package} --class wiremix-tui -e wiremix";
            format-icons = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            scroll-step = 5;
          };

          "network" = {
            format-ethernet = "󰈀 {ipaddr}";
            format-disconnected = "󰤮";
            tooltip-format = "{ifname} via {gwaddr}";
          };

          "battery" = {
            format = "{icon} {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
        };

      };
    };
}
