# GTK and Qt apps are colored by base24-themes (nixosModules.toolkits)
# instead of Stylix. The icon theme, fonts and cursor stay Stylix's settings
# and are passed on, so they don't change.
{ inputs, ... }:

let
  noStylixToolkits = {
    stylix.targets = {
      gtk.enable = false;
      qt.enable = false;
    };
  };
in
{
  flake.modules = {
    nixos.base = noStylixToolkits;
    homeManager.base = noStylixToolkits;

    nixos.pc =
      { config, lib, ... }:
      let
        inherit (config.stylix) cursor fonts icons;
        font = f: {
          inherit (f) name package;
          size = fonts.sizes.applications;
        };
      in
      {
        imports = [ inputs.base24-themes.nixosModules.toolkits ];

        base24 = {
          gtk.enable = true;
          qt.enable = true;
          toolkits = {
            iconTheme = lib.mkIf icons.enable {
              inherit (icons) package;
              name = if config.stylix.polarity == "light" then icons.light else icons.dark;
            };
            font = font fonts.sansSerif;
            monospaceFont = font fonts.monospace;
            cursorTheme = {
              inherit (cursor) name package size;
            };
          };
        };
      };
  };
}
