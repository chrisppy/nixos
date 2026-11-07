_: {
  flake.modules.nixos.caddy =
    {
      config,
      pkgs,
      ...
    }:
    {
      sops.secrets.cloudflare-api-token = { };

      services.caddy = {
        enable = true;
        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
          hash = "sha256-xRJ5evsAJ2akg47j3Bt6YDXJOgX88B/rKNP50KSVyNY=";
        };
      };

      systemd.services.caddy.serviceConfig.EnvironmentFile = [
        config.sops.secrets.cloudflare-api-token.path
      ];
    };
}
