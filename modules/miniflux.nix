{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.miniflux = {
    config,
    pkgs,
    ...
  }: let
    # domain = config.networking.fqdn;
    # domain = "rss.chrisppy.me";
    domain = "rss.sideling.gaur-truck.ts.net";
    port = 7070;
  in {
    sops = {
      secrets.rss-passwd = {};
      templates."miniflux-db.env".content = ''
        ADMIN_USERNAME=${username}
        ADMIN_PASSWORD=${config.sops.placeholder.rss-passwd}
      '';
    };

    services = {
      caddy.virtualHosts."${domain}".extraConfig = ''
        reverse_proxy 127.0.0.1:${port}
      '';
      miniflux = {
        enable = true;
        createDatabaseLocally = true;
        adminCredentialsFile = config.sops.templates."miniflux-db.env".path;
        config = {
          LISTEN_ADDR = "127.0.0.1:${toString port}";
          # BASE_URL = "http://${domain}:${toString port}";
          BASE_URL = "https://${domain}";
          RUN_MIGRATIONS = true;
          POLLING_FREQUENCY = 15;
          WORKER_POOL_SIZE = 5;
        };
      };
      postgresql.package = pkgs.postgresql_16;
    };

    networking.firewall.allowedTCPPorts = [port];
  };
}
