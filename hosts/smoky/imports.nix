{config, ...}: {
  configurations.nixos.smoky.module = {
    imports = with config.flake.modules.nixos; [
      autoupgrade
      bcachefs
      determinate
      hyprland
      laptop
      uefi
      zswap
    ];
  };
}
