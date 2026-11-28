{ config, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      # No wrapper module for macchina: it reads only ~/.config/macchina.
      users.users.${config.flake.meta.owner.username}.packages = [ pkgs.macchina ];
      home.files.".config/macchina/macchina.toml" = (pkgs.formats.toml { }).generate "macchina.toml" {
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
}
