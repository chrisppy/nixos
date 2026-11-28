{ config, ... }:
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      programs.chromium.enable = true; # system policies
      users.users.${config.flake.meta.owner.username}.packages = [ pkgs.chromium ];
    };
}
