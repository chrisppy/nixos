{ config, ... }:
{
  configurations.nixos.smoky.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      bcachefs
      greetd
      laptop
      niri
      plymouth
      uefi
      zswap
    ];
  };
}
