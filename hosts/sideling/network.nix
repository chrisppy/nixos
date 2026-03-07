_: {
  configurations.nixos.sideling.module = {
    networking = {
      hostId = "5954f78e";
      hostName = "sideling";
    };

    systemd.network.networks."10-lan" = {
      matchConfig.Name = "enp3s0";
      networkConfig.DHCP = "ipv4";
    };
  };
}
