{ inputs, ... }:
{
  flake.modules.homeManager.base =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.stylix.targets.nhx;

      colors = config.lib.stylix.colors;

      theme = config.lib.stylix.colors {
        templateRepo = inputs.stylix.inputs.base16-helix;
        target = "base16";
      };

      transparentTheme = pkgs.runCommandLocal "helix-transparent.toml" { } ''
        sed 's/,\? bg = "base00"//g' <${theme} >$out
      '';
    in
    {
      options.stylix.targets.nhx = {
        enable = lib.mkEnableOption "Stylix integration for nhx";

        transparent = lib.mkOption {
          type = lib.types.bool;
          default = config.stylix.opacity.terminal != 1.0;
        };
      };

      config = lib.mkIf cfg.enable {
        programs.nhx.settings.theme = "stylix";

        home.file.".config/helix/themes/stylix.toml".source =
          if cfg.transparent then transparentTheme else theme;

        # Moka Plugin
        programs.nhx.plugins = {
          "who-unstable".config = {
            color = colors.base0C;
          };
          moka.config = {
            transparent = cfg.transparent;
            rowOffset = 2;

            modeColors = {
              normal = {
                bg = colors.base0D;
                fg = colors.base00;
              };

              insert = {
                bg = colors.base0B;
                fg = colors.base00;
              };

              select = {
                bg = colors.base0E;
                fg = colors.base00;
              };
            };

            sections = [
              {
                align = "left";

                segments = [
                  {
                    kind = "mode";
                    bubble = true;
                  }

                  {
                    kind = "file";
                    bg = colors.base00;
                    fg = colors.base05;
                    bubble = true;
                    coloredIcons = true;
                  }
                ];
              }

              {
                align = "center";

                segments = [
                  {
                    kind = "git-branch";
                    bg = colors.base09;
                    fg = colors.base00;
                    bubble = true;
                  }
                ];
              }

              {
                align = "right";

                segments = [
                  {
                    kind = "diagnostics";
                  }

                  {
                    kind = "lsp";
                    bg = colors.base00;
                    fg = colors.base05;
                    bubble = true;
                  }

                  {
                    kind = "position-percentage";
                  }

                  {
                    kind = "position";
                    bg = colors.base00;
                    fg = colors.base05;
                    bubble = true;
                  }
                ];
              }
            ];

            bufferline = {
              active = {
                bg = colors.base0D;
                fg = colors.base00;
                bubble = true;
              };

              inactive = {
                fg = colors.base03;
              };

              gap = 1;
            };
          };
        };
      };
    };
}
