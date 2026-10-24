{ inputs, ... }:

let
  base24 = inputs.base24-themes.lib.base24;
  birdland = inputs.base24-themes.themes.birdland;

  base16Scheme = builtins.toFile "birdland.yaml" (base24.toYaml birdland);
in
{
  flake.modules.nixos.base = {
    imports = [ inputs.stylix.nixosModules.stylix ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      image = inputs.self + "/assets/wallpaper.jpg";
      inherit base16Scheme;
      polarity = birdland.variant;
    };
  };
}
