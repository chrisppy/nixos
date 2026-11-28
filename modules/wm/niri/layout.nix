_: {
  flake.modules.nixos.niri =
    { config, ... }:
    let
      inherit (config.lib.stylix.colors) withHashtag;
    in
    {
      wrappers.niri.module.settings.layout = {
        gaps = 10;
        center-focused-column = "on-overflow";

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 0.5; }
          { proportion = 2.0 / 3.0; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 0.5;

        # Widths from before; colors as niri-nix's Stylix module set them.
        focus-ring = {
          width = 2;
          active-color = withHashtag.base0D;
          inactive-color = withHashtag.base03;
        };
        border = {
          width = 2;
          active-color = withHashtag.base0D;
          inactive-color = withHashtag.base03;
          urgent-color = withHashtag.base08;
        };
      };
    };
}
