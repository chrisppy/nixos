_: {
  flake.modules.homeManager.base = {
    programs.helix.settings.keys.normal = {
      "tab" = "goto_next_buffer";
      "S-tab" = "goto_previous_buffer";
      "C-x" = ":buffer-close";
      "X" = [
        "extend_line_up"
        "extend_to_line_bounds"
      ];
    };
  };
}
