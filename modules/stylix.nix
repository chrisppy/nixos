{ inputs, ... }:
{
  flake.modules = {
    nixos.base =
      {
        config,
        pkgs,
        ...
      }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];

        fonts.fontconfig.enable = true;

        stylix = {
          enable = true;
          image = inputs.self + "/assets/wallpaper.jpg";
          # base16Scheme = "${pkgs.base16-schemes}/share/themes/shadesmear-dark.yaml";
          base16Scheme = {
            scheme = "Chesapeake";
            author = "chrisppy";
            variant = "dark";
            base00 = "111a0f"; # Default Background
            base01 = "1a2714"; # Lighter Background (status bars)
            base02 = "243a1b"; # Selection Background
            base03 = "3d5c2e"; # Comments, Invisibles, Line Highlighting
            base04 = "7a8f6a"; # Dark Foreground (status bars)
            base05 = "cdd8b0"; # Default Foreground, Caret, Delimiters
            base06 = "e2eacf"; # Light Foreground
            base07 = "f5f7ec"; # Light Background
            base08 = "df4601"; # Variables, XML Tags — Orioles orange
            base09 = "f26419"; # Integers, Boolean, Constants
            base0A = "c97f00"; # Classes, Search Text Background
            base0B = "6bbf4e"; # Strings, Diff Inserted
            base0C = "4db891"; # Support, Regex, Escape Characters
            base0D = "a3c95a"; # Functions, Methods, Headings
            base0E = "b83d01"; # Keywords, Storage — Orioles orange dark
            base0F = "7a2200"; # Deprecated, Embedded Language Tags
          };
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
  };
}
