_: {
  flake.modules.homeManager.gui = {
    config,
    lib,
    ...
  }: {
    programs = {
      discord.enable = true;
      niri.settings.spawn-at-startup = [
        {command = ["${lib.getExe config.programs.discord.package}" "--start-minimized"];}
      ];
    };
    wayland.windowManager.hyprland.settings.exec-once = [
      "${lib.getExe config.programs.discord.package} --start-minimized"
    ];
  };
}
