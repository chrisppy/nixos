_: {
  flake.modules.homeManager.base = {
    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
        };
      };
    };
  };
}
