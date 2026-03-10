_: {
  flake.modules.nixos.zfs = {
    config,
    lib,
    ...
  }: {
    options.zfs.pools = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of ZFS pools to import and manage.";
    };

    config = {
      boot = {
        supportedFilesystems = ["zfs"];
        boot.zfs.extraPools = config.zfs.pools;
      };
      services.zfs = {
        autoScrub = {
          enable = config.zfs.pools != [];
          inherit (config.zfs) pools;
        };
        trim.enable = true;
      };
    };
  };
}
