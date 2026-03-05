# Uses the option in `./nixos.nix` to declare a NixOS configuration.
_: {
  configurations.nixos.sideling.module = {
    hardware.facter.reportPath = ./facter.json;
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "25.11";
    time.timeZone = "America/New_York";
  };
}
