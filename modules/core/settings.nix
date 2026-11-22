_: {
  flake.modules.nixos.base = {
    nixpkgs.config.allowUnfree = true;

    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        substituters = [
          "https://hyprland.cachix.org"
          "https://install.determinate.systems"
          "https://red-oxide.cachix.org"
        ];
        trusted-substituters = [
          "https://hyprland.cachix.org"
          "https://install.determinate.systems"
          "https://red-oxide.cachix.org"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "red-oxide.cachix.org-1:kX7CnXH4XIGlSiCojVBNK3zcka8p2po2PnfNToDYauI="
        ];
        warn-dirty = false;
      };
    };
  };
}
