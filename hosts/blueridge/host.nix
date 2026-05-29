# Uses the option in `./nixos.nix` to declare a NixOS configuration.
_: {
  configurations.nixos.blueridge.module = {
    hardware.facter.reportPath = ./facter.json;
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
    time.timeZone = "America/New_York";
  };
}
