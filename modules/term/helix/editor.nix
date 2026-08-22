_: {
  flake.modules.homeManager.base = {
    programs.helix.settings.editor = {
      bufferline = "always";
      color-modes = true;
      cursorline = true;
      true-color = true;

      auto-completion = true;
      completion-trigger-len = 1;
      completion-timeout = 5;
      continue-comments = false;

      file-picker.hidden = false;
      lsp.display-messages = true;

      cursor-shape = {
        insert = "block";
        normal = "block";
        select = "underline";
      };

      indent-guides = {
        render = true;
        character = "|";
        skip-levels = 1;
      };

      rulers = [
        72
        80
        100
        120
      ];

      statusline = {
        left = [
          "mode"
          "spinner"
          "file-name"
        ];
        center = [ "version-control" ];
        right = [
          "diagnostics"
          "selections"
          "position"
          "file-encoding"
          "file-line-ending"
          "file-type"
        ];
        separator = "│";
        mode = {
          normal = "NOR";
          insert = "INS";
          select = "SEL";
        };
      };

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
    };
  };
}
