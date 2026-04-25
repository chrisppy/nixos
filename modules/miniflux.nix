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
    domain = "${config.networking.hostName}.gaur-truck.ts.net";
    port = 7070;
    ip = "127.0.0.1:${toString port}";
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
        handle_path /rss* {
          reverse_proxy ${ip} {
            header_up X-Forwarded-Prefix /rss
          }
        }
        handle {
          respond "OK"
        }
      '';
      miniflux = {
        enable = true;
        createDatabaseLocally = true;
        adminCredentialsFile = config.sops.templates."miniflux-db.env".path;
        config = {
          LISTEN_ADDR = "${ip}";
          # BASE_URL = "http://${domain}:${toString port}";
          BASE_URL = "https://${domain}/rss";
          RUN_MIGRATIONS = true;
          POLLING_FREQUENCY = 15;
          WORKER_POOL_SIZE = 5;
        };
      };
      postgresql.package = pkgs.postgresql_16;
    };
  };
}
