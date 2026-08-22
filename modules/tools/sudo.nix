{ config, ... }:
{
  flake.modules.nixos.base = {
    security = {
      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
      };
      sudo.enable = false;
    };
    users.users.${config.flake.meta.owner.username}.extraGroups = [
      "wheel"
      "systemd-journal"
    ];
  };
}
