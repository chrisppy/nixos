_: {
  configurations.nixos.blueridge.module = {
    networking = {
      hostId = "383970e4";
      hostName = "blueridge";
    };

    systemd.network.networks."10-lan" = {
      matchConfig.Name = "enp4s0";
      networkConfig.DHCP = "ipv4";
    };
  };
}
