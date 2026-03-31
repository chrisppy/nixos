_: {
  flake.modules.homeManager = {
    base = {pkgs, ...}: {
      home.packages = with pkgs; [
        kitty.terminfo
      ];
    };
    gui = {
      config,
      lib,
      ...
    }: let
      term = lib.getExe config.programs.kitty.package;
    in {
      wayland.windowManager.hyprland.settings.bindd = [
        "$mod, return, Terminal, exec, ${term}"
      ];
      programs = {
        niri.settings.binds."Mod+Return".action.spawn = [term];
        kitty = {
          enable = true;
          enableGitIntegration = true;
        };
      };
    };
  };
}
