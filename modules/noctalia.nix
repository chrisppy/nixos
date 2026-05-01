_: {
  flake.modules.homeManager.noctalia =
    {
      config,
      inputs,
      lib,
      ...
    }:
    let
      launcher = "${lib.getExe config.programs.noctalia-shell.package} ipc call launcher toggle";
    in
    {
      imports = [ inputs.noctalia.homeModules.default ];
      wayland.windowManager = {
        hyprland.settings.bindd = [
          "$mod, space, Launch apps, exec, ${launcher} | xargs hyprctl dispatch exec"
        ];
        # niri.settings.binds."Mod+Space".spawn = [launcher];
      };
      programs = {
        noctalia-shell = {
          enable = true;
          systemd.enable = true;
          settings = {
            bar = {
              density = "default";
              position = "top";
              showCapsule = false;
              widgets = {
                left = [
                  {
                    id = "Launcher";
                    useDistroLogo = true;
                  }
                  {
                    hideUnoccupied = false;
                    id = "Workspace";
                    labelMode = "none";
                  }
                ];
                center = [
                  {
                    formatHorizontal = "HH:mm";
                    formatVertical = "HH mm";
                    id = "Clock";
                    useMonospacedFont = true;
                    usePrimaryColor = true;
                  }
                  {
                    id = "NotificationHistory";
                  }
                ];
                right = [
                  {
                    id = "Tray";
                  }
                  {
                    id = "Volume";
                  }
                  {
                    id = "Bluetooth";
                  }
                  {
                    id = "Network";
                  }
                  {
                    id = "Battery";
                  }
                ];
              };
            };
            general.radiusRatio = 0.2;
            location = {
              monthBeforeDay = true;
              name = "New Market, Maryland";
              useFahrenheit = true;
            };
            network.wifiEnabled = false;
            nightLight.enabled = true;
          };
        };
      };
    };
}
