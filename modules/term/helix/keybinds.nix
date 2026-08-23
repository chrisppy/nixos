_: {
  flake.modules.homeManager.base = {
    programs.nhx.settings.keys.normal = {
      "space" = {
        left = ":buffer-previous";
        right = ":buffer-next";
      };
      n = {
        a = ":buffer-close-all";
        c = ":buffer-close";
        f = ":buffer-close!";
        s = ":write";
      };
    };
  };
}
