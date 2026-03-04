_:
{
  flake.modules = {
    nixos.bcachefs = { pkgs, ... }: {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = [
          "bcachefs"
        ];
        kernelModules = [
          "bcachefs"
        ];
      };

      environment.systemPackages = with pkgs; [
        bcachefs-tools
      ];
    };
  };
}
