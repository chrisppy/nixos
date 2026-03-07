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
      inputs = [inputs.sops-nix.nixosModules.sops];

      environment.systemPackages = with pkgs; [
        age
        sops
        ssh-to-age
      ];

      inherit sops;
    };
    homeManager.base = {
      inputs = [inputs.sops-nix.homeManagerModules.sops];
      inherit sops;
    };
  };
}
