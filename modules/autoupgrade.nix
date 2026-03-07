{config, ...}: {
  flake.modules.nixos.autoupgrade = {
    system.autoUpgrade = {
      enable = true;
      flake = "github:chrisppy/nixos#${config.networking.hostName}";
      operation = "switch";
      dates = "04:00";
      randomizedDelaySec = 1800;
      allowReboot = false;
    };
  };
}
