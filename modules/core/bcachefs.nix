_: {
  flake.modules.nixos.bcachefs =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.bcachefs.fileSystems = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "List of bcachefs filesystems to auto-scrub.";
      };

      config = {
        boot.supportedFilesystems.bcachefs = true;
        services.bcachefs.autoScrub = {
          enable = config.bcachefs.fileSystems != [ ];
          inherit (config.bcachefs) fileSystems;
        };
        environment.systemPackages = [ pkgs.bcachefs-tools ];
      };
    };
}
