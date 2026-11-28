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
          "https://red-oxide.cachix.org"
        ];
        trusted-substituters = [
          "https://red-oxide.cachix.org"
        ];
        trusted-public-keys = [
          "red-oxide.cachix.org-1:kX7CnXH4XIGlSiCojVBNK3zcka8p2po2PnfNToDYauI="
        ];
        warn-dirty = false;
      };
    };
  };
}
