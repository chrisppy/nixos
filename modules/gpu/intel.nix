_: {
  flake.modules.nixos.gpu-intel = {
    boot = {
      kernelModules = ["xe"];
      blacklistedKernelModules = ["i915"];
      initrd.kernelModules = ["xe"];
    };

    hardware = {
      enableRedistributableFirmware = true;
      graphics.enable = true;
    };
  };
}
