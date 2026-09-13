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
      };
    };
}
