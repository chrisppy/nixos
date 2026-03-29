_: {
  configurations.nixos.smoky.module = {
    networking = {
      hostId = "";
      hostName = "smoky";
    };

    systemd.network.networks."10-lan" = {
      matchConfig.Name = "enp3s0";
      networkConfig.DHCP = "ipv4";
    };
  };
}
