{ config, inputs, lib, ... }:
{
  flake.modules = {
    nixos.base = {
      nixpkgs.config.allowUnfree = true;

      nix = let
        flakeInputs = inputs.nixpkgs.lib.filterAttrs (_: inputs.nixpkgs.lib.isType "flake") inputs;
      in {
        # channel.enable = false;
        # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
        # registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          # flake-registry = "";
          max-jobs = 8;
          # nix-path = config.nix.nixPath;
          # substituters = ["https://hyprland.cachix.org"];
          # trusted-substituters = ["https://hyprland.cachix.org"];
          # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
          trusted-users = [
            "root"
            "${config.username}"
          ];
          warn-dirty = false;
        };
      };
    };
  };
}

