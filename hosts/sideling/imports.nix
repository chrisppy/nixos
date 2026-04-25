{config, ...}: {
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      base
      bcachefs
      caddy
      determinate
      miniflux
      uefi
      zswap
    ];
  };
}
