_: {
  flake.modules.nixos.autoupgrade = {config, ...}: {
    system.autoUpgrade = {
      enable = true;
      flake = "github:chrisppy/nixos#${config.networking.hostName}";
      operation = "switch";
      dates = "04:00";
      randomizedDelaySec = "30min";
      allowReboot = false;
    };
  };
}
