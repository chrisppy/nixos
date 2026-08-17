_: {
  flake.modules.nixos.base = {
    services.smartd = {
      enable = true;
      autodetect = true;
    };
  };
}
