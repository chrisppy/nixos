_: {
  flake.modules.homeManager.base = {
    programs.nhx.plugins.forest = {
      enable = true;
      config = {
        style = "snacks";
        circularKeybinds = true;
        position = "left";
        ignore = [
          ".git"
          "target"
          ".cache"
        ];
      };
    };
  };
}
