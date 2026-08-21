{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = [ inputs.stylix.nixosModules.stylix ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      image = inputs.self + "/assets/wallpaper.jpg";
      base16Scheme = inputs.self + "/themes/camden.yaml";
      polarity = "dark";
    };
  };
}
