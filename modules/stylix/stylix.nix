{ inputs, ... }:

let
  base24 = inputs.base24-themes.lib.base24;
in
{
  flake.modules.nixos.base =
    { config, ... }:
    let
      themeName = config.base24.theme;
      theme = base24.themes.${themeName};
    in
    {
      imports = [
        inputs.stylix.nixosModules.stylix
        inputs.base24-themes.nixosModules.default
      ];

      # The one place the theme is named: Stylix and base24-themes'
      # modules (GTK and Qt, in toolkits.nix) both use it.
      base24.theme = "birdland";

      fonts.fontconfig.enable = true;

      stylix = {
        enable = true;
        base16Scheme = builtins.toFile "${themeName}.yaml" (base24.toYaml theme);
        polarity = (base24.getMeta theme).variant;
      };
    };
}
