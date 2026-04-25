_: {
  flake.modules.nixos.caddy = {pkgs, ...}: {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.4"];
        hash = "sha256-4WF7tIx8d6O/Bd0q9GhMch8lS3nlR5N3Zg4ApA3hrKw=";
      };
    };
    # systemd.services.caddy.serviceConfig = {
    #   SupplementaryGroups = ["tailscale"];
    # };
  };
}
