_: {
  flake.modules.homeManager.base =
    {
      programs.helix = {
        languages = {
          language = [
            {
          name = "xml";
          auto-format = true;
        }
          ];
        };
      };
    };
}
