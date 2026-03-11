{config, ...}: {
  configurations.nixos.blueridge.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      bcachefs
      determinate
      media
      zswap
      zwave
    ];
  };
}
