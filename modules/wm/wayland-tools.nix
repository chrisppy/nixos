{ config, ... }:
{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      users.users.${config.flake.meta.owner.username}.packages = with pkgs; [
        brightnessctl
        grim
        slurp
        waypipe
        wev
        wl-clipboard
        wlr-randr
        wf-recorder
        xwayland-satellite
      ];
    };
}
