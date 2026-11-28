{ inputs, ... }:
{
  flake.modules.nixos.base =
    { config, pkgs, ... }:
    {
      wrappers.yazi.module = {
        imports = [ inputs.base24-themes.wrapperModules.yazi ];
        base24.theme = config.theme.name;
        plugins = {
          inherit (pkgs.yaziPlugins) git;
        };
        settings = {
          yazi.mgr = {
            show_hidden = false;
            show_symlink = true;
            sort_by = "natural";
            sort_dir_first = true;
            sort_sensitive = false;
            sort_reverse = false;
          };
        };
      };
    };
}
