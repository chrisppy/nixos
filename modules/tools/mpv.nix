_: {
  flake.modules.nixos.pc =
    { config, ... }:
    {
      # The colors and fonts of Stylix's mpv target.
      wrappers.mpv.module."mpv.conf".content =
        with config.lib.stylix.colors.withHashtag;
        ''
          osd-font=${config.stylix.fonts.sansSerif.name}
          sub-font=${config.stylix.fonts.sansSerif.name}
          background-color=#000000
          osd-back-color=${base01}
          osd-border-color=${base01}
          osd-color=${base05}
          osd-shadow-color=${base00}
        '';
    };
}
