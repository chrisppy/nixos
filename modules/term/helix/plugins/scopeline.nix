_: {
  flake.modules.nixos.base = {
    nhx.programs.nhx.plugins.scopeline = {
      enable = true;
      config = {
        showFile = false;
        alwaysReserved = true;
        position = "bottom-left";
      };
    };
  };
}
