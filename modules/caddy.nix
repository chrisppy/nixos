_: {
  flake.modules.nixos.caddy = {
    services.caddy = {
      enable = true;
    };
    systemd.services.caddy.serviceConfig = {
      SupplementaryGroups = ["tailscale"];
    };
  };
}
