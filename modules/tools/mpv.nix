{ inputs, ... }:
{
  flake.modules.nixos.pc =
    { config, ... }:
    {
      wrappers.mpv.module = {
        # OSD colors from the base24 theme; fonts from Stylix.
        imports = [ inputs.base24-themes.wrapperModules.mpv ];
        base24.theme = config.theme.name;
        "mpv.conf".content = ''
          osd-font=${config.stylix.fonts.sansSerif.name}
          sub-font=${config.stylix.fonts.sansSerif.name}
        '';
      };
    };
}
