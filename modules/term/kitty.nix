{ config, inputs, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos = {
    base =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.kitty.terminfo ];
      };
    pc =
      { config, pkgs, ... }:
      let
        inherit (config.stylix) fonts opacity;
      in
      {
        wrappers.kitty.module = {
          font = {
            inherit (fonts.monospace) package name;
            size = fonts.sizes.terminal;
          };
          settings.background_opacity = toString opacity.terminal;
          # Stylix's kitty target, without Home Manager.
          extraConfig = ''
            include ${
              config.lib.stylix.colors {
                templateRepo = inputs.stylix.inputs.tinted-kitty;
                target = "base16";
              }
            }
          '';
        };
        users.users.${username}.packages = [ pkgs.xterm ];
      };
  };
}
