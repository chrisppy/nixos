{ inputs, ... }: {
  flake.modules.homeManager.birdland =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.birdland.homeManagerModules.default ];
      programs.birdland = {
        enable = true;
        systemd.enable = true;
        theme.scheme = "birdland";
        font = {
          family = "Inter";
          package = pkgs.inter;
        };

        bullpen = {
          enable = true;
          position = "left";
          units = "imperial";
          weather = {
            latitude = 39.41;
            longitude = -77.29;
          };
          layout = {
            left = [ "workspaces" ];
            center = [ "title" ];
            right = [
              "tray"
              "weather"
              "cpu"
              "memory"
              "gpu"
              "temperature"
              "volume"
              "microphone"
              "network"
              "battery"
              "clock"
            ];
          };
        };

        dugout = {
          enable = true;
        };

        lineup = {
          enable = true;
          position = "right";
          favorites = [
            "chromium"
            "freecad"
          ];
        };
      };
    };
}
