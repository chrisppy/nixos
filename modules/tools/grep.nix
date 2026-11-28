{ config, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      users.users.${config.flake.meta.owner.username}.packages = with pkgs; [
        ripgrep
        ripgrep-all
      ];
      environment.shellAliases.grep = "rg";
    };
}
