{config, ...}: {
  flake.modules = {
    nixos.base = {
      nixpkgs.config.allowUnfree = true;

      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          max-jobs = 8;
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
