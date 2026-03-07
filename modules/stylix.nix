{inputs, ...}: {
  flake.modules.nixos.base = {
    config,
    pkgs,
    ...
  }: {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;
      image = inputs.self + "/assets/wallpaper.jpg";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/shadesmear-dark.yaml";
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Amber";
        size = 24;
      };
      fonts = {
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
      icons = {
        enable = true;
        package = pkgs.yaru-theme;
        dark = "Yaru-sage";
      };
      opacity = {
        applications = 1.0;
        desktop = 1.0;
        popups = 1.0;
        terminal = 1.0;
      };
      polarity = "dark";
    };
  };
}
