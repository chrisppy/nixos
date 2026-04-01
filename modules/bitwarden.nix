_: {
  flake.modules = {
    nixos.pc = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        bitwarden-desktop
      ];
    };
    homeManager.niri = {
      wayland.windowManager.niri.settings._children = [
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "^Bitwarden$";
              };
            }
            {
              block-out-from = "screen-capture";
            }
          ];
        }
      ];
    };
  };
}
