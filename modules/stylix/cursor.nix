_: {
  flake.modules.nixos.base =
    {
      pkgs,
      ...
    }:
    {
      stylix.cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Amber";
        size = 24;
      };
    };
}
