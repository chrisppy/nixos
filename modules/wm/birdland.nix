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
            clock.format = "HH:mm";
            date.format = "yyyy-MM-dd";
            weather = {
              latitude = 39.41;
              longitude = -77.29;
            };
            layout = {
              left = [
                "workspaces"
                "title"
              ];
              center = [
                "date"
                "clock"
                "weather"
              ];
              right = [
                "tray"
                [
                  "volume"
                  "microphone"
                ]
                [
                  "network"
                  "battery"
                  "temperature"
                  "cpu"
                  "memory"
                  "gpu"
                ]
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

          announcer = {
            enable = true;
            position = "top-right";
          };

          tarp.enable = true;
        };
      };
  };
}
