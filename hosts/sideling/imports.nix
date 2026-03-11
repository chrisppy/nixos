{config, ...}: {
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      bcachefs
      determinate
      miniflux
      zswap
    ];
  };
}
