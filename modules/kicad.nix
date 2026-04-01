_: {
  flake.modules = {
    nixos.cad = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        kicad
      ];
    };
    homeManager.niri = {
      wayland.windowManager.niri.settings._children = [
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "^KiCAD$";
              };
            }
            {
              default-column-width.proportion = 1.0;
            }
          ];
        }
      ];
    };
  };
}
