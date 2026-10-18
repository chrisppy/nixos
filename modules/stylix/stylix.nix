{ inputs, ... }:

let
  base24 = inputs.base24-themes.lib.base24;
  camden = inputs.base24-themes.themes.camden;

  base16Scheme = builtins.toFile "camden.yaml" (base24.toYaml camden);
in
{
  flake.modules.nixos.base = {
    imports = [ inputs.stylix.nixosModules.stylix ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      image = inputs.self + "/assets/wallpaper.jpg";
      inherit base16Scheme;
      polarity = "dark";
    };
  };
}
