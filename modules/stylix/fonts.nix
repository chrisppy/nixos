_: {
  flake.modules.nixos.base =
    {
      config,
      pkgs,
      ...
    }:
    {
      stylix.fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font Mono";
        };
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
        sizes = {
          applications = 11;
          desktop = 12;
          popups = 12;
          terminal = 11;
        };
      };
    };
}
