_: {
  configurations.nixos.sideling.module = {
    networking = {
      domain = "palmer.lan";
      hostId = "5954f78e";
      hostName = "sideling";
    };
    
    systemd.network.networks."10-wan" = {
      matchConfig.Name = "enp3s0";
      address = ["192.168.40.232/24"];
      dns = ["192.168.1.1"];
      routes = [{Gateway = "192.168.1.1";}];
    };
  };
}
