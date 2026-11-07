{ config, inputs, ... }:
let
  inherit (config.flake.lib) mkDomain mkVHost;
  name = "gym";
in
{
  flake.modules.nixos.opengym = { config, ... }: {
    imports = [
      inputs.opengym.nixosModules.default
    ];
    services = {
      opengym = {
        enable = true;
        apiPort = 3333;
        rpId = mkDomain name;
        origin = "https://${config.services.opengym.rpId}";
        allowGuest = false;
        inviteOnly = true;
      };
      caddy.virtualHosts = mkVHost name config.services.opengym.apiPort;
    };
  };
}
