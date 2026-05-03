{ config, ... }:
{
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      cad
      caddy
      determinate
      greetd
      hyprland
      inkscape
      media
      plymouth
      uefi
      zfs
      zswap
      zwave

      audiobookshelf
      home-assistant
      jellyfin
      navidrome
      podman
    ];
  };
}
