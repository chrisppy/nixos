_: {
  flake.modules.homeManager.base = {
    programs.helix.settings = {
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
          120
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
}
