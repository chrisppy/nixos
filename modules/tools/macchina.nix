_: {
  flake.modules.homeManager.base = {
    programs.macchina = {
      enable = true;
      settings = {
        show = [
          "Host"
          "Machine"
          "Kernel"
          "Distribution"
          "WindowManager"
          "Packages"
          "Terminal"
          "Uptime"
          "Processor"
          "ProcessorLoad"
          "Memory"
          "GPU"
          "DiskSpace"
        ];
      };
    };
  };
}
