_: {
  flake.modules.nixos.base =
    {
      pkgs,
      ...
    }:
    {
      stylix.icons = {
        enable = true;
        package = pkgs.yaru-theme;
        dark = "Yaru-sage";
      };
    };
}
