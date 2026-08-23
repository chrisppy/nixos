_: {
  flake.modules.homeManager.dev =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        ctags-lsp
        universal-ctags

      ];

      programs.helix.languages = {
        language-server.ctags-lsp = {
          command = lib.getExe pkgs.ctags-lsp;
        };
      };
    };
}
