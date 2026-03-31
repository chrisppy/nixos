_: {
  flake.modules = {
    nixos.pc = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        bitwarden-desktop
      ];
    };
    homeManager.niri = {
      programs.niri.settings = {
        window-rules = [
          {
            matches = [{app-id = "^Bitwarden$";}];
            block-out-from = "screen-capture";
          }
        ];
      };
    };
  };
}
