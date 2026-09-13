_: {
  flake.modules.homeManager.base = {
    programs.nhx.settings.keys.normal = {
      "C-left" = ":buffer-previous";
      "C-right" = ":buffer-next";
      n = {
        a = ":buffer-close-all";
        c = ":buffer-close";
        f = ":buffer-close!";
        s = ":write";
      };
    };
  };
}
