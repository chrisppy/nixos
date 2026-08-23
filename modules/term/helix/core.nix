{ inputs, ... }:
{
  flake.modules.homeManager.base = {helixPlugins, ...}: {
    imports = [ inputs.nhx.homeManagerModules.default ];

    stylix.targets.nhx.enable = true;

    programs.nhx = {
      enable = true;

      steel = {
        enable = true;
        lsp.enable = true;
      };

      plugins = with helixPlugins; [
        glyph
        moka
      ];
    };
  };
}
