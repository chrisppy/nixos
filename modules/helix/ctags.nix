_: {
  flake.modules.homeManager.base =
    { lib, pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          ctags-lsp
          universal-ctags
        ];
        languages = {
          language-server.ctags-lsp = {
            command = lib.getExe pkgs.ctags-lsp;
          };
        };
      };
    };
}
