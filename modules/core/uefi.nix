_: {
  flake.modules.nixos.uefi = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        memtest86.enable = true;
      };
    };
  };
}
