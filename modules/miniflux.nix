{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.miniflux = {
    config,
    pkgs,
    ...
  }: {
    sops = {
      secrets.rss-passwd = {};
      templates."miniflux-db.env".content = ''
        ADMIN_USERNAME=${username}
        ADMIN_PASSWORD=${config.sops.placeholder.rss-passwd}
      '';
    };

    services = {
      miniflux = {
        enable = true;
        createDatabaseLocally = true;
        adminCredentialsFile = config.sops.templates."miniflux-db.env".path;
        config = {
          LISTEN_ADDR = "127.0.0.1:7070";
          BASE_URL = "https://feeds.chrisppy.me";
          RUN_MIGRATIONS = true;
          POLLING_FREQUENCY = 15;
          WORKER_POOL_SIZE = 5;
        };
      };
      postgresql.package = pkgs.postgresql_16;
    };
  };
}
