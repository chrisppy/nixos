_: {
  flake.modules.nixos.zwave = {config, ...}: {
    sops = {
      secrets = {
        zwave-s0-legacy = {};
        zwave-s2-unauthenticated = {};
        zwave-s2-authenticated = {};
        zwave-s2-access-control = {};
      };
      templates."zwave-js-keys.json" = {
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
      secretsConfigFile = config.sops.templates."zwave-js-keys.json".path;
    };
  };
}
