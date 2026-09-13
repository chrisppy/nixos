_: {
  flake.modules.homeManager.base = {
    programs.nhx.plugins.scopeline = {
      enable = true;
      config = {
        showFile = false;
        alwaysReserved = true;
      };
    };
  };
}
