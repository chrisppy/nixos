_: {
  configurations.nixos.smoky.module = {
    bcachefs.fileSystems = ["/"];
    disko.devices.disk.main = {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1M";
            type = "EF02";
          };
          boot-fs = {
            size = "1G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
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
              type = "filesystem";
              format = "bcachefs";
              mountpoint = "/";
              mountOptions = [
                "compression=zstd"
              ];
            };
          };
        };
      };
    };
  };
}
