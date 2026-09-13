_: {
  flake.modules.homeManager.base =
    {
      stylix.targets.nhx.enable = true;

      programs.nhx = {
        enable = true;

        steel = {
          enable = true;
          lsp.enable = true;
        };
      };
    };
}
