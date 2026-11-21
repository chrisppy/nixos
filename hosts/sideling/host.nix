{ inputs, ... }:
{
  configurations.nixos.sideling.module =
    { lib, ... }:
    {
      # Pinned to Linux 6.18.63 (nixos-26.05 @ f684076): 6.18.64 backports
      # inode_state_read{,_once}/inode_state_set_raw, which bcachefs-tools 1.39.7
      # redefines for kernels < 6.19, breaking the bcachefs module build.
      # Overrides the mkForce in modules/core/kernel.nix.
      # TODO: drop (and the nixpkgs-kernel input) once bcachefs-tools fixes its guard.
      boot.kernelPackages = lib.mkOverride 40 inputs.nixpkgs-kernel.legacyPackages.x86_64-linux.linuxKernel.packages.linux_6_18;
      documentation.enable = false;
      hardware.facter.reportPath = ./facter.json;
      nixpkgs.hostPlatform = "x86_64-linux";
      system.stateVersion = "26.05";
      time.timeZone = "America/New_York";
    };
}
