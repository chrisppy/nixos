_: {
  flake.modules = {
    nixos.inkscape =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          inkscape-with-extensions
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
