_: {
  flake.modules.nixos.base =
    {
      config,
      ...
    }:
    let
      colors = config.theme.colors;
    in
    {
      nhx.programs.nhx.plugins."who-unstable" = {
        # enable = true;
        config = {
          color = colors.base0C;
        };
      };
    };
}
