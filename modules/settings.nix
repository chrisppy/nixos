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
          "https://cache.flakehub.com"
        ];
        trusted-substituters = [
          "https://hyprland.cachix.org"
          "https://install.determinate.systems"
          "https://cache.flakehub.com"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        ];
        warn-dirty = false;
      };
    };
  };
}
