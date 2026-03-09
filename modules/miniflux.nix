{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.miniflux = {config, pkgs, ...}: let
    domain = "rss.${config.networking.fqdn}";
  in {
    sops = {
      secrets.rss-passwd = {};
      templates."miniflux-db.env" = {
        content = ''
          ADMIN_USERNAME=${username}
          ADMIN_PASSWORD=${config.sops.placeholder.rss-passwd}
        '';
      };
    };

    services.miniflux = {
      enable = true;
      createDatabaseLocally = true;
      adminCredentialsFile = config.sops.templates."miniflux-db.env".path;
      config = {
        LISTEM_ADDR = "127.0.0.1:8080";
        BASE_URL = "http://${domain}";
        RUN_MIGRATIONS = true;
        POLLING_FREQUENCY = "15";
        WORKER_POOL_SIZE = "5";
      };
    };

    services = {
      postgresql.package = pkgs.postgresql_16;

      caddy = {
        enable = true;
        virtualHosts."http://${domain}".extraConfig = "reverse_proxy 127.0.0.1:8080";
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 ];
  };
}
