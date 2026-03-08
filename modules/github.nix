_: {
  flake.modules.homeManager.dev = {
    programs.gh = {
      enable = true;
      settings = {
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
        editor = "hx";
        git_protocol = "ssh";
      };
    };
  };
}
