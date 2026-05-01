{ config, ... }:
{
  configurations.nixos.smoky.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      bcachefs
      determinate
      greetd
      hyprland
      laptop
      plymouth
      uefi
      zswap
    ];
  };
}
