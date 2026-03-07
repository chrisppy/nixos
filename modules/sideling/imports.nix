{config, ...}: {
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      base
      bcachefs
      determinate
      zswap
    ];
  };
}
