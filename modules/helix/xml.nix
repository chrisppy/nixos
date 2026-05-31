_: {
  flake.modules.homeManager.dev = {
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
