_: {
  flake.modules.homeManager.base = {
    programs = {
      ripgrep.enable = true;
      ripgrep-all.enable = true;
    };

    home = {
      shellAliases = {
        grep = "rg";
      };
    };
  };
}
