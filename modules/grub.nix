_: {
  flake.modules.nixos.grub = {
    boot.loader = {
      grub = {
        enable = true;
        useOSProber = true;
      };
      systemd-boot.enable = false;
    };
  };
}
