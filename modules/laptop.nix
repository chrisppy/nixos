_: {
  flake.modules.nixos.laptop = {
    services = {
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
      thermald.enable = true;
      upower.enable = true;
    };
  };
}
