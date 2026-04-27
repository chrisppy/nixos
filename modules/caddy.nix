_: {
  flake.modules.nixos.caddy = {
    config,
    lib,
    pkgs,
    ...
  }: let
    mkVHost = name: port: {
      "${name}.chrisppy.me".extraConfig = ''
          tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
            resolvers 1.1.1.1
            propagation_delay 60s
            propagation_timeout 300s
          }
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  in {
    sops.secrets.cloudflare-api-token = {};

    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.4"];
        hash = "sha256-4WF7tIx8d6O/Bd0q9GhMch8lS3nlR5N3Zg4ApA3hrKw=";
      };
      virtualHosts = lib.mkMerge [
        (lib.mkIf config.services.audiobookshelf.enable (mkVHost "books" 13378))
        (lib.mkIf config.services.jellyfin.enable (mkVHost "media" 8096))
        (lib.mkIf config.services.miniflux.enable (mkVHost "feeds" 7070))
        (lib.mkIf (config.networking.hostName == "blueridge") (mkVHost "ha" 8123))
      ];
    };

    systemd.services.caddy.serviceConfig.EnvironmentFile = [
      config.sops.secrets.cloudflare-api-token.path
    ];
  };
}
