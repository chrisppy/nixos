{ config, ... }:
{
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      audiobookshelf
      autoupgrade
      base
      bcachefs
      caddy
      determinate
      jellyfin
      mealie
      miniflux
      navidrome
      uefi
      zfs
      zswap
    ];
  };
}
