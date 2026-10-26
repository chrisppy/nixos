{ inputs, ... }:

let
  base24 = inputs.base24-themes.lib.base24;
  themeName = "birdland";
  theme = base24.themes.${themeName};
in
{
  flake.modules.nixos.base = {
    imports = [ inputs.stylix.nixosModules.stylix ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      image = inputs.self + "/assets/wallpaper.jpg";
      base16Scheme = builtins.toFile "${themeName}.yaml" (base24.toYaml theme);
      polarity = (base24.getMeta theme).variant;
    };
  };
}
