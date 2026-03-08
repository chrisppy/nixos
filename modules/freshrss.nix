{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.freshrss = {config, ...}: {
    sops.secrets = {
      freshrss-password.owner = config.services.freshrss.user;
      freshrss-db-password.owner = config.services.freshrss.user;
    };

    services.freshrss = {
      enable = true;
      api.enable = true;
      openFirewall = true;
      baseUrl = "http://${config.networking.hostName}.gaur-truck.ts.net";
      defaultUser = username;
      passwordFile = "/run/secrets/freshrss-password";
      database = {
        type = "pgsql";
        passFile = "/run/secrets/freshrss-db-password";
      };
    };

    services = {
      postgresql = {
        enable = true;
        ensureDatabases = ["freshrss"];
        ensureUsers = [
          {
            name = config.services.freshrss.user;
            ensureDBOwnership = true;
          }
        ];
      };
    };
  };
}
