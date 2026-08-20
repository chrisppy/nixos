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
      zswap
      zwave

      home-assistant
      podman
    ];
  };
}
