_: {
  flake.modules.nixos.base = {
    networking = {
      domain = "palmer.lan";
      useNetworkd = true;
    };
    systemd.network.enable = true;
  };
}
