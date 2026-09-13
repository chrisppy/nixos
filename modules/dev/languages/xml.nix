_: {
  flake.modules.homeManager.dev = {
    programs.nhx.languages = {
      language = [
        {
          name = "xml";
          auto-format = true;
        }
      ];
    };
  };
}
