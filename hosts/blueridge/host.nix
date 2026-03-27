# Uses the option in `./nixos.nix` to declare a NixOS configuration.
_: {
  configurations.nixos.blueridge.module = {
    boot = {
      kernelModules = ["xe"];
      kernelParams = ["xe.force_probe=*"];
      blacklistedKernelModules = ["i915"];
    };
    hardware.facter.reportPath = ./facter.json;
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "25.11";
    time.timeZone = "America/New_York";
  };
}
