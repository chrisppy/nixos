_: {
  configurations.nixos.smoky.module = {
    bcachefs.fileSystems = [ "/persist" ];
    disko.devices = {
      disk.main = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                ];
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "bcachefs";
                filesystem = "smoky";
              };
            };
          };
        };
      };

      bcachefs_filesystems.smoky = {
        type = "bcachefs_filesystem";
        extraFormatArgs = [ "--compression=zstd" ];
        subvolumes = {
          "@nix".mountpoint = "/nix";
          "@persist".mountpoint = "/persist";
          "@home".mountpoint = "/home";
        };
      };

      # Everything else on / is wiped at every boot (see modules/core/preservation.nix)
      nodev."/" = {
        fsType = "tmpfs";
        mountOptions = [
          "mode=755"
          "size=2G"
        ];
      };
    };
  };
}
