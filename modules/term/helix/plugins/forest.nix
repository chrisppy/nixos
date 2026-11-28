_: {
  flake.modules.nixos.base = {
    nhx.programs.nhx.plugins.forest = {
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
