_: {
  flake.modules = {
    nixos.base = {
      systemd = {
        services."nix-daemon".serviceConfig = {
          Slice = "nix-daemon.slice";
          OOMScoreAdjust = 1000;
        };
        slices."nix-daemon".sliceConfig = {
          ManagedOOMMemoryPressure = "kill";
          ManagedOOMMemoryPressureLimit = "95%";
        };
      };
    };
  };
}
