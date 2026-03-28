_: {
  flake.modules.nixos.gpu-intel = {
    boot = {
      kernelModules = ["xe"];
      blacklistedKernelModules = ["i915"];
    };

    hardware = {
      enableRedistributableFirmware = true;
      graphics.enable = true;
    };
  };
}
