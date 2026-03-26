_: {
  flake.modules.homeManager.noctalia = {inputs, ...}: {
    imports = [inputs.noctalia.homeModules.default];
    programs.noctalia-shell = {
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
}
