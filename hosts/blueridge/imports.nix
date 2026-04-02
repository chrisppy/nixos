{config, ...}: {
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      cad
      determinate
      greetd
      hyprland
      media
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
