{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.meta.owner) username;
  sops = {
    defaultSopsFile = inputs.self + "/secrets/secrets.yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  };
in {
  flake.modules = {
    nixos.base = {pkgs, ...}: {
      inputs = [inputs.sops-nix.nixosModules.home-manager];

      environment.systemPackages = with pkgs; [
        age
        sops
        ssh-to-age
      ];

      inherit sops;
    };
    homeManager.base = {
      inherit sops;
    };
  };
}

