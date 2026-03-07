_: {
  flake.modules.nixos.autoupgrade = {
    system.autoUpgrade = {
      enable = true;
      flake = "github:chrisppy/nixos#sideling";
      operation = "switch";
      dates = "04:00";
      randomizedDelaySecs = 1800;
      allowReboot = false;
    };
  };
}
