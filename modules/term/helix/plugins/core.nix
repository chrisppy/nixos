_: {
  flake.modules.nixos.base = {
    nhx.programs.nhx = {
      enable = true;

      steel = {
        enable = true;
        lsp.enable = true;
      };
    };
  };
}
