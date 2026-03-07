_: {
  flake.modules.nixos.zswap = {
    zramSwap.enable = true;
    boot = {
      kernelParams = [
        "zswap.enabled=1"
        "zswap.compressor=zstd"
        "zswap.zpool=zsmalloc"
        "zswap.max_pool_percent=25"
      ];
      kernel.sysctl = {
        "vm.swappiness" = 10;
        "vm.page-cluster" = 0;
        "vm.vfs_cache_pressure" = 50;
      };
    };
  };
}
