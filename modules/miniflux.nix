{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.miniflux = {
    config,
    lib,
    pkgs,
    ...
  }: let
    # domain = config.networking.fqdn;
    # domain = "rss.chrisppy.me";
    domain = "rss.${config.networking.hostName}.gaur-truck.ts.net";
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
        tls /var/lib/tailscale/certs/${domain}.crt \
          /var/lib/tailscale/certs/${domain}.key

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

    systemd = {
      services.tailscale-cert-rss = {
        description = "Fetch Tailscale cert for rss subdomain";

        after = ["network-online.target" "tailscaled.service"];
        wants = ["network-online.target"];
        requires = ["tailscaled.service"];

        serviceConfig = {
          Type = "oneshot";
          ExecStartPre = "${lib.getExe pkgs.tailscale} status";
          ExecStart = "${lib.getExe pkgs.tailscale} cert ${domain}";
        };

        wantedBy = ["multi-user.target"];
      };
      timers.tailscale-cert-rss = {
        wantedBy = ["timers.target"];
        timerConfig = {
          OnBootSec = "5m";
          OnUnitActiveSec = "12h";
        };
      };
    };
  };
}
