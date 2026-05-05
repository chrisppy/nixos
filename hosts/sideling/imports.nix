{ config, ... }:
{
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      base
      bcachefs
      caddy
      determinate
      mealie
      miniflux
      uefi
      zswap
    ];
  };
}
