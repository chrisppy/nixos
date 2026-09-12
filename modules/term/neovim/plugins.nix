_: {
  flake.modules.homeManager.base = {
    programs.nvf.settings.vim = {
      autocomplete.blink-cmp.enable = true;
      autopairs.nvim-autopairs.enable = true;
      git.enable = true;
      lsp.lspkind.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      utility = {
        oil-nvim.enable = true;
        snacks-nvim.enable = true;
      };
      visuals.nvim-web-devicons.enable = true;
    };
  };
}
