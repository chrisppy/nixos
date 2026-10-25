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
        };

        dugout = {
          enable = true;
        };

        lineup = {
          enable = true;
          position = "bottom";
          favorites = [
            "chromium"
            "freecad"
          ];
        };
      };
    };
}
