{ config, ... }:
{
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      base
      bcachefs
      caddy
      determinate
      intel-arc
      uefi
      zfs
      zswap

      # Services
      audiobookshelf
      jellyfin
      mealie
      pressbox
    ];
  };
}
