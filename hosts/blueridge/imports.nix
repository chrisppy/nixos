{ config, ... }:
{
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      caddy
      design
      determinate
      greetd
      intel-arc
      libation
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
