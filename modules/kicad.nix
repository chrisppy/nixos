_: {
  flake.modules = {
    nixos.cad = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        kicad
      ];
    };
    homeManager.niri = {
      programs.niri.settings = {
        window-rules = [
          {
            matches = [{app-id = "^KiCAD$";}];
            default-column-width.proportion = 1.0;
          }
        ];
      };
    };
  };
}
