{ config, ... }:
{
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      caddy
      design
      greetd
      intel-arc
      libation
      media
      niri
      ntfy-alerts
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
