_: {
  flake.modules.nixos.grub = {
    config.boot.loader = {
      grub = {
        enable = true;
        useOSProber = true;
      };
      systemd-boot.enable = false;
    };
  };
}
