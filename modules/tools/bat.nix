{ config, ... }:
let
  inherit (config.flake.meta.owner) username;
in
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      # bat's base16 theme uses the terminal's 16 colors, which kitty sets
      # from the base24 theme.
      wrappers.bat.module.settings.theme = "base16";

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
