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
      pkgs,
      ...
    }: let
      term = lib.getExe config.programs.kitty.package;
    in {
      wayland.windowManager = {
        hyprland.settings.bindd = [
          "$mod, return, Terminal, exec, ${term}"
        ];
        # niri.settings.binds."Mod+Return".spawn = [term];
      };
      programs.kitty = {
        enable = true;
      };
      programs.alacritty.enable = true;
      programs.foot.enable = true;
      home.packages = [pkgs.xterm];
    };
  };
}
