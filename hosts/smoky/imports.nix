{config, ...}: {
  configurations.nixos.smoky.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      base
      bcachefs
      determinate
      grub
      niri
      zswap
    ];
  };
}
