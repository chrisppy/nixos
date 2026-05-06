{ config, ... }:
{
  configurations.nixos.smoky.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      bcachefs
      determinate
      greetd
      laptop
      niri
      plymouth
      uefi
      zswap
    ];
  };
}
