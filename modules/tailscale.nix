{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules = {
    nixos.base =
      { config, ... }:
      {
        networking = {
          firewall = {
            trustedInterfaces = [
              config.services.tailscale.interfaceName
            ];
            allowedTCPPorts = [
              80
              443
            ];
          };
        };
        services.tailscale =
          let
            flags = [
              "--operator=${username}"
              "--accept-dns=true"
            ];
          in
          {
            enable = true;
            extraUpFlags = flags;
            extraSetFlags = flags;
            openFirewall = true;
            useRoutingFeatures = "both";
          };
      };
  };
}
