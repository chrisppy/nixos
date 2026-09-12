_: {
  flake.modules.homeManager.base = {
    programs.nvf.settings.vim.languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      bash.enable = true;
      css.enable = true;
      fish.enable = true;
      go.enable = true;
      html.enable = true;
      json.enable = true;
      just.enable = true;
      kotlin.enable = true;
      markdown.enable = true;
      nix = {
        enable = true;
        format.type = [ "nixfmt-rs" ];
        lsp.servers = [ "nixd" ];
      };
      qml.enable = true;
      rust = {
        enable = true;
        extensions.crates-nvim = {
          enable = true;
          setupOpts = {
            completion.crates.enabled = true;
            lsp = {
              actions = true;
              completion = true;
              enabled = true;
              hover = true;
            };
          };
        };
      };
      scss.enable = true;
      sql.enable = true;
      tex.enable = true;
      toml.enable = true;
      xml.enable = true;
      yaml.enable = true;
    };
  };
}
