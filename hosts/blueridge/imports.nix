{ config, ... }:
{
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      cad
      caddy
      determinate
      greetd
      inkscape
      media
      niri
      plymouth
      protonmail
      uefi
      zfs
      zswap
      zwave

      audiobookshelf
      home-assistant
      jellyfin
      podman
    ];
  };
}
