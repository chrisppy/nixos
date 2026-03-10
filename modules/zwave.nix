_: {
  flake.modules.nixos.zwave = {config, ...}: let
    cfgFile = "zwave-js-keys.json";
  in {
    sops = {
      secrets = {
        zwave-s0-legacy = {};
        zwave-s2-unauthenticated = {};
        zwave-s2-authenticated = {};
        zwave-s2-access-control = {};
      };
      templates.${cfgFile} = {
        mode = "0444";
        content = ''
          {
            "securityKeys": {
              "S0_Legacy": "${config.sops.placeholder.zwave-s0-legacy}",
              "S2_Unauthenticated": "${config.sops.placeholder.zwave-s2-unauthenticated}",
              "S2_Authenticated": "${config.sops.placeholder.zwave-s2-authenticated}",
              "S2_AccessControl": "${config.sops.placeholder.zwave-s2-access-control}"
            }
          }
        '';
      };
    };

    services.zwave-js = {
      enable = true;
      port = 3000;
      secretsConfigFile = config.sops.templates.${cfgFile}.path;
      serialPort = "/dev/serial/by-id/usb-Nabu_Casa_ZWA-2_80B54EE5E558-if00";
    };
  };
}
