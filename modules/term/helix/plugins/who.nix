_: {
  flake.modules.homeManager.base =
    {
      config,
      ...
    }:
    let
      colors = config.lib.stylix.colors;
    in
    {
      programs.nhx.plugins."who-unstable" = {
        # enable = true;
        config = {
          color = colors.base0C;
        };
      };
    };
}
