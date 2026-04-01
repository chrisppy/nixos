_: {
  flake.modules = {
    nixos.cad = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        kicad
      ];
    };
    # homeManager.niri = {
    #   wayland.windowManager.niri.settings._children = [
    #     {
    #       window-rule._children = [
    #         {
    #           match._props = {
    #             app-id = "^KiCAD$";
    #           };
    #         }
    #         {
    #           open-maximized-to-edges = true;
    #         }
    #       ];
    #     }
    #   ];
    # };
  };
}
