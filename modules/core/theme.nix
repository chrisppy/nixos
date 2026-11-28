{ inputs, ... }:
let
  inherit (inputs.base24-themes.lib) base24;
in
{
  # The color theme, read from base24-themes. Wrapped programs take their
  # colors from `theme` directly; Stylix uses the same theme for what its
  # NixOS module still themes (GTK, Qt, the console).
  flake.modules.nixos.base =
    { config, lib, ... }:
    {
      options.theme = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "birdland";
          description = "A theme bundled with base24-themes.";
        };
        scheme = lib.mkOption {
          type = lib.types.attrs;
          readOnly = true;
          default = base24.themes.${config.theme.name};
          description = "The theme, as base24-themes defines it.";
        };
        colors = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          readOnly = true;
          default = base24.getColors config.theme.scheme;
          description = "base00–base17 as six hex digits, without \"#\".";
        };
        hex = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          readOnly = true;
          default = lib.mapAttrs (_: c: "#${c}") config.theme.colors;
          description = "base00–base17 with a leading \"#\".";
        };
        variant = lib.mkOption {
          type = lib.types.str;
          readOnly = true;
          default = (base24.getMeta config.theme.scheme).variant;
          description = "\"dark\" or \"light\".";
        };
      };
    };
}
