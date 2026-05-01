_: {
  flake.modules.homeManager.gui =
    {
      config,
      lib,
      ...
    }:
    {
      programs.discord.enable = true;
      wayland.windowManager = {
        hyprland.settings.exec-once = [
          "${lib.getExe config.programs.discord.package} --start-minimized"
        ];
        # niri.settings._children = [
        #   {
        #     spawn-at-startup = "${lib.getExe config.programs.discord.package} --start-minimized";
        #   }
        # ];
      };
    };
}
