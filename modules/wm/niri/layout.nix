_: {
  flake.modules.nixos.niri.wrappers.niri.module.settings.layout = {
    gaps = 10;
    center-focused-column = "on-overflow";

    preset-column-widths = [
      { proportion = 1.0 / 3.0; }
      { proportion = 0.5; }
      { proportion = 2.0 / 3.0; }
      { proportion = 1.0; }
    ];
    default-column-width.proportion = 0.5;

    # The colors come from base24-themes (see wm.nix).
    focus-ring.width = 2;
    border.width = 2;
  };
}
