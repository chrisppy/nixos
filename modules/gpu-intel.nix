_: {
  flake.modules.nixos.gpu-intel = {
    boot = {
      kernelModules = ["xe"];
      kernelParams = ["xe.force_probe=*"];
      blacklistedKernelModules = ["i915"];
    };
  };
}
