{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.miniflux = {
    config,
    pkgs,
    ...
  }: let
    domain = config.networking.fqdn;
    port = 7070;
  in {
    sops = {
      secrets.rss-passwd = {};
      templates."miniflux-db.env".content = ''
        ADMIN_USERNAME=${username}
        ADMIN_PASSWORD=${config.sops.placeholder.rss-passwd}
      '';
    };

    services.miniflux = {
      enable = true;
      createDatabaseLocally = true;
      adminCredentialsFile = config.sops.templates."miniflux-db.env".path;
      config = {
        LISTEN_ADDR = "0.0.0.0:${toString port}";
        BASE_URL = "http://${domain}:${toString port}";
        RUN_MIGRATIONS = true;
        POLLING_FREQUENCY = 15;
        WORKER_POOL_SIZE = 5;
      };
    };

    services.postgresql.package = pkgs.postgresql_16;

    networking.firewall.allowedTCPPorts = [port];
  };
}
