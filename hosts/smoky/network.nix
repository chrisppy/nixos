_: {
  configurations.nixos.smoky.module = {
    networking = {
      hostId = "aadc8d2d";
      hostName = "smoky";
      networkmanager.enable = true;
    };

    systemd.network.networks."10-lan" = {
      matchConfig.Name = "enp3s0";
      networkConfig.DHCP = "ipv4";
      linkConfig.RequiredForOnline = "routable";
    };
  };
}
