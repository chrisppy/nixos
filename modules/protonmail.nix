_: {
  flake.modules = {
    nixos.protonmail =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          protonmail-desktop
        ];
      };
  };
}
