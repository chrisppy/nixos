_: {
  flake.modules.homeManager.base = {pkgs, ...}: let
    # inherit (inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}) helix;
    inherit (pkgs) helix;
  in {
    programs.helix = {
      enable = true;
      package = helix;
      defaultEditor = true;
      extraPackages = with pkgs; [
        cmake-language-server
        ctags-lsp
        gopls
        mesonlsp
        nil
        nixd
        rust-analyzer
        taplo
        universal-ctags
        yaml-language-server
      ];
      languages = {
        language = [
          {
            language-servers = [
              "marksman"
              "ltex"
            ];
            name = "markdown";
          }
        ];
        language-server = {
          ltex = {
            command = "ltex-ls";
            config.ltex = {
              dictionary = {
                en-US = [];
              };
              disabledRules = {
                en-US = ["PROFANITY"];
              };
            };
          };
          yaml-language-server.config.yaml.keyOrdering = false;
          rust-analyzer.config.rust-analyzer.check.command = "clippy";
        };
      };
      settings = {
        keys.normal = {
          "tab" = "goto_next_buffer";
          "S-tab" = "goto_previous_buffer";
          "C-x" = ":buffer-close";
          "X" = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
        };
        editor = {
          true-color = true;
          rulers = [
            72
            80
            100
          ];
          cursorline = true;
          bufferline = "always";
          color-modes = true;
          statusline = {
            left = [
              "mode"
              "spinner"
              "version-control"
              "file-name"
              "read-only-indicator"
              "file-modification-indicator"
            ];
          };
          cursor-shape = {
            insert = "block";
            normal = "block";
            select = "underline";
          };
          file-picker.hidden = false;
          lsp.display-messages = true;
          whitespace = {
            render = {
              space = "none";
              tab = "all";
              newline = "none";
            };
            characters = {
              space = "·";
              nbsp = "⍽";
              tab = "→";
              newline = "⏎";
              tabpad = "·";
            };
          };
          indent-guides = {
            render = true;
            character = "|";
            skip-levels = 1;
          };
        };
      };
    };
  };
}
