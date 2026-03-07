{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.base = {config, ...}: {
    networking = {
      domain = "palmer.lan";
      useNetworkd = true;
      firewall.trustedInterfaces = [
        config.services.tailscale.interfaceName
      ];
    };
    services = {
      openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
        };
      };
      tailscale = let
        flags = ["--operator=${username}"];
      in {
        extraUpFlags = flags;
        extraSetFlags = flags;
        openFirewall = true;
        useRoutingFeatures = "both";
      };
    };
    systemd.network.enable = true;
    users.users.${username}.openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMyE/nW0vv2QX1rgJCPY2vmHzxi9fqiD1FN/F69/m3ySAAAABHNzaDo= chris@red-oxide.org"
    ];
  };
}
