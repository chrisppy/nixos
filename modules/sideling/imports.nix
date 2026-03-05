{config, ...}: {
  configurations.nixos.sideling.module = {
    imports = with config.flake.modules.nixos; [
      base
      bcachefs
    ];
  };
}
