_: {
  flake.modules.nixos.pc = {
    nhx.programs.nhx.languages = {
      language = [
        {
          name = "xml";
          auto-format = true;
        }
      ];
    };
  };
}
