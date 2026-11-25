_: {
  flake.modules.nixos.autoupgrade =
    { config, ... }:
    {
      system.autoUpgrade = {
        enable = true;
        # tested-<host> is only moved forward by CI after this host builds
        flake = "github:chrisppy/nixos/tested-${config.networking.hostName}#${config.networking.hostName}";
        operation = "switch";
        dates = "07:00";
        randomizedDelaySec = "30min";
        allowReboot = false;
        flags = [ "--refresh" ];
      };
    };
}
