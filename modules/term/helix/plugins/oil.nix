_: {
  flake.modules.homeManager.base = {
    programs.nhx.plugins.oil = {
      enable = true;
      config = {
        showDotfiles = true;
        keymaps.normal."ret" = ":oil-enter";
      };
    };
  };
}
