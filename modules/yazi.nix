_: {
  flake.modules.homeManager.base = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      plugins = {
        inherit (pkgs.yaziPlugins) git;
      };
      settings.manager = {
        show_hidden = false;
        show_symlink = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_sensitive = false;
        sort_reverse = false;
      };
    };
  };
}
