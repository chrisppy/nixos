{ inputs, ... }: {
  flake.modules = {
    nixos.greetd =
      { pkgs, ... }:
      {
        imports = [ inputs.birdland.nixosModules.default ];

        programs.birdland.gate = {
          enable = true;
          wallpaper = inputs.self + "/assets";
          theme.scheme = "birdland";
          font = {
            family = "Inter";
            package = pkgs.inter;
          };
        };
      };
    homeManager.birdland =
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
            position = "top";
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

          dugout.enable = true;

          lineup = {
            enable = true;
            position = "bottom";
            favorites = [
              "chromium"
              "freecad"
            ];
          };

          jumbotron = {
            enable = true;
            position = "top";
          };

          outfield = {
            enable = true;
            wallpaper = inputs.self + "/assets";
            interval = 30;
            shuffle = true;
          };

          tarp.enable = true;
        };
      };
  };
}
