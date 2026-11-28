{ inputs, ... }:
{
  flake.modules.nixos.base =
    { config, pkgs, ... }:
    {
      wrappers.yazi.module = {
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
          # The syntax-highlighting part of Stylix's yazi target.
          theme.mgr.syntect_theme = config.lib.stylix.colors {
            template = "${inputs.stylix}/modules/bat/base16-stylix.tmTheme.mustache";
            extension = ".tmTheme";
          };
        };
      };
    };
}
