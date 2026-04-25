{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.miniflux = {
    config,
    pkgs,
    ...
  }: let
    # domain = config.networking.fqdn;
    domain = "rss.chrisppy.me";
    port = 7070;
    ip = "127.0.0.1:${toString port}";
  in {
    sops = {
      secrets = {
        rss-passwd = {};
        cloudflare-api-token = {};
      };
      templates."miniflux-db.env".content = ''
        ADMIN_USERNAME=${username}
        ADMIN_PASSWORD=${config.sops.placeholder.rss-passwd}
      '';
    };

    services = {
      caddy.virtualHosts."${domain}".extraConfig = ''
        tls {
          dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          resolvers 1.1.1.1
        }
        reverse_proxy ${ip} {
      '';
      miniflux = {
        enable = true;
        createDatabaseLocally = true;
        adminCredentialsFile = config.sops.templates."miniflux-db.env".path;
        config = {
          LISTEN_ADDR = "${ip}";
          BASE_URL = "https://${domain}";
          RUN_MIGRATIONS = true;
          POLLING_FREQUENCY = 15;
          WORKER_POOL_SIZE = 5;
        };
      };
      postgresql.package = pkgs.postgresql_16;
    };

    systemd.services.caddy.serviceConfig.EnvironmentFile = [
      config.sops.secrets.cloudflare-api-token.path
    ];
  };
}
