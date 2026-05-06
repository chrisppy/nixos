_: {
  flake.modules.homeManager.fuzzel =
    {
      config,
      lib,
      ...
    }:
    {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            # Stylix will fill in your monospace font automatically
            terminal = "${lib.getExe config.programs.kitty.package}";
            layer = "overlay";
            width = 35;
            horizontal-pad = 25;
            vertical-pad = 20;
          };
          border = {
            # Stylix usually sets the border color, but we can nudge the radius
            width = 2;
            radius = 10; # Replicating your previous radiusRatio
          };
        };
      };
    };
}
