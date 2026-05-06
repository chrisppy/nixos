_: {
  flake.modules = {
    nixos.inkscape =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          inkscape-with-extensions
        ];
      };
  };
}
