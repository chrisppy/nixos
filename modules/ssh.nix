{config, ...}: let
  inherit (config.flake.meta.owner) username;
in {
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      kitty.terminfo
    ];
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    users.users.${username}.openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMyE/nW0vv2QX1rgJCPY2vmHzxi9fqiD1FN/F69/m3ySAAAABHNzaDo= chris@red-oxide.org"
    ];
  };
}
