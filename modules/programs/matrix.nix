{ config, ... }:
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      users.users.${config.flake.meta.owner.username}.packages = [ pkgs.element-desktop ];
    };
}
