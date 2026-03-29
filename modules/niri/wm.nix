{inputs, ...}: {
  flake.modules = {
    nixos.niri = {pkgs, ...}: {
      programs.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
    };

    homeManager.niri = {pkgs, ...}: {
      programs.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
        settings = {
          # your niri settings here
        };
      };
    };
  };
}
