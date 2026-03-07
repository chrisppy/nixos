{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.meta.owner) username;
  sopsCfg = {
    defaultSopsFile = inputs.self + "/secrets/secrets.yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  };
in {
  flake.modules = {
    nixos.base = {pkgs, ...}: {
      imports = [inputs.sops-nix.nixosModules.sops];

      environment.systemPackages = with pkgs; [
        age
        sops
        ssh-to-age
      ];

      sops = sopsCfg;
    };
    homeManager.base = {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops = sopsCfg;
    };
  };
}
