_: {
  flake.modules = {
    nixos.cad =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ orca-slicer ];
      };
  };
}
