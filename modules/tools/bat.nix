{ config, inputs, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.base =
    { config, pkgs, ... }:
    {
      wrappers.bat.module = {
        # Stylix's bat target, without Home Manager.
        themes.base16-stylix = config.lib.stylix.colors {
          template = "${inputs.stylix}/modules/bat/base16-stylix.tmTheme.mustache";
          extension = ".tmTheme";
        };
        settings.theme = "base16-stylix";
      };

      users.users.${username}.packages = with pkgs.bat-extras; [
        batgrep
        batwatch
        prettybat
      ];

      environment = {
        shellAliases = {
          cat = "bat --paging=never";
          less = "bat --paging=always";
          more = "bat --paging=always";
        };
        sessionVariables = {
          MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
          MANROFFOPT = "-c";
          PAGER = "less";
        };
      };
    };
}
