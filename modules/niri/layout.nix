_: {
  flake.modules.homeManager.niri = {
    programs.niri.settings.layout = {
      gaps = 10;
      center-focused-column = "never";

      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 0.5;}
        {proportion = 2.0 / 3.0;}
        {proportion = 1.0;}
      ];
      default-column-width.proportion = 0.5;

      focus-ring = {
        enable = true;
        width = 2;
      };

      border = {
        enable = false;
        width = 2;
      };
    };
  };
}
