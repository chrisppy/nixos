{ inputs, ... }:

let
  theme = inputs.base24-themes.themes.birdland;
in
{
  flake.modules.nixos.base = {
    imports = [ inputs.stylix.nixosModules.stylix ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      image = inputs.self + "/assets/wallpaper.jpg";
      base16Scheme = theme;
      polarity = theme.variant;
    };
  };
}
