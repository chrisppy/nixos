{config, ...}: {
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      base
      bcachefs
      determinate
      freshrss
      zswap
    ];
  };
}
