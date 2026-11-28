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
          # The base24 palette as the terminal's colors. Programs that use
          # the terminal's 16 colors (bat's base16 theme) follow it.
          imports = [ inputs.base24-themes.wrapperModules.kitty ];
          base24 = {
            theme = config.theme.name;
            opacity = opacity.terminal;
          };
          # Stylix's NixOS module installs the font itself.
          font = {
            inherit (fonts.monospace) name;
            size = fonts.sizes.terminal;
          };
        };
        users.users.${username}.packages = [ pkgs.xterm ];
      };
  };
}
