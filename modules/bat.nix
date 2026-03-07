_: {
  flake.modules.homeManager.base = {pkgs, ...}: {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batwatch
        prettybat
      ];
    };

    home = {
      shellAliases = {
        cat = "bat --paging=never";
        less = "bat --paging=always";
        more = "bat --paging=always";
      };
      sessionVariables = {
        MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
        MANROFFOPT = "-c";
        PAGER = "bat";
      };
    };
  };
}
