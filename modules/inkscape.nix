_: {
  flake.modules = {
    nixos.design =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          inkscape-with-extensions
        ];
      };
  };
}
