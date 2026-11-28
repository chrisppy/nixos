_: {
  flake.modules.nixos.base = {
    nhx.programs.nhx.plugins.oil = {
      enable = true;
      config = {
        showDotfiles = true;
        keymaps.normal."ret" = ":oil-enter";
      };
    };
  };
}
