_: {
  flake.modules.homeManager.tofi = {
    programs.tofi = {
      enable = true;
      settings = {
        horizontal = true;
        anchor = "top";
        width = "100%";
        height = 32;
        outline-width = 0;
        border-width = 0;
        prompt-text = "> ";
      };
    };
  };
}
