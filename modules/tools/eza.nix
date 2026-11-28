{ config, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      users.users.${config.flake.meta.owner.username}.packages = [ pkgs.eza ];
    };
}
